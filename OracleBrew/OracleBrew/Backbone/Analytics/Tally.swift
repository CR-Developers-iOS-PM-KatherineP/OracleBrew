import Foundation
import StoreKit

/// The one thing the app talks to about analytics.
///
/// Screens and services call `track`; what happens next — which SDKs are up,
/// which are off for want of a key — is settled here. Swapping a provider is a
/// change to the sinks and nothing else.
///
/// Each provider is a named slot rather than an array, and the fan-out is one
/// explicit line per provider. A `forEach` over a list would be shorter and
/// would hide the thing worth seeing: which providers a given path actually
/// touches, readable without running anything.
@MainActor
final class Tally {
    static let shared = Tally()

    private let appsFlyer = AppsFlyerSink()
    private let appMetrica = AppMetricaSink()
    private let facebook = FacebookSink()
    private let firebase = FirebaseSink()

    /// Held concretely, and apart from the four above: UserAcquisition has no
    /// event API, so it must never end up in the `track` fan-out. Keeping it out
    /// of `AnalyticsSink` is what makes that a compile-time fact rather than a
    /// convention someone has to remember.
    private let userAcquisition = UserAcquisitionSink()

    /// A provider only gets called when its config named it. Resolved once so a
    /// disabled provider costs nothing per event.
    private let active = Set(AnalyticsConfig.activeProviders)

    private var started = false

    private init() {}

    // MARK: Lifecycle

    /// Called once at launch, before any UI.
    func start() {
        guard !started else { return }
        started = true

        wireConversionExchange()

        if active.contains(.appsFlyer) { appsFlyer.start() }
        if active.contains(.appMetrica) { appMetrica.start() }
        if active.contains(.facebook) { facebook.start() }
        if active.contains(.firebase) { firebase.start() }
        if active.contains(.userAcquisition) { userAcquisition.start() }

        // Read after start(): before the SDKs are up these identifiers are empty,
        // and UA wants them alongside the AppsFlyer payload that arrives later.
        if active.contains(.appMetrica) {
            userAcquisition.apply(appMetricaDeviceID: appMetrica.deviceID)
        }
        if active.contains(.facebook) {
            userAcquisition.apply(facebookAnonymousID: facebook.anonymousID)
        }

        log("start — providers: \(AnalyticsConfig.activeProviders.map(\.rawValue).joined(separator: ", "))")
    }

    /// AppsFlyer's install attribution is what UA needs and what the funnel wants
    /// to see. Both hops go through the facade — neither sink reaches for the
    /// other, so a provider can be switched off without the other noticing.
    private func wireConversionExchange() {
        appsFlyer.onConversionData = { [weak self] payload in
            guard let self else { return }
            MainActor.assumeIsolated {
                self.userAcquisition.apply(
                    appsFlyerData: payload,
                    appsFlyerID: self.appsFlyer.appsFlyerID
                )
            }
        }
        appsFlyer.onConversionOutcome = { [weak self] succeeded, payload in
            MainActor.assumeIsolated {
                self?.track(succeeded ? .conversionSucceeded : .conversionFailed, parameters: payload)
            }
        }
    }

    // MARK: Events

    func track(_ event: AnalyticsEvent, parameters: [String: String] = [:]) {
        let name = event.name

        if active.contains(.appsFlyer) { appsFlyer.track(name, parameters: parameters) }
        if active.contains(.appMetrica) { appMetrica.track(name, parameters: parameters) }
        if active.contains(.facebook) { facebook.track(name, parameters: parameters) }
        if active.contains(.firebase) { firebase.track(name, parameters: parameters) }
        // No UserAcquisition here, by design — see the property.

        // One line per event, not one per provider — per-sink prints drown the
        // funnel in noise when four SDKs are live.
        log(parameters.isEmpty ? name : "\(name) \(parameters)")
    }

    // MARK: Purchases

    /// Revenue, kept off the event path because half the providers have a
    /// dedicated API for it and would otherwise report a sale as a plain event.
    ///
    /// Nothing calls this yet: the app has no purchases (`Features.paywall` is
    /// off). It is the single point a purchase service will call from its own
    /// success path — never a screen, so two paywalls can't double-report or
    /// disagree about the name.
    func logPurchase(_ product: SKProduct, name: String) {
        if active.contains(.appsFlyer) { appsFlyer.logPurchase(product, name: name) }
        if active.contains(.appMetrica) { appMetrica.logPurchase(product, name: name) }
        if active.contains(.facebook) { facebook.logPurchase(product, name: name) }
        if active.contains(.firebase) { firebase.logPurchase(product, name: name) }
        if active.contains(.userAcquisition) { userAcquisition.logPurchase(product) }

        let currency = product.priceLocale.currency?.identifier ?? ""
        log("purchase \(name) — \(product.productIdentifier) \(product.price) \(currency)")
    }

    /// The user's answer to the refund-consent prompt. Only UserAcquisition
    /// carries it — it is the thing that talks to the backend about refunds.
    func refund(consented: Bool) {
        guard active.contains(.userAcquisition) else { return }
        userAcquisition.refund(consented: consented)
        log("refund consent — \(consented ? "allowed" : "declined")")
    }

    // MARK: Uninstall measurement

    /// AppsFlyer only. Fires from the push-token callback, so it stays silent
    /// until the app registers for remote notifications.
    func registerUninstall(deviceToken: Data) {
        guard active.contains(.appsFlyer) else { return }
        appsFlyer.registerUninstall(deviceToken: deviceToken)
    }

    private func log(_ message: String) {
        #if DEBUG
        print("📊 [Tally] \(message)")
        #endif
    }
}

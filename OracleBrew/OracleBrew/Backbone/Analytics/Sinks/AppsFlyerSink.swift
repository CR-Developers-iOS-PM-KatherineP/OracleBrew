import AppsFlyerLib
import Foundation
import StoreKit

/// AppsFlyer — attribution and events.
///
/// An `NSObject` because it is also the SDK's delegate: conversion data arrives
/// through `AppsFlyerLibDelegate`, and the facade forwards it to UserAcquisition
/// through the closures below rather than either sink reaching for the other.
final class AppsFlyerSink: NSObject, AnalyticsSink {
    /// The install attribution payload, handed onward for UA's `conversionInfo`.
    var onConversionData: (([String: Any]) -> Void)?
    /// Fires on success *and* failure, so the outcome is visible in the funnel.
    var onConversionOutcome: ((_ succeeded: Bool, _ payload: [String: String]) -> Void)?

    func start() {
        guard AnalyticsConfig.isAppsFlyerReady else {
            Self.logSkip("dev key / app id are still placeholders")
            return
        }

        // 7.x made the dev-key and app-id properties read-only; they are set
        // through initialize(devKey:appId:) now.
        AppsFlyerLib.shared().initialize(
            devKey: AnalyticsConfig.Keys.appsFlyerDevKey,
            appId: AnalyticsConfig.Keys.appsFlyerAppID
        )
        AppsFlyerLib.shared().delegate = self

        // 7.x stopped managing ATT timing itself and deprecated
        // waitForATTUserAuthorization. Instead the SDK hands over a readiness
        // callback and expects the session to be started from inside it — with
        // the ATT answer collected first, or the install is attributed without
        // the IDFA. ATT is explicitly *not* one of its readiness conditions.
        //
        // Beacon rather than ATTrackingManager directly: it is the app's one
        // tracking prompt, and the system only ever shows it once per install,
        // so asking here resolves against whatever the splash already got.
        AppsFlyerLib.shared().registerSessionReadyListener {
            Task {
                await Beacon.request()
                // Through MainActor.run, and not only to start on the main
                // thread: `startWithCompletionHandler:` is imported as an async
                // throwing `start()`, so in an async context Swift picks that
                // overload over the plain one. A synchronous closure resolves it
                // back to the no-argument call the SDK's own guidance describes.
                await MainActor.run { AppsFlyerLib.shared().start() }
            }
        }
    }

    func track(_ name: String, parameters: [String: String]) {
        AppsFlyerLib.shared().logEvent(name, withValues: parameters)
    }

    /// Two calls on purpose: the canonical `af_purchase` keeps AppsFlyer's own
    /// reporting intact, and the second, named by the caller, is what the team's
    /// dashboards read. Dropping either breaks one of the two.
    func logPurchase(_ product: SKProduct, name: String) {
        AppsFlyerLib.shared().logEvent(AFEventPurchase, withValues: ["eventValue": ""])
        AppsFlyerLib.shared().logEvent(name, withValues: [
            "price": product.price.stringValue,
            "currency": product.priceLocale.currency?.identifier ?? ""
        ])
    }

    /// AppsFlyer alone measures uninstalls, so this is not on the protocol — the
    /// facade calls it on this sink directly. It only ever fires if the app
    /// registers for remote notifications.
    func registerUninstall(deviceToken: Data) {
        AppsFlyerLib.shared().registerUninstall(deviceToken)
    }

    var appsFlyerID: String { AppsFlyerLib.shared().getAppsFlyerUID() }

    private static func logSkip(_ reason: String) {
        #if DEBUG
        print("⚠️ [Tally] AppsFlyer skipped — \(reason)")
        #endif
    }
}

extension AppsFlyerSink: AppsFlyerLibDelegate {
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable: Any]) {
        let payload = Dictionary(
            uniqueKeysWithValues: conversionInfo.map { (String(describing: $0.key), $0.value) }
        )
        onConversionData?(payload)
        onConversionOutcome?(true, Self.stringified(payload))
    }

    func onConversionDataFail(_ error: any Error) {
        onConversionOutcome?(false, ["reason": error.localizedDescription])
    }

    /// The whole payload, not a chosen subset — which key explains an install is
    /// not knowable in advance. Values are stringified because that is what the
    /// event API takes; mind that Firebase caps parameter count and length, so
    /// a wide payload arrives trimmed there.
    private static func stringified(_ payload: [String: Any]) -> [String: String] {
        payload.reduce(into: [:]) { out, pair in
            out[pair.key] = String(describing: pair.value)
        }
    }
}

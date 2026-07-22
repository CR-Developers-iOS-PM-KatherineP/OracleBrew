import Foundation

/// The one thing the app talks to about analytics.
///
/// Screens and services call `track`; what happens next — which SDKs are up,
/// which are off for want of a key — is settled here. Swapping a provider is a
/// change to the sinks below and nothing else.
///
/// No SDK is integrated yet, so every sink slot is nil and events only reach
/// the DEBUG console. The fan-out is written out per provider anyway: when the
/// keys land, each sink is assigned in `start()` and the dispatch already
/// names it, so it is readable at a glance which providers a path touches.
@MainActor
final class Tally {
    static let shared = Tally()

    private var appsFlyer: AnalyticsSink?
    private var appMetrica: AnalyticsSink?
    private var facebook: AnalyticsSink?
    private var firebase: AnalyticsSink?

    private var started = false

    private init() {}

    /// Called once at launch, before any UI.
    func start() {
        guard !started else { return }
        started = true

        // Each provider's sink is constructed here once its SDK is integrated.
        // Until then the slots stay nil and the fan-out below is a no-op.

        appsFlyer?.start()
        appMetrica?.start()
        facebook?.start()
        firebase?.start()

        log("start — providers: \(AnalyticsConfig.activeProviders.map(\.rawValue).joined(separator: ", "))")
        if appsFlyer == nil && appMetrica == nil && facebook == nil && firebase == nil {
            log("no SDK integrated yet — events go to the console only")
        }
    }

    func track(_ event: AnalyticsEvent, parameters: [String: String] = [:]) {
        let name = event.name

        appsFlyer?.track(name, parameters: parameters)
        appMetrica?.track(name, parameters: parameters)
        facebook?.track(name, parameters: parameters)
        firebase?.track(name, parameters: parameters)

        // One line per event, not one per provider — per-sink prints drown the
        // funnel in noise when four SDKs are live.
        log(parameters.isEmpty ? name : "\(name) \(parameters)")
    }

    private func log(_ message: String) {
        #if DEBUG
        print("📊 [Tally] \(message)")
        #endif
    }
}

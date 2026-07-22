import Foundation

enum AnalyticsProvider: String, CaseIterable {
    case appsFlyer, appMetrica, facebook, firebase
}

/// Provider switches and credentials, in one place so wiring a real key never
/// means hunting through the sinks.
///
/// Every value here is still a placeholder: no SDK is integrated yet, so
/// nothing reads them. They are declared now so the shape is settled and the
/// day the keys arrive is a one-file change.
enum AnalyticsConfig {
    /// Empty means every provider. Narrow it to run a single SDK in isolation.
    static let enabledProviders: Set<AnalyticsProvider> = []

    static var activeProviders: [AnalyticsProvider] {
        enabledProviders.isEmpty ? AnalyticsProvider.allCases : AnalyticsProvider.allCases.filter(enabledProviders.contains)
    }

    enum Keys {
        static let appsFlyerDevKey = "APPSFLYER_DEV_KEY"
        static let appsFlyerAppID = "APPSFLYER_APP_ID"
        static let appMetricaAPIKey = "APPMETRICA_API_KEY"
        static let facebookAppID = "FACEBOOK_APP_ID"
    }

    /// A credential is usable once it is neither empty nor still the
    /// placeholder. Sinks gate their `start()` on this so a half-configured
    /// build runs fine with that provider simply off, and says so in the log.
    static func isFilled(_ value: String) -> Bool {
        !value.isEmpty && value != value.uppercased().replacingOccurrences(of: " ", with: "_")
    }
}

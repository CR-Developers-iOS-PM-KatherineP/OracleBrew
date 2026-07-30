import Foundation

enum AnalyticsProvider: String, CaseIterable {
    case appsFlyer, appMetrica, facebook, firebase, userAcquisition
}

/// Provider switches and credentials, in one place so wiring a real key never
/// means hunting through the sinks.
///
/// Every credential here is still the placeholder it shipped as. The SDKs are
/// integrated, but each sink checks its own readiness in `start()` and stays off
/// rather than firing at nothing — so a build with this file untouched runs fine
/// and the console says what each provider is waiting for.
enum AnalyticsConfig {
    /// Empty means every provider. Narrow it to run a single SDK in isolation.
    static let enabledProviders: Set<AnalyticsProvider> = []

    static var activeProviders: [AnalyticsProvider] {
        enabledProviders.isEmpty ? AnalyticsProvider.allCases : AnalyticsProvider.allCases.filter(enabledProviders.contains)
    }

    /// Replace a value here to turn its provider on.
    enum Keys {
        static let appsFlyerDevKey = "APPSFLYER_DEV_KEY"
        static let appsFlyerAppID = "APPSFLYER_APP_ID"
        static let appMetricaAPIKey = "APPMETRICA_API_KEY"
        static let facebookAppID = "FACEBOOK_APP_ID"
    }

    /// UserAcquisition reports to its own backend, so it carries a host as well
    /// as a key. `sharedSecret` is the App Store shared secret that receipt
    /// validation needs.
    enum UserAcquisition {
        static let apiKey = "USER_ACQUISITION_API_KEY"
        /// Host only — the service prepends `https://` and appends the path.
        static let serverUrl = "USER_ACQUISITION_SERVER_URL"
        static let sharedSecret = "USER_ACQUISITION_SHARED_SECRET"
    }

    // MARK: Readiness

    static var isAppsFlyerReady: Bool {
        isFilled(Keys.appsFlyerDevKey, placeholder: Shipped.appsFlyerDevKey)
            && isFilled(Keys.appsFlyerAppID, placeholder: Shipped.appsFlyerAppID)
    }

    static var isAppMetricaReady: Bool {
        isFilled(Keys.appMetricaAPIKey, placeholder: Shipped.appMetricaAPIKey)
    }

    /// Facebook reads its App ID from Info.plist, not from us — the SDK asserts
    /// at launch if the key is absent. Ours is checked too so the two can't
    /// disagree about whether the provider is configured.
    static var isFacebookReady: Bool {
        guard isFilled(Keys.facebookAppID, placeholder: Shipped.facebookAppID) else { return false }
        let fromPlist = Bundle.main.object(forInfoDictionaryKey: "FacebookAppID") as? String ?? ""
        return isFilled(fromPlist, placeholder: Shipped.facebookAppID)
    }

    /// Firebase has no key of ours — it reads `GoogleService-Info.plist`, and
    /// `FirebaseApp.configure()` traps when that file is missing.
    static var isFirebaseReady: Bool {
        Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") != nil
    }

    static var isUserAcquisitionReady: Bool {
        isFilled(UserAcquisition.apiKey, placeholder: Shipped.userAcquisitionAPIKey)
            && isFilled(UserAcquisition.serverUrl, placeholder: Shipped.userAcquisitionServerUrl)
    }

    // MARK: Placeholders

    /// The values the credentials above were born with. Kept apart from them on
    /// purpose: "is this key set?" means "has someone changed it since?", and
    /// answering that needs both halves. Editing a key above without editing the
    /// twin here is what turns the provider on — that is the whole mechanism.
    private enum Shipped {
        static let appsFlyerDevKey = "APPSFLYER_DEV_KEY"
        static let appsFlyerAppID = "APPSFLYER_APP_ID"
        static let appMetricaAPIKey = "APPMETRICA_API_KEY"
        static let facebookAppID = "FACEBOOK_APP_ID"
        static let userAcquisitionAPIKey = "USER_ACQUISITION_API_KEY"
        static let userAcquisitionServerUrl = "USER_ACQUISITION_SERVER_URL"
    }

    /// A credential counts as filled once it is neither empty nor still the
    /// placeholder it shipped as.
    ///
    /// The placeholder is passed in rather than inferred from the value's shape.
    /// Guessing — "a real key wouldn't be all caps and underscores" — reads fine
    /// until a real credential happens to look like that: a Facebook App ID is
    /// all digits, equals its own uppercased form, and would be dismissed as a
    /// placeholder, leaving that sink permanently and silently off.
    static func isFilled(_ value: String, placeholder: String) -> Bool {
        !value.isEmpty && value != placeholder
    }
}

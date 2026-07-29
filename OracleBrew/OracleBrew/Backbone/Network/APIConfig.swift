import Foundation

enum APIConfig {
    /// Trailing slash matters — the backend redirects otherwise.
    static let baseURL = URL(string: "https://predict.oraclebrew.app/api/")!

    /// The docs use `Authorization: Token <token>`, not `Bearer`.
    static func authValue(for token: String) -> String { "Token \(token)" }

    static let pageSize = 12

    /// Where the legal texts are published. The app shows its own bundled copy
    /// of each; these are the canonical sources, kept here so pointing at a new
    /// one is a config change rather than a code change.
    static let privacyPolicyURL = URL(
        string: "https://docs.google.com/document/d/1UTYUkZ7LItyBKgXklvx4X1LNM-CCbhVCaLCPZGF6Nfc/edit?tab=t.0"
    )!
    static let termsOfUseURL = URL(
        string: "https://docs.google.com/document/d/1v_PNKqwX3sfgWbtcS8SnDXIuubQaU7QjaLBPOvnMTgk/edit?tab=t.0"
    )!

    /// Where support mail goes. Named here because the legal texts print it too —
    /// one address to change, not three.
    static let supportEmail = "support@oraclebrew.app"
    static var supportMailURL: URL { URL(string: "mailto:\(supportEmail)")! }

    /// The language the app resolved to, as an `Accept-Language` value. Taken
    /// from the bundle rather than `Locale.current` — the bundle is what
    /// actually decided which strings the user is reading, and the two disagree
    /// when the device language has no localization here.
    static var preferredLanguage: String {
        "\(replyLanguage), en;q=0.8"
    }

    /// Bare ISO 639 code for request bodies that name the language outright —
    /// the chat asks the oracle to answer in it. Same source as the header, so
    /// the reply matches the language the UI is running in.
    static var replyLanguage: String {
        Bundle.main.preferredLocalizations.first.map { String($0.prefix(2)) } ?? "en"
    }
}

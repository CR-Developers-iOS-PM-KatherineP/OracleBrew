import Foundation

enum APIConfig {
    /// Trailing slash matters — the backend redirects otherwise.
    static let baseURL = URL(string: "https://predict.oraclebrew.app/api/")!

    /// The docs use `Authorization: Token <token>`, not `Bearer`.
    static func authValue(for token: String) -> String { "Token \(token)" }

    static let pageSize = 12

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

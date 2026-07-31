import Foundation

/// Parses the backend's timestamps.
///
/// The API stamps with fractional seconds ("…T12:40:29.686672Z"), and a plain
/// `ISO8601DateFormatter` rejects those outright — which is how every chat row
/// managed to say "now" and history rows fell back to today. One parser, tried
/// fraction-first, so no call site repeats that mistake.
enum APIDate {
    private static let fractional: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    private static let plain = ISO8601DateFormatter()

    static func parse(_ string: String?) -> Date? {
        guard let string else { return nil }
        return fractional.date(from: string) ?? plain.date(from: string)
    }
}

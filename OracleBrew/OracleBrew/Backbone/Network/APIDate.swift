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

extension Date {
    /// "July 30, 2026" — the way a reading's date is written on cards.
    ///
    /// Gregorian, pinned. A bare `.formatted(.dateTime…)` takes the locale's
    /// calendar, and under ar_SA that rewrote July 30 as 16 Safar 1448 — a
    /// Hijri date next to readings the app itself stamps in Gregorian. The
    /// month name still translates; the locale carries that.
    var readingLabel: String {
        var style = Date.FormatStyle(locale: .current,
                                     calendar: Calendar(identifier: .gregorian),
                                     timeZone: .current)
        style = style.day().month(.wide).year()
        return formatted(style)
    }
}

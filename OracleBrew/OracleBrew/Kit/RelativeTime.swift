import Foundation

enum RelativeTime {
    static func short(_ date: Date, now: Date = Date()) -> String {
        let seconds = now.timeIntervalSince(date)
        switch seconds {
        case ..<60:
            return String(localized: "time.now")
        case ..<3600:
            return String(localized: "time.minutes \(Int(seconds / 60))")
        case ..<86_400:
            return String(localized: "time.hours \(Int(seconds / 3600))")
        case ..<604_800:
            return String(localized: "time.days \(Int(seconds / 86_400))")
        default:
            // Gregorian, pinned — the locale's calendar would print a Hijri
            // day under ar_SA next to timestamps the app keeps in Gregorian.
            var style = Date.FormatStyle(locale: .current,
                                         calendar: Calendar(identifier: .gregorian),
                                         timeZone: .current)
            style = style.day().month(.abbreviated)
            return date.formatted(style)
        }
    }
}

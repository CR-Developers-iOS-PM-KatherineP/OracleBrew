import SwiftUI

/// Which of the profile form's dropdowns is open. Only one may be at a time, so
/// the fields share this rather than each tracking its own.
enum ProfileField: Hashable { case day, month, year, relationship, country }

/// Date of birth as three dropdowns, with the zodiac it implies underneath.
///
/// Its own file because it is the form's heaviest field by far: three dropdowns,
/// the month-name and year lists, and the rule that Feb 30 can't survive a month
/// change. None of that is the rest of the form's business.
struct ProfileBirthField: View {
    @Binding var day: Int?
    @Binding var month: Int?
    @Binding var year: Int?
    @Binding var open: ProfileField?

    private var zodiac: Zodiac? {
        guard let day, let month else { return nil }
        return Zodiac.from(day: day, month: month)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ProfileSectionLabel(title: "profile.dob")

            HStack(alignment: .top, spacing: 10) {
                // Localized hints, not the latin DD/MM/YYYY — those read as
                // English in the Arabic build.
                dropdown(.day, value: day.map(String.init),
                         placeholder: String(localized: "profile.dob.day"),
                         items: Array(1...daysInSelectedMonth)) { day = $0 }
                dropdown(.month, value: month.map { Self.monthNames[$0 - 1] },
                         placeholder: String(localized: "profile.dob.month"),
                         items: Array(1...12), label: { Self.monthNames[$0 - 1] }) { month = $0 }
                dropdown(.year, value: year.map(String.init),
                         placeholder: String(localized: "profile.dob.year"),
                         items: Self.years) { year = $0 }
            }
            .zIndex(1)

            if let zodiac {
                Text("profile.zodiac.value \(zodiac.glyph) \(zodiac.name)")
                    .font(Lettering.displayMedium(14))
                    .foregroundStyle(Pigment.accent)
            } else {
                Text("profile.zodiac.empty")
                    .font(Lettering.displayMedium(14))
                    .foregroundStyle(Pigment.fieldMuted)
            }
        }
    }

    /// One of the three dropdowns. `IntBox` wraps the Int so it satisfies
    /// DropdownOverlay's Identifiable requirement.
    private func dropdown(
        _ field: ProfileField,
        value: String?,
        placeholder: String,
        items: [Int],
        label: @escaping (Int) -> String = { String($0) },
        onPick: @escaping (Int) -> Void
    ) -> some View {
        let boxes = items.map(IntBox.init)
        let isOpen = open == field
        return VStack(spacing: 4) {
            Button { open = isOpen ? nil : field } label: {
                ProfileFieldBox(radius: 10) {
                    HStack(spacing: 0) {
                        Text(value ?? placeholder)
                            .font(Lettering.display(14))
                            .foregroundStyle(value == nil ? Pigment.fieldMuted : Pigment.cream)
                            .lineLimit(1)
                        Spacer(minLength: 4)
                        DropdownChevron(isOpen: isOpen)
                    }
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            if isOpen {
                DropdownOverlay(
                    items: boxes,
                    isSelected: { box in value == label(box.value) },
                    onPick: { box in
                        Resonance.select()
                        onPick(box.value)
                        clampDayIfNeeded()
                        open = nil
                    },
                    label: { box in
                        Text(label(box.value))
                            .font(Lettering.display(14))
                            .foregroundStyle(Pigment.cream)
                    }
                )
            }
        }
    }

    private struct IntBox: Identifiable { let value: Int; var id: Int { value } }

    /// Feb 30 shouldn't survive a month change.
    private func clampDayIfNeeded() {
        if let day, day > daysInSelectedMonth { self.day = daysInSelectedMonth }
    }

    private var daysInSelectedMonth: Int {
        guard let month else { return 31 }
        var components = DateComponents()
        components.year = year ?? 2000
        components.month = month
        let calendar = Calendar(identifier: .gregorian)
        guard let date = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: date) else { return 31 }
        return range.count
    }

    /// A bare Calendar(identifier:) carries no locale, and monthSymbols then
    /// yields "M01"…"M12" instead of month names — so set the locale.
    private static let monthNames: [String] = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = .current
        return calendar.monthSymbols
    }()
    private static let years: [Int] = {
        let current = Calendar.current.component(.year, from: Date())
        return Array((current - 100)...(current - 13)).reversed()
    }()
}

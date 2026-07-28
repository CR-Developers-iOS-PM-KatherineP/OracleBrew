import SwiftUI

/// Country as a searchable dropdown.
///
/// Its own file because it is the only field that searches: it owns the query and
/// the keyboard focus, which the form otherwise had to carry for it. The list is
/// long, so the search field takes focus the moment the dropdown opens rather
/// than needing a second tap.
struct ProfileCountryField: View {
    @Binding var countryCode: String?
    @Binding var open: ProfileField?

    @State private var query = ""
    @FocusState private var searchFocused: Bool

    private var isOpen: Bool { open == .country }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ProfileSectionLabel(title: "profile.country")
            VStack(spacing: 4) {
                Button { open = isOpen ? nil : .country } label: {
                    ProfileFieldBox {
                        HStack(spacing: 8) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(Pigment.fieldMuted)
                            if isOpen {
                                TextField("", text: $query, prompt: prompt)
                                    .font(Lettering.display(15))
                                    .foregroundStyle(Pigment.cream)
                                    .tint(Pigment.accent)
                                    .autocorrectionDisabled()
                                    .focused($searchFocused)
                            } else if let country = CountryCatalog.named(countryCode) {
                                Text("\(country.flag) \(country.name)")
                                    .font(Lettering.display(15))
                                    .foregroundStyle(Pigment.cream)
                                    .lineLimit(1)
                            } else {
                                Text("profile.country.placeholder")
                                    .font(Lettering.display(15))
                                    .foregroundStyle(Pigment.fieldMuted)
                            }
                            Spacer(minLength: 0)
                            DropdownChevron(isOpen: isOpen)
                        }
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)

                if isOpen {
                    DropdownOverlay(
                        items: CountryCatalog.search(query),
                        isSelected: { countryCode == $0.id },
                        onPick: { country in
                            countryCode = country.id
                            query = ""
                            open = nil
                        },
                        label: { country in
                            Text("\(country.flag) \(country.name)")
                                .font(Lettering.display(14))
                                .foregroundStyle(countryCode == country.id ? Pigment.accent : Pigment.cream)
                                .lineLimit(1)
                        }
                    )
                }
            }
        }
        .zIndex(isOpen ? 1 : 0)
        // Follows whichever field is open: taking focus when it becomes this one,
        // and dropping the half-typed query when another field takes over.
        .onChange(of: open) { _, field in
            searchFocused = field == .country
            if field != .country { query = "" }
        }
    }

    private var prompt: Text {
        Text("profile.country.placeholder").foregroundColor(Pigment.fieldMuted)
    }
}

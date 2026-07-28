import SwiftUI

struct ProfileView: View {
    @Environment(UserProfileStore.self) private var store
    let onBack: () -> Void
    let onSaved: () -> Void

    @State private var draft = UserProfile()
    @State private var loaded = false
    /// Which dropdown is open. Shared with the birth and country fields so
    /// only one is ever open at a time.
    @State private var openField: ProfileField?
    @State private var saveFailed = false

    private let fadeHeight: CGFloat = 80
    private let saveBarHeight: CGFloat = 60

    var body: some View {
        ZStack(alignment: .top) {
            Pigment.background.ignoresSafeArea()

            VStack(spacing: 0) {
                header
                form
            }
        }
        .overlay(alignment: .bottom) { saveBar }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            guard !loaded else { return }
            draft = store.profile
            loaded = true
        }
        .alert("profile.save_failed.title", isPresented: $saveFailed) {
            Button("common.ok", role: .cancel) {}
        } message: {
            Text("profile.save_failed.message")
        }
    }

    private func save() {
        Resonance.commit()
        Task {
            do {
                try await store.save(draft)
                Resonance.success()
                onSaved()
            } catch {
                Resonance.failure()
                saveFailed = true
            }
        }
    }

    // MARK: Header

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 12) {
                Button(action: onBack) {
                    Image(systemName: "arrow.backward")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Pigment.cream)
                        .frame(width: Cadence.tapTarget, height: Cadence.tapTarget)
                        .background(Circle().fill(Pigment.surface))
                }
                .buttonStyle(.plain)

                Text("profile.title")
                    .font(Lettering.displaySemibold(28))
                    .foregroundStyle(Pigment.cream)
                Spacer(minLength: 0)
            }

            Text("profile.subtitle")
                .font(Lettering.body(12))
                .foregroundStyle(Pigment.cream.opacity(0.6))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 24)
        .padding(.top, 12)
        .padding(.bottom, 20)
    }

    // MARK: Form

    private var form: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                nameSection
                identitySection
                ProfileBirthField(day: $draft.birthDay, month: $draft.birthMonth,
                                  year: $draft.birthYear, open: $openField)
                relationshipSection
                employmentSection
                ProfileCountryField(countryCode: $draft.countryCode, open: $openField)
                childrenSection
                interestsSection
            }
            .padding(.horizontal, 20)
            .padding(.bottom, saveBarHeight + 40)
        }
        .scrollDismissesKeyboard(.interactively)
    }

    private var nameSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            ProfileSectionLabel(title: "profile.name")
            ProfileFieldBox {
                TextField("", text: $draft.name, prompt: namePrompt)
                    .font(Lettering.display(14))
                    .foregroundStyle(Pigment.cream)
                    .tint(Pigment.accent)
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled()
            }
        }
    }

    private var namePrompt: Text {
        Text("profile.name.placeholder").foregroundColor(Pigment.fieldMuted)
    }

    private var identitySection: some View {
        VStack(alignment: .leading, spacing: 10) {
            ProfileSectionLabel(title: "profile.identity")
            HStack(spacing: 8) {
                ForEach(Identity.allCases) { option in
                    ProfileChip(label: option.label, isSelected: draft.identity == option) {
                        draft.identity = draft.identity == option ? nil : option
                    }
                }
            }
        }
    }

    private var relationshipSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            ProfileSectionLabel(title: "profile.relationship")
            VStack(spacing: 4) {
                Button { toggle(.relationship) } label: {
                    ProfileFieldBox {
                        HStack(spacing: 0) {
                            Text(draft.relationship?.label ?? String(localized: "profile.relationship.placeholder"))
                                .font(Lettering.display(15))
                                .foregroundStyle(draft.relationship == nil ? Pigment.fieldMuted : Pigment.cream)
                            Spacer()
                            DropdownChevron(isOpen: openField == .relationship)
                        }
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)

                if openField == .relationship {
                    DropdownOverlay(
                        items: RelationshipStatus.allCases,
                        isSelected: { draft.relationship == $0 },
                        onPick: { Resonance.select(); draft.relationship = $0; openField = nil },
                        label: { option in
                            Text(option.label)
                                .font(Lettering.display(14))
                                .foregroundStyle(draft.relationship == option ? Pigment.accent : Pigment.cream)
                        }
                    )
                }
            }
        }
        .zIndex(openField == .relationship ? 1 : 0)
    }

    private var employmentSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            ProfileSectionLabel(title: "profile.employment")
            // 5 options: 3 across, then 2 centred — matching the design. The
            // second row's chips are sized off the first row's column width so
            // both rows stay aligned on every diagonal.
            GeometryReader { geo in
                let columnWidth = (geo.size.width - 16) / 3
                VStack(spacing: 8) {
                    HStack(spacing: 8) {
                        ForEach(Employment.allCases.prefix(3)) { option in
                            chip(option).frame(width: columnWidth)
                        }
                    }
                    HStack(spacing: 8) {
                        ForEach(Employment.allCases.suffix(2)) { option in
                            chip(option).frame(width: columnWidth)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: Cadence.tapTarget * 2 + 8)
        }
    }

    private func chip(_ option: Employment) -> some View {
        ProfileChip(label: option.label, isSelected: draft.employment == option) {
            draft.employment = draft.employment == option ? nil : option
        }
    }

    private var childrenSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            ProfileSectionLabel(title: "profile.children")
            HStack(spacing: 8) {
                ForEach(ChildrenStatus.allCases) { option in
                    ProfileChip(label: option.label, isSelected: draft.children == option) {
                        draft.children = draft.children == option ? nil : option
                    }
                }
            }
        }
    }

    private var interestsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            ProfileSectionLabel(title: "profile.interests")
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3), spacing: 8) {
                ForEach(InterestCatalog.all) { interest in
                    InterestChip(interest: interest, isSelected: draft.interests.contains(interest.id)) {
                        if draft.interests.contains(interest.id) {
                            draft.interests.remove(interest.id)
                        } else {
                            draft.interests.insert(interest.id)
                        }
                    }
                }
            }
        }
    }

    // MARK: Save

    private var saveBar: some View {
        Button(action: save) {
            ZStack {
                Text("profile.save")
                    .font(Lettering.displayMedium(18))
                    .foregroundStyle(Pigment.cream)
                    .opacity(store.isSaving ? 0 : 1)
                if store.isSaving {
                    ProgressView().tint(Pigment.cream)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: saveBarHeight)
            .background(Capsule().fill(Pigment.accentGradient))
            .opacity(canSave ? 1 : 0.4)
            .contentShape(Capsule())
        }
        .buttonStyle(.plain)
        .disabled(!canSave || store.isSaving)
        .padding(.horizontal, 20)
        .padding(.top, fadeHeight)
        .background(
            // Fades the form out above the button, then stays solid behind and
            // below it — the solid part runs past the safe area, otherwise
            // content scrolling under the home indicator shows through.
            LinearGradient(
                stops: [
                    .init(color: Pigment.background.opacity(0), location: 0),
                    .init(color: Pigment.background, location: fadeHeight / (fadeHeight + saveBarHeight)),
                    .init(color: Pigment.background, location: 1),
                ],
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea(edges: .bottom)
            .allowsHitTesting(false)
        )
    }

    /// The name is what the rest of the app reads, so it gates Save.
    private var canSave: Bool {
        !draft.name.trimmingCharacters(in: .whitespaces).isEmpty
    }

    // MARK: Helpers

    private func toggle(_ field: ProfileField) {
        openField = openField == field ? nil : field
    }

}

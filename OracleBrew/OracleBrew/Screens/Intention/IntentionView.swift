import SwiftUI

struct IntentionView: View {
    @Environment(ReadingDraft.self) private var draft
    @Environment(CatalogStore.self) private var catalog
    let onContinue: () -> Void
    let onBack: () -> Void
    let onClose: () -> Void

    @FocusState private var questionFocused: Bool

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)

    var body: some View {
        @Bindable var draft = draft

        return ZStack(alignment: .top) {
            Pigment.background.ignoresSafeArea()

            VStack(spacing: 0) {
                FlowHeader(
                    title: "intention.title",
                    subtitle: "intention.subtitle",
                    step: 3,
                    onBack: onBack,
                    onClose: onClose
                )
                .padding(.top, 4)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        section("intention.horizon") {
                            SegmentedSelector(
                                items: TimeHorizon.allCases,
                                selection: $draft.horizon
                            ) { $0.titleKey }
                            .onChange(of: draft.horizon) { _, horizon in
                                Tally.shared.track(.horizonPicked,
                                                   parameters: [AnalyticsEvent.Parameter.horizon: horizon.rawValue])
                            }
                        }

                        section("intention.topics") {
                            LazyVGrid(columns: columns, spacing: 8) {
                                ForEach(catalog.topics) { topic in
                                    TopicButton(topic: topic, isSelected: draft.topic == topic) {
                                        Resonance.select()
                                        draft.topic = topic
                                        Tally.shared.track(.topicPicked,
                                                           parameters: [AnalyticsEvent.Parameter.topic: topic.id])
                                    }
                                }
                            }
                        }

                        section("intention.question") {
                            questionField(text: $draft.question)
                        }
                    }
                    .padding(.top, 20)
                }
                .scrollDismissesKeyboard(.interactively)
                // safeAreaInset, not a ZStack overlay with a reserved 110pt of
                // bottom padding. As an overlay the button floated over the scroll
                // content, and when the keyboard raised both of them it landed on
                // the question field — the last row — and hid it. An inset is part
                // of the ScrollView's own geometry: it contributes exactly its
                // height to the content inset, so the focused field scrolls into
                // the space that's left instead of under the button.
                .safeAreaInset(edge: .bottom) {
                    if draft.topic != nil {
                        PrimaryButton(title: "flow.continue") {
                            if !draft.question.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                Tally.shared.track(.questionEntered)
                            }
                            onContinue()
                        }
                            .padding(.bottom, 8)
                            .background(
                                LinearGradient(colors: [Pigment.background.opacity(0), Pigment.background],
                                               startPoint: .top, endPoint: .bottom)
                                .frame(height: 120).allowsHitTesting(false),
                                alignment: .bottom
                            )
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear { Tally.shared.track(.intentionShown) }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("common.done") { questionFocused = false }
            }
        }
    }

    private func section<Content: View>(
        _ title: LocalizedStringKey,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(Lettering.bodyMedium(12))
                .textCase(.uppercase)
                .foregroundStyle(Pigment.cream.opacity(0.2))
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func questionField(text: Binding<String>) -> some View {
        ZStack(alignment: .topLeading) {
            if text.wrappedValue.isEmpty {
                Text("intention.question.placeholder")
                    .font(Lettering.body(15))
                    .foregroundStyle(Pigment.cream.opacity(0.4))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .allowsHitTesting(false)
            }
            TextEditor(text: text)
                .font(Lettering.body(15))
                .foregroundStyle(Pigment.cream)
                // Without a tint the caret falls back to the system blue, which
                // on this card looks like a stray artefact rather than a cursor.
                .tint(Pigment.accent)
                .scrollContentBackground(.hidden)
                .focused($questionFocused)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
        }
        .frame(height: 90)
        .background(RoundedRectangle(cornerRadius: 20).fill(Pigment.card))
        // The border carries the focus state: at rest it is the design's faint
        // accent, and on focus it goes full strength and slightly thicker. A
        // border that never changes leaves a tap on the field with no answer —
        // which is what read as "the input isn't there".
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Pigment.accent.opacity(questionFocused ? 1 : 0.4),
                              lineWidth: questionFocused ? 1.5 : 1)
        )
        .animation(.easeOut(duration: 0.15), value: questionFocused)
    }
}

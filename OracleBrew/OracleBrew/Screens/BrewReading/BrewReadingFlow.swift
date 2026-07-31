import SwiftUI

enum ReadingStep: Hashable {
    case tellers, intention, photo, loading, result, chat
}

struct BrewReadingFlow: View {
    let onClose: () -> Void

    @Environment(ChatSessionStore.self) private var chatStore
    @State private var draft = ReadingDraft()
    @State private var path = NavigationPath()
    @State private var readingError: EmissaryFailure?

    var body: some View {
        NavigationStack(path: $path) {
            DrinkSelectionView(
                onContinue: { path.append(ReadingStep.tellers) },
                onClose: onClose
            )
            .navigationDestination(for: ReadingStep.self, destination: step)
            .navigationDestination(for: FortuneTeller.self) { teller in
                TellerProfileView(
                    teller: teller,
                    onContinue: {
                        draft.teller = teller
                        path.append(ReadingStep.intention)
                    },
                    onBack: pop
                )
            }
            .navigationDestination(for: TellerPeek.self) { peek in
                TellerProfileView(teller: peek.teller, onBack: pop)
            }
        }
        .environment(draft)
        // Its own toast layer, because this flow is presented as a
        // fullScreenCover — a separate presentation layer above the root's
        // hierarchy. The one in Atrium draws underneath it, so every toast raised
        // in here (a saved card, a photo that wouldn't load) was invisible.
        .toastLayer()
        // "No cup in that photo" gets its own words. It is the one failure here
        // the user can fix, and the generic "something went wrong" told them
        // nothing about how — the flow has already dropped them back on the photo
        // step, so the message only has to say what to change.
        .alert(readingErrorTitle, isPresented: showReadingError) {
            Button("common.ok", role: .cancel) {}
        } message: {
            Text(readingErrorMessage)
        }
    }

    private var readingErrorTitle: LocalizedStringKey {
        readingError?.isCupNotFound == true ? "reading.no_cup.title" : "reading.failed.title"
    }

    private var readingErrorMessage: LocalizedStringKey {
        if readingError?.isCupNotFound == true { return "reading.no_cup.message" }
        return readingError?.isOffline == true ? "reading.failed.offline" : "reading.failed.message"
    }

    private var showReadingError: Binding<Bool> {
        Binding(get: { readingError != nil }, set: { if !$0 { readingError = nil } })
    }

    @ViewBuilder
    private func step(_ step: ReadingStep) -> some View {
        // On the wizard steps the ✕ goes one step back, not out of the flow —
        // the design's cross is a retreat, and killing three screens of
        // progress from step four was how testers read it as a bug. Leaving
        // stays one tap per step. The first step and the result keep ✕ as the
        // exit: there is nothing behind the one, and un-reading a finished cup
        // makes no sense on the other.
        switch step {
        case .tellers:
            FortuneTellersView(
                onContinue: { path.append(ReadingStep.intention) },
                onOpenProfile: { path.append($0) },
                onBack: pop,
                onClose: pop
            )
        case .intention:
            IntentionView(
                onContinue: { path.append(ReadingStep.photo) },
                onBack: pop,
                onClose: pop
            )
        case .photo:
            // Random Cup shows a bundled cup photo rather than asking for one —
            // same step in the wizard, different source.
            if draft.isRandomPath {
                RandomCupView(
                    onContinue: { path.append(ReadingStep.loading) },
                    onBack: pop,
                    onClose: pop
                )
            } else {
                PhotoUploadView(
                    onContinue: { path.append(ReadingStep.loading) },
                    onBack: pop,
                    onClose: pop
                )
            }
        case .loading:
            // Swap for the result rather than pushing on top of it — the reading
            // is the destination, and going back from it belongs at the photo
            // step, not at a spinner that would immediately run again.
            ReadingLoadingView(
                onDone: {
                    Resonance.success()
                    path.removeLast()
                    path.append(ReadingStep.result)
                },
                onFailure: { failure in
                    Resonance.failure()
                    path.removeLast()          // back to the photo step
                    readingError = failure
                }
            )
        case .result:
            ReadingResultView(
                onAskOracle: { path.append(ReadingStep.chat) },
                onClose: onClose
            )
        case .chat:
            let teller = draft.teller ?? FortuneTellerRoster.all[0]
            OracleChatView(
                thread: chatStore.thread(for: teller, context: draft),
                onClose: onClose,
                onOpenProfile: { path.append(TellerPeek(teller: teller)) },
                onReturnToReading: pop
            )
        }
    }

    private func pop() {
        if !path.isEmpty { path.removeLast() }
    }
}

/// Temporary stand-in for a not-yet-built flow step.
struct FlowStub: View {
    let title: LocalizedStringKey
    let onClose: () -> Void

    var body: some View {
        ZStack {
            Pigment.background.ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    Button(action: onClose) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Pigment.cream)
                            .frame(width: Cadence.tapTarget, height: Cadence.tapTarget)
                            .background(Circle().fill(Pigment.surface))
                    }
                    .buttonStyle(.plain)
                }
                Spacer()
                Text(title)
                    .font(Lettering.displayMedium(24))
                    .foregroundStyle(Pigment.cream)
                Spacer()
            }
            .padding(20)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

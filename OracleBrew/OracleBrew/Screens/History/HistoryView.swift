import SwiftUI

struct HistoryView: View {
    @Environment(ReadingHistoryStore.self) private var historyStore
    @Environment(ChatSessionStore.self) private var chatStore
    @Bindable var router: Pathfinder

    @State private var showReadingFlow = false
    /// Card awaiting the "really delete?" confirmation.
    @State private var itemToDelete: HistoryItem?
    private let tabClearance: CGFloat = 96
    /// Button height plus the gap under the last card.
    private let ctaClearance: CGFloat = 72

    private var hasReadings: Bool {
        if case .content(let items) = historyStore.phase { return !items.isEmpty }
        return false
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack(alignment: .top) {
                Pigment.background.ignoresSafeArea()

                VStack(spacing: 0) {
                    header
                    content
                }
                .padding(.horizontal, 20)
                .padding(.top, 4)
                // The list stops above the CTA rather than scrolling under it —
                // the button is opaque and would clip the last card.
                .padding(.bottom, tabClearance + (hasReadings ? ctaClearance : 0))
            }
            .overlay(alignment: .bottom) {
                // Only once there are readings. The empty state carries its own CTA.
                if hasReadings {
                    PrimaryButton(title: "drink.title") { showReadingFlow = true }
                        .padding(.horizontal, 20)
                        .padding(.bottom, tabClearance)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .onAppear { Tally.shared.track(.historyShown) }
            .waypointDestinations(router)
            .navigationDestination(for: HistoryItem.self) { item in
                HistoryReplayView(
                    item: item,
                    onAskOracle: {
                        router.path.append(chatStore.thread(for: item.teller, context: makeDraft(item)))
                    },
                    onClose: router.pop
                )
            }
            .navigationDestination(for: ChatThread.self) { thread in
                OracleChatView(
                    thread: thread,
                    onClose: router.pop,
                    onOpenProfile: { router.path.append(TellerPeek(teller: thread.teller)) },
                    onReturnToReading: router.pop
                )
            }
            .navigationDestination(for: TellerPeek.self) { peek in
                TellerProfileView(teller: peek.teller, onBack: router.pop)
            }
        }
        .environment(router)
        .fullScreenCover(isPresented: $showReadingFlow) {
            BrewReadingFlow {
                showReadingFlow = false
                // A reading cast from here belongs at the top of the list.
                Task { await historyStore.refresh() }
            }
        }
        // Quiet refreshes, both of them — loadFirst tears the list down to a
        // spinner, and re-entering the tab made the tiles jump.
        .task { await historyStore.refresh() }
        .onChange(of: router.path.isEmpty) { _, atRoot in
            // Back at the list — refresh so a chat begun from a replay's Ask
            // Your Oracle shows its chip (the server sets has_chat the moment
            // the chat exists).
            if atRoot { Task { await historyStore.refresh() } }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch historyStore.phase {
        case .loading:
            loadingState
        case .content(let items):
            if items.isEmpty { emptyState } else { list(items) }
        case .loadFailure, .offline:
            ScreenStateView(
                kind: historyStore.phase.isOffline ? .offline : .failure,
                retry: { Task { await historyStore.loadFirst() } }
            )
        }
    }

    // A List for the same reason as the Chats tab: swipe-to-delete lives on
    // List rows, and it mirrors itself under RTL for free.
    private func list(_ items: [HistoryItem]) -> some View {
        List {
            ForEach(items) { item in
                HistoryCard(item: item, onOpenChat: {
                    Tally.shared.track(.historyChatOpened)
                    router.path.append(chatStore.thread(for: item.teller, context: makeDraft(item)))
                })
                .contentShape(Rectangle())
                .onTapGesture {
                    Tally.shared.track(.historyReadingOpened)
                    router.path.append(item)
                }
                .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    // An empty builder means no swipe at all — gated until the
                    // backend's DELETE goes live.
                    if FeatureGates.deletion {
                        Button(role: .destructive) { itemToDelete = item } label: {
                            Label("common.delete", systemImage: "trash")
                        }
                    }
                }
                .task { await historyStore.loadMoreIfNeeded(currentItem: item) }
            }
            if historyStore.isLoadingMore {
                ProgressView()
                    .tint(Pigment.accent)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .contentMargins(.top, 12, for: .scrollContent)
        .confirmationDialog("history.delete.confirm", isPresented: confirmingDelete,
                            titleVisibility: .visible) {
            Button("common.delete", role: .destructive) {
                guard let item = itemToDelete else { return }
                Task {
                    if await historyStore.delete(item) {
                        Resonance.success()
                    } else {
                        Resonance.failure()
                        Tidings.shared.say("delete.failed")
                    }
                }
            }
        }
    }

    private var confirmingDelete: Binding<Bool> {
        Binding(get: { itemToDelete != nil }, set: { if !$0 { itemToDelete = nil } })
    }

    private func makeDraft(_ item: HistoryItem) -> ReadingDraft {
        let draft = ReadingDraft()
        draft.drink = item.drink
        draft.teller = item.teller
        draft.topic = item.topic
        draft.readingID = item.id
        draft.cupImageURL = item.cupImageURL
        draft.readingDate = item.date
        return draft
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                // Its own title, not the tab's one-word label.
                Text("history.title")
                    .font(Lettering.displayMedium(24))
                    .foregroundStyle(Pigment.cream)
                Text("history.subtitle")
                    .font(Lettering.body(12))
                    .foregroundStyle(Pigment.creamDim)
            }
            Spacer()
            SettingsButton()
        }
        .padding(.bottom, 12)
    }

    private var loadingState: some View {
        VStack {
            Spacer()
            ProgressView().tint(Pigment.accent)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    // The design only draws the Chats empty state; this mirrors its pattern for
    // History, CTA included — a first reading starts from the same button as
    // every later one.
    private var emptyState: some View {
        EmptyState(
            icon: "book.closed",
            headline: "history.empty.title",
            subtitle: "history.empty.subtitle",
            cta: (title: "drink.title", action: { showReadingFlow = true })
        )
    }
}

/// Fetches the full reading for a history row, then hands it to the Result
/// screen for verbatim replay. Reached from History, and from a reading-born
/// chat's cup card in the Chats tab.
struct HistoryReplayView: View {
    let item: HistoryItem
    let onAskOracle: () -> Void
    let onClose: () -> Void

    @Environment(ReadingHistoryStore.self) private var historyStore
    @State private var reading: Reading?
    @State private var failed = false

    private var draft: ReadingDraft {
        let draft = ReadingDraft()
        draft.drink = item.drink
        draft.teller = item.teller
        draft.topic = item.topic
        draft.readingID = item.id
        draft.readingHasChat = item.hasChat
        draft.cupImageURL = item.cupImageURL
        draft.readingDate = item.date
        return draft
    }

    var body: some View {
        Group {
            if let reading {
                ReadingResultView(existingReading: reading, onAskOracle: onAskOracle, onClose: onClose)
                    .environment(draft)
            } else if failed {
                ScreenStateView(kind: .failure, retry: { Task { await load() } })
            } else {
                ZStack {
                    Pigment.background.ignoresSafeArea()
                    ProgressView().tint(Pigment.accent)
                }
                .toolbar(.hidden, for: .navigationBar)
            }
        }
        .task { await load() }
    }

    private func load() async {
        failed = false
        if let result = await historyStore.reading(for: item) {
            reading = result
        } else {
            failed = true
        }
    }
}

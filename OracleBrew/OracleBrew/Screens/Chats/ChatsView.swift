import SwiftUI

struct ChatsView: View {
    @Environment(ChatSessionStore.self) private var chatStore
    @Environment(ReadingHistoryStore.self) private var historyStore
    @Bindable var router: Pathfinder

    @State private var showChatFlow = false
    /// Row awaiting the "really delete?" confirmation.
    @State private var chatToDelete: ChatSummary?
    private let tabClearance: CGFloat = 96
    /// Button height plus the gap under the last row.
    private let newChatClearance: CGFloat = 72

    private var hasChats: Bool {
        if case .content(let items) = chatStore.listPhase { return !items.isEmpty }
        return false
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack(alignment: .top) {
                Pigment.background.ignoresSafeArea()

                VStack(spacing: 0) {
                    header
                        .padding(.horizontal, 20)
                    content
                }
                .padding(.top, 4)
                // The list stops above the CTA rather than scrolling under it —
                // the button is opaque and would clip the last row.
                .padding(.bottom, tabClearance + (hasChats ? newChatClearance : 0))
            }
            .overlay(alignment: .bottom) {
                // Only once there are chats. The empty state carries its own CTA.
                if hasChats {
                    PrimaryButton(title: "chats.new_chat.cta") {
                        Tally.shared.track(.chatStartedWithNewOracle)
                        showChatFlow = true
                    }
                        .padding(.horizontal, 20)
                        .padding(.bottom, tabClearance)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .onAppear { Tally.shared.track(.chatListShown) }
            .waypointDestinations(router)
            .navigationDestination(for: ChatSummary.self) { summary in
                let thread = chatStore.thread(for: summary)
                OracleChatView(thread: thread, onClose: router.pop,
                               onOpenProfile: { router.path.append(TellerPeek(teller: thread.teller)) },
                               onReturnToReading: replayHandler(for: thread))
            }
            .navigationDestination(for: ChatThread.self) { thread in
                OracleChatView(thread: thread, onClose: router.pop,
                               onOpenProfile: { router.path.append(TellerPeek(teller: thread.teller)) },
                               onReturnToReading: replayHandler(for: thread))
            }
            .navigationDestination(for: HistoryItem.self) { item in
                // The reading behind a chat's cup card. Ask Your Oracle pops
                // back into the chat underneath rather than pushing another.
                HistoryReplayView(item: item, onAskOracle: router.pop, onClose: router.pop)
            }
            .navigationDestination(for: TellerPeek.self) { peek in
                TellerProfileView(teller: peek.teller, onBack: router.pop)
            }
        }
        .environment(router)
        .fullScreenCover(isPresented: $showChatFlow) {
            OracleChatEntryFlow {
                showChatFlow = false
                Task { await chatStore.refreshList() }
            }
        }
        // Quiet refreshes, both of them — loadFirst tears the list down to a
        // spinner, and re-entering the tab made the tiles jump.
        .task {
            await chatStore.refreshList()
            // The rows badge themselves from History's readings, and a chat's
            // cup card resolves its replay from them too — so History must be
            // as fresh as the chats. Refreshing only when empty left a reading
            // made after the first load invisible here: its row wore the
            // placeholder glyph and its card had nowhere to lead until the app
            // restarted.
            await historyStore.refresh()
        }
        .onChange(of: router.path.isEmpty) { _, atRoot in
            // Returning to the list — refresh so the unread dot clears (the
            // backend marked the thread read when it was opened).
            if atRoot { Task { await chatStore.refreshList() } }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch chatStore.listPhase {
        case .loading:
            loadingState
        case .content(let items):
            if items.isEmpty { emptyState } else { list(items) }
        case .loadFailure, .offline:
            ScreenStateView(
                kind: chatStore.listPhase.isOffline ? .offline : .failure,
                retry: { Task { await chatStore.loadList() } }
            )
        }
    }

    // A List rather than the LazyVStack it used to be: swipe-to-delete is the
    // native affordance for rows, and .swipeActions only exists on List rows —
    // it also mirrors itself under RTL, which a hand-rolled drag would not.
    private func list(_ items: [ChatSummary]) -> some View {
        List {
            ForEach(items) { summary in
                Button {
                    Tally.shared.track(.chatOpenedFromList)
                    router.path.append(summary)
                } label: {
                    ChatThreadRow(summary: summary, cupImageURL: cupImage(for: summary))
                }
                .buttonStyle(.plain)
                .listRowInsets(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    // An empty builder means no swipe at all — gated until the
                    // backend's DELETE goes live.
                    if FeatureGates.deletion {
                        Button(role: .destructive) { chatToDelete = summary } label: {
                            Label("common.delete", systemImage: "trash")
                        }
                    }
                }
                .task { await chatStore.loadMoreIfNeeded(currentItem: summary) }
            }
            if chatStore.isLoadingMore {
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
        .alert("common.delete", isPresented: confirmingDelete) {
            Button("common.delete", role: .destructive) {
                guard let summary = chatToDelete else { return }
                Task {
                    if await chatStore.delete(summary) {
                        Resonance.success()
                    } else {
                        Resonance.failure()
                        Tidings.shared.say("delete.failed")
                    }
                }
            }
            Button("common.cancel", role: .cancel) {}
        } message: {
            Text("chats.delete.confirm")
        }
    }

    private var confirmingDelete: Binding<Bool> {
        Binding(get: { chatToDelete != nil }, set: { if !$0 { chatToDelete = nil } })
    }

    /// Where a reading-born chat's cup card leads: the reading's replay, when
    /// History's loaded pages can resolve it. Nil leaves the card informative
    /// but inert — better than promising a destination that can't be built.
    private func replayHandler(for thread: ChatThread) -> (() -> Void)? {
        guard let readingID = thread.readingID,
              let item = historyStore.items.first(where: { $0.id == readingID }) else { return nil }
        return { router.path.append(item) }
    }

    /// The chat list endpoint carries only `reading_id`, so the cup photo comes
    /// from the readings History already holds. Nil until (or unless) that
    /// reading is among the loaded pages — the row falls back to a glyph.
    private func cupImage(for summary: ChatSummary) -> String? {
        guard let readingID = summary.readingID else { return nil }
        return historyStore.items.first { $0.id == readingID }?.cupImageURL
    }

    private var loadingState: some View {
        VStack {
            Spacer()
            ProgressView().tint(Pigment.accent)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    private var header: some View {
        HStack(alignment: .top) {
            // The design titles the screen and drops the subtitle.
            Text("chats.title")
                .font(Lettering.displayMedium(24))
                .foregroundStyle(Pigment.cream)
            Spacer()
            SettingsButton()
        }
        .padding(.bottom, 12)
    }

    private var emptyState: some View {
        EmptyState(
            icon: "ellipsis.bubble",
            headline: "chats.empty.title",
            subtitle: "chats.empty.subtitle",
            cta: (title: "chats.empty.cta", action: {
                Tally.shared.track(.chatStartedWithNewOracle)
                showChatFlow = true
            })
        )
    }
}

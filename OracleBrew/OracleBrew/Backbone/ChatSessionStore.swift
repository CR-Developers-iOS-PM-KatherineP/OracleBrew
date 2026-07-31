import Foundation

struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let isFromUser: Bool
    let text: String
}

@Observable
final class ChatThread: Identifiable {
    let id = UUID()
    let teller: FortuneTeller
    /// Reading this chat grew out of, if any — nil for a direct chat entry.
    let draftContext: ReadingDraft?
    /// The server's other half of the chat key: a chat is one per
    /// (oracle, reading), with nil meaning the oracle's single direct chat.
    /// Kept apart from `draftContext` because a thread opened from the Chats
    /// list has no draft, yet may still belong to a reading.
    let readingID: Int?
    var messages: [ChatMessage] = []
    var lastUpdated = Date()
    /// The server chat id, resolved on first open (create-or-resume) or carried
    /// in from the thread list. Until then messages haven't been loaded.
    var backendID: Int?
    /// Quick-question chips the server suggests for this thread.
    var quickQuestions: [String] = []
    /// Whether the chat screen is currently showing this thread. The reply
    /// arrives on a task that outlives the screen, and marking the thread read
    /// is only honest while someone is actually looking at it — a reply landing
    /// after the user left must keep its unread dot in the list.
    var isOpen = false

    /// The suggestions still worth offering: the full list minus anything already
    /// asked.
    ///
    /// Derived from the messages rather than kept as a separate "used" set, and
    /// that is the point — the message history is what the backend sends back
    /// when the chat is reopened, so a prompt that was tapped stays gone with
    /// nothing extra to persist and nothing to fall out of sync. Reseeding
    /// `quickQuestions` on every open, which is what the chat does, then can't
    /// bring the used ones back.
    var unusedQuickQuestions: [String] {
        let asked = Set(messages.lazy.filter(\.isFromUser).map(\.text))
        return quickQuestions.filter { !asked.contains($0) }
    }

    init(teller: FortuneTeller, draftContext: ReadingDraft?) {
        self.teller = teller
        self.draftContext = draftContext
        readingID = draftContext?.readingID
    }

}

extension ChatThread: Hashable {
    static func == (lhs: ChatThread, rhs: ChatThread) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

/// A row in the Chats tab — the server's thread summary.
struct ChatSummary: Identifiable, Hashable {
    let id: Int
    let teller: FortuneTeller
    let preview: String
    let date: Date
    /// The oracle sent a message the user hasn't opened yet — shows the dot.
    let hasUnread: Bool
    /// The reading this chat grew out of, if any. The design badges the avatar
    /// with that reading's cup; a direct Oracle Chat has none.
    let readingID: Int?

    var fromReading: Bool { readingID != nil }
}

@MainActor
@Observable
final class ChatSessionStore {
    private(set) var threads: [ChatThread] = []

    // Thread list (Chats tab)
    private let list: PagedList<ChatSummary>

    var listPhase: ScreenPhase<[ChatSummary]> { list.phase }
    var summaries: [ChatSummary] { list.items }
    var isLoadingMore: Bool { list.isLoadingMore }

    private let repository: ChatRepository

    init(repository: ChatRepository = ChatRepository()) {
        self.repository = repository
        list = PagedList { page in
            let response = try await repository.list(page: page)
            return (response.results.map(Self.summary), response.hasMore)
        }
    }

    // MARK: Open threads

    /// Returns the existing thread for this chat, or opens a new one.
    ///
    /// Matched on the server's own key — (oracle, reading) — not on the oracle
    /// alone. Keying by oracle is how every door once led into the same room:
    /// Oracle Chat would hand back the reading's thread with its `backendID`
    /// already set, the screen would skip create-or-resume, and the user found
    /// themselves mid-way through a conversation about last week's cup. The
    /// backend keeps a reading's chat and the oracle's direct chat strictly
    /// apart; this cache now does too.
    func thread(for teller: FortuneTeller, context: ReadingDraft?) -> ChatThread {
        if let existing = threads.first(where: {
            $0.teller.id == teller.id && $0.readingID == context?.readingID
        }) {
            return existing
        }
        let new = ChatThread(teller: teller, draftContext: context)
        threads.insert(new, at: 0)
        return new
    }

    /// Opens the thread behind a list row, carrying its known server id so the
    /// chat screen loads messages directly instead of creating a new thread.
    func thread(for summary: ChatSummary) -> ChatThread {
        // The server id is the surest match; fall back to the (oracle, reading)
        // key for a flow-born thread that hasn't resolved its id yet.
        if let existing = threads.first(where: { $0.backendID == summary.id }) {
            return existing
        }
        if let existing = threads.first(where: {
            $0.backendID == nil && $0.teller.id == summary.teller.id
                && $0.readingID == summary.readingID
        }) {
            existing.backendID = summary.id
            return existing
        }
        // A reading-born row gets a stub draft carrying just the reading id —
        // the chat screen hydrates the rest (the reading, its cup, its date)
        // so the reading card shows here exactly as it does after the reading.
        let context: ReadingDraft? = summary.readingID.map { id in
            let draft = ReadingDraft()
            draft.readingID = id
            return draft
        }
        let new = ChatThread(teller: summary.teller, draftContext: context)
        new.backendID = summary.id
        threads.insert(new, at: 0)
        return new
    }

    // MARK: Thread list

    func loadList() async { await list.loadFirst() }

    /// The quiet variant — rows swap in place, no loading flash.
    func refreshList() async { await list.refresh() }

    /// Deletes a chat: the row goes at once, the request follows. On a real
    /// failure the list is reloaded — the server knows the truth — and false
    /// comes back so the screen can say so. A 405 is the backend not having
    /// shipped deletion yet; the local removal stands so the flow already
    /// works, and the same code goes live the day the endpoint does.
    func delete(_ summary: ChatSummary) async -> Bool {
        list.remove(id: summary.id)
        threads.removeAll { $0.backendID == summary.id }
        do {
            try await repository.delete(chatID: summary.id)
            return true
        } catch let failure as EmissaryFailure where failure.isUnsupported {
            return true
        } catch {
            await loadList()
            return false
        }
    }

    func loadMoreIfNeeded(currentItem: ChatSummary) async {
        await list.loadMoreIfNeeded(currentItem: currentItem)
    }

    private static func summary(_ dto: ChatListItemDTO) -> ChatSummary {
        ChatSummary(
            id: dto.id,
            teller: CatalogMapper.oracle(dto.oracle),
            preview: dto.lastMessage?.text ?? String(localized: "chats.row.empty_preview"),
            date: APIDate.parse(dto.updatedAt) ?? Date(),
            hasUnread: dto.hasUnreadFromOracle ?? false,
            readingID: dto.readingId
        )
    }
}

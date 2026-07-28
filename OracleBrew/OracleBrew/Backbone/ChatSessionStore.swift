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
    var messages: [ChatMessage] = []
    var lastUpdated = Date()
    /// The server chat id, resolved on first open (create-or-resume) or carried
    /// in from the thread list. Until then messages haven't been loaded.
    var backendID: Int?
    /// Quick-question chips the server suggests for this thread.
    var quickQuestions: [String] = []

    init(teller: FortuneTeller, draftContext: ReadingDraft?) {
        self.teller = teller
        self.draftContext = draftContext
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

    /// Returns the existing thread with this teller, or opens a new one.
    func thread(for teller: FortuneTeller, context: ReadingDraft?) -> ChatThread {
        if let existing = threads.first(where: { $0.teller.id == teller.id }) {
            return existing
        }
        let new = ChatThread(teller: teller, draftContext: context)
        threads.insert(new, at: 0)
        return new
    }

    /// Opens the thread behind a list row, carrying its known server id so the
    /// chat screen loads messages directly instead of creating a new thread.
    func thread(for summary: ChatSummary) -> ChatThread {
        let thread = self.thread(for: summary.teller, context: nil)
        thread.backendID = summary.id
        return thread
    }

    // MARK: Thread list

    func loadList() async { await list.loadFirst() }

    func loadMoreIfNeeded(currentItem: ChatSummary) async {
        await list.loadMoreIfNeeded(currentItem: currentItem)
    }

    private static let isoFormatter = ISO8601DateFormatter()

    private static func summary(_ dto: ChatListItemDTO) -> ChatSummary {
        ChatSummary(
            id: dto.id,
            teller: CatalogMapper.oracle(dto.oracle),
            preview: dto.lastMessage?.text ?? String(localized: "chats.row.empty_preview"),
            date: dto.updatedAt.flatMap { isoFormatter.date(from: $0) } ?? Date(),
            hasUnread: dto.hasUnreadFromOracle ?? false,
            readingID: dto.readingId
        )
    }
}

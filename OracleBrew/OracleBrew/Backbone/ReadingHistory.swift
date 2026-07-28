import SwiftUI

struct HistoryItem: Identifiable, Hashable {
    let id: Int                 // server reading id
    let drink: Drink
    let teller: FortuneTeller
    let topic: Topic?
    let cupImageURL: String?
    let preview: String
    let adviceHeadline: String
    let timeframe: String
    let hasChat: Bool
    let date: Date

    static func == (lhs: HistoryItem, rhs: HistoryItem) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

@MainActor
@Observable
final class ReadingHistoryStore {
    private let list: PagedList<HistoryItem>
    private let repository: HistoryRepository

    var phase: ScreenPhase<[HistoryItem]> { list.phase }
    var items: [HistoryItem] { list.items }
    var isLoadingMore: Bool { list.isLoadingMore }

    init(repository: HistoryRepository = HistoryRepository()) {
        self.repository = repository
        list = PagedList { page in
            let response = try await repository.page(page)
            return (response.results.map(HistoryMapper.item), response.hasMore)
        }
    }

    func loadFirst() async { await list.loadFirst() }

    func loadMoreIfNeeded(currentItem: HistoryItem) async {
        await list.loadMoreIfNeeded(currentItem: currentItem)
    }

    /// Pulls the full reading for a history row so the Result screen can replay it.
    func reading(for item: HistoryItem) async -> Reading? {
        try? await repository.readingDetail(id: item.id)
    }
}

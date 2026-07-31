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

    /// The quiet variant — rows swap in place, no loading flash.
    func refresh() async { await list.refresh() }

    func loadMoreIfNeeded(currentItem: HistoryItem) async {
        await list.loadMoreIfNeeded(currentItem: currentItem)
    }

    /// Pulls the full reading for a history row so the Result screen can replay it.
    func reading(for item: HistoryItem) async -> Reading? {
        try? await repository.readingDetail(id: item.id)
    }

    /// Deletes a reading: the card goes at once, the request follows. On a real
    /// failure the list is reloaded and false comes back so the screen can say
    /// so. A 405 is the backend not having shipped deletion yet; the local
    /// removal stands, and the same code goes live the day the endpoint does.
    func delete(_ item: HistoryItem) async -> Bool {
        list.remove(id: item.id)
        do {
            try await repository.delete(readingID: item.id)
            return true
        } catch let failure as EmissaryFailure where failure.isUnsupported {
            return true
        } catch {
            await loadFirst()
            return false
        }
    }
}

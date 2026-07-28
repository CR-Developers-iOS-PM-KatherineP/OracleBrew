import Foundation

/// A list that loads a page at a time.
///
/// The chat threads and the reading history paged themselves with the same
/// twenty lines each — a page cursor, an append-or-replace, a phase set on the
/// first page only, and a guard that fires the next page when the last row
/// appears. This owns that once; a store keeps one and forwards to it.
@MainActor
@Observable
final class PagedList<Item: Identifiable> {
    private(set) var phase: ScreenPhase<[Item]> = .loading
    private(set) var items: [Item] = []
    /// True while a *subsequent* page is in flight. The first page reports
    /// through `phase` instead, so the screen shows its loading state.
    private(set) var isLoadingMore = false

    private var nextPage = 1
    private var canLoadMore = true
    /// Fetches one page: the mapped rows, and whether another page follows.
    private let fetch: (Int) async throws -> (items: [Item], hasMore: Bool)

    init(fetch: @escaping (Int) async throws -> (items: [Item], hasMore: Bool)) {
        self.fetch = fetch
    }

    /// Reloads from the first page, dropping what was there.
    func loadFirst() async {
        nextPage = 1
        canLoadMore = true
        items = []
        phase = .loading
        await fetchNextPage(replacing: true)
    }

    /// Called as each row appears; only the last one pulls the next page.
    func loadMoreIfNeeded(currentItem: Item) async {
        guard canLoadMore, !isLoadingMore, currentItem.id == items.last?.id else { return }
        isLoadingMore = true
        defer { isLoadingMore = false }
        await fetchNextPage(replacing: false)
    }

    private func fetchNextPage(replacing: Bool) async {
        do {
            let page = try await fetch(nextPage)
            items = replacing ? page.items : items + page.items
            canLoadMore = page.hasMore
            nextPage += 1
            phase = .content(items)
        } catch let failure as EmissaryFailure {
            // A failed *later* page leaves the rows already on screen alone —
            // replacing the list with an error would throw away good content.
            if replacing { phase = .from(failure) }
        } catch {
            if replacing { phase = .loadFailure }
        }
    }
}

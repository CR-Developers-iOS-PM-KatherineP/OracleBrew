import Foundation

struct HistoryItemDTO: Decodable {
    let id: Int
    let drink: DrinkDTO
    let oracle: OracleDTO
    let topic: TopicDTO?
    let cupImage: String?
    let previewText: String?
    let adviceHeadline: String?
    let timeframeLabel: String?
    let hasChat: Bool?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, drink, oracle, topic
        case cupImage = "cup_image"
        case previewText = "preview_text"
        case adviceHeadline = "advice_headline"
        case timeframeLabel = "timeframe_label"
        case hasChat = "has_chat"
        case createdAt = "created_at"
    }
}

struct HistoryRepository {
    var emissary: Emissary = .shared

    func page(_ page: Int) async throws -> Paginated<HistoryItemDTO> {
        try await emissary.perform(
            EmissaryRequest(path: "history/", query: ["page": String(page)]),
            as: Paginated<HistoryItemDTO>.self
        )
    }

    func readingDetail(id: Int) async throws -> Reading {
        let dto = try await emissary.perform(EmissaryRequest(path: "readings/\(id)/"), as: ReadingDTO.self)
        return ReadingMapper.reading(dto.result)
    }

    /// Everything a chat's reading card needs, in one fetch — for a
    /// reading-born chat opened from a list, where the session no longer
    /// holds the reading it came from.
    func readingCard(id: Int) async throws -> (reading: Reading, cupImageURL: String?, date: Date?) {
        let dto = try await emissary.perform(EmissaryRequest(path: "readings/\(id)/"), as: ReadingDTO.self)
        return (ReadingMapper.reading(dto.result), dto.cupImage, APIDate.parse(dto.createdAt))
    }

    /// Deletes the reading — and, per the backend contract, the chat that grew
    /// from it: a chat without its reading is a stump. Rides the history
    /// namespace, not readings/ — and only completed/failed readings qualify
    /// (a draft answers 404), which is fine: drafts never reach the list.
    func delete(readingID: Int) async throws {
        try await emissary.performVoid(
            EmissaryRequest(path: "history/\(readingID)/", method: .delete)
        )
    }
}

enum HistoryMapper {
    static func item(_ dto: HistoryItemDTO) -> HistoryItem {
        HistoryItem(
            id: dto.id,
            drink: CatalogMapper.drink(dto.drink),
            teller: CatalogMapper.oracle(dto.oracle),
            topic: dto.topic.map(CatalogMapper.topic),
            cupImageURL: dto.cupImage,
            preview: dto.previewText ?? "",
            adviceHeadline: dto.adviceHeadline ?? "",
            timeframe: dto.timeframeLabel ?? "",
            hasChat: dto.hasChat ?? false,
            date: APIDate.parse(dto.createdAt) ?? Date()
        )
    }
}

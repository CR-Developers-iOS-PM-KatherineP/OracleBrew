import Foundation

struct ChatMessageDTO: Decodable {
    let id: Int
    let role: String          // user | assistant
    let text: String
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, role, text
        case createdAt = "created_at"
    }
}

struct ChatDetailDTO: Decodable {
    let id: Int
    let oracle: OracleDTO
    let readingId: Int?
    let quickQuestions: [String]?
    let messages: [ChatMessageDTO]?

    enum CodingKeys: String, CodingKey {
        case id, oracle, messages
        case readingId = "reading_id"
        case quickQuestions = "quick_questions"
    }
}

struct ChatListItemDTO: Decodable {
    let id: Int
    let oracle: OracleDTO
    let readingId: Int?
    let lastMessage: ChatMessageDTO?
    let hasUnreadFromOracle: Bool?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, oracle
        case readingId = "reading_id"
        case lastMessage = "last_message"
        case hasUnreadFromOracle = "has_unread_from_oracle"
        case updatedAt = "updated_at"
    }
}

/// The oracle's reply is generated asynchronously, so sending only returns the
/// user's own message plus the job to wait on.
struct SendMessageDTO: Decodable {
    let job: AIJobDTO
    let userMessage: ChatMessageDTO

    enum CodingKeys: String, CodingKey {
        case job
        case userMessage = "user_message"
    }
}

/// What a finished `chat_message` job carries.
struct ChatJobResultDTO: Decodable {
    let reply: String?
    let userMessageId: Int?
    let assistantMessageId: Int?

    enum CodingKeys: String, CodingKey {
        case reply
        case userMessageId = "user_message_id"
        case assistantMessageId = "assistant_message_id"
    }
}

struct ChatJobDTO: Decodable {
    let id: Int
    let status: String          // pending | processing | succeeded | failed
    let error: String?
    let result: ChatJobResultDTO?
}

private struct CreateChatBody: Encodable {
    let oracleId: Int
    let readingId: Int?

    enum CodingKeys: String, CodingKey {
        case oracleId = "oracle_id"
        case readingId = "reading_id"
    }
}

private struct SendBody: Encodable {
    let text: String
    /// ISO 639 code the oracle should answer in. Sent on every message — the
    /// backend defaults to English without it.
    let language: String
}

struct ChatRepository {
    var emissary: Emissary = .shared

    /// Resumes the existing (oracle, reading) thread or opens a new one.
    func createOrResume(oracleID: Int, readingID: Int?) async throws -> ChatDetailDTO {
        let body = CreateChatBody(oracleId: oracleID, readingId: readingID)
        let request = EmissaryRequest(path: "chats/", method: .post, body: .json(body))
        return try await emissary.perform(request, as: ChatDetailDTO.self)
    }

    func detail(id: Int) async throws -> ChatDetailDTO {
        try await emissary.perform(EmissaryRequest(path: "chats/\(id)/"), as: ChatDetailDTO.self)
    }

    /// Posts the user's message and returns the job that will produce the reply.
    /// A 400 here means the previous reply is still running — see `isReplyInProgress`.
    func send(chatID: Int, text: String, language: String = APIConfig.replyLanguage) async throws -> SendMessageDTO {
        let body = SendBody(text: text, language: language)
        let request = EmissaryRequest(path: "chats/\(chatID)/messages/", method: .post, body: .json(body))
        return try await emissary.perform(request, as: SendMessageDTO.self)
    }

    func job(id: Int) async throws -> ChatJobDTO {
        try await emissary.perform(EmissaryRequest(path: "ai/jobs/\(id)/"), as: ChatJobDTO.self)
    }

    /// Waits for the oracle's reply. ~1.5s cadence; the cap is generous because
    /// a slow model run still resolves, and the alternative is telling the user
    /// it failed while the answer is on its way.
    func awaitReply(jobID: Int) async throws -> String {
        for _ in 0..<60 {
            let job = try await job(id: jobID)
            switch job.status {
            case "succeeded":
                guard let reply = job.result?.reply, !reply.isEmpty else {
                    throw EmissaryFailure.server(statusCode: 502)
                }
                return reply
            case "failed":
                throw EmissaryFailure.server(statusCode: 502)
            default:
                try await Task.sleep(for: .milliseconds(1500))
            }
        }
        throw EmissaryFailure.server(statusCode: 504)   // timed out waiting
    }

    /// Marks the thread read without pulling the whole history.
    func markRead(chatID: Int) async throws {
        try await emissary.performVoid(
            EmissaryRequest(path: "chats/\(chatID)/read/", method: .post)
        )
    }

    func list(page: Int = 1) async throws -> Paginated<ChatListItemDTO> {
        try await emissary.perform(
            EmissaryRequest(path: "chats/", query: ["page": String(page)]),
            as: Paginated<ChatListItemDTO>.self
        )
    }
}

enum ChatMapper {
    static func message(_ dto: ChatMessageDTO) -> ChatMessage {
        ChatMessage(isFromUser: dto.role == "user", text: dto.text)
    }
}

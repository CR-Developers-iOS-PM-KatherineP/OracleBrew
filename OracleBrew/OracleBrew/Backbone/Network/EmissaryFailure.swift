import Foundation

enum EmissaryFailure: Error {
    case offline
    case unauthorized                    // 401 — token missing or rejected
    /// 400, carrying the backend's own `code` when it sent one. Some 400s mean
    /// something specific the user can act on — `cup_not_found` is "that photo
    /// has no cup in it" — and a bare status code can't say which.
    case badRequest(code: String?)
    case notSubscribed                   // 403 — /access/ without a subscription
    case notFound                        // 404
    case rateLimited                     // 429
    case server(statusCode: Int)
    case decoding(Error)
    case encoding(Error)

    /// True when re-authenticating (a fresh guest-signup) might recover.
    var isAuthProblem: Bool { if case .unauthorized = self { true } else { false } }

    var isOffline: Bool { if case .offline = self { true } else { false } }
}

extension EmissaryFailure {
    /// `body` is the raw error payload, read only to recover the backend's `code`.
    static func from(statusCode: Int, body: Data? = nil) -> EmissaryFailure {
        switch statusCode {
        case 400: .badRequest(code: code(in: body))
        case 401: .unauthorized
        case 403: .notSubscribed
        case 404: .notFound
        case 429: .rateLimited
        default: .server(statusCode: statusCode)
        }
    }

    /// The API's error shape is `{"code": "…", "detail": "…"}`, and `code` is the
    /// half meant for us to branch on. Absent on the 400s that only carry prose.
    private static func code(in body: Data?) -> String? {
        guard let body else { return nil }
        struct Payload: Decodable { let code: String? }
        return (try? JSONDecoder().decode(Payload.self, from: body))?.code
    }

    /// The photo the user picked has no cup in it — Vision found no rim.
    var isCupNotFound: Bool {
        if case .badRequest(let code) = self { code == "cup_not_found" } else { false }
    }
}

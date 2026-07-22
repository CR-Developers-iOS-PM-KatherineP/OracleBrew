import Foundation

// MARK: Field options

enum Identity: String, CaseIterable, Codable, Identifiable {
    // Raw values are the backend's gender enum.
    case female, male
    case ratherNot = "prefer_not_to_say"
    var id: String { rawValue }

    var label: String {
        switch self {
        case .female: String(localized: "field.identity.female")
        case .male: String(localized: "field.identity.male")
        case .ratherNot: String(localized: "field.identity.rather_not")
        }
    }
}

enum RelationshipStatus: String, CaseIterable, Codable, Identifiable {
    // Raw values are the backend's relationship_status enum; declaration order
    // is the dropdown order from the design.
    case married
    case inRelationship = "in_a_relationship"
    case single
    case divorced
    case complicated = "its_complicated"
    var id: String { rawValue }

    var label: String {
        switch self {
        case .married: String(localized: "field.relationship.married")
        case .inRelationship: String(localized: "field.relationship.in_relationship")
        case .single: String(localized: "field.relationship.single")
        case .divorced: String(localized: "field.relationship.divorced")
        case .complicated: String(localized: "field.relationship.complicated")
        }
    }
}

enum Employment: String, CaseIterable, Codable, Identifiable {
    // Raw values are the backend's employment_status enum.
    case studying, working, both, seeking
    case notWorking = "not_working"
    var id: String { rawValue }

    var label: String {
        switch self {
        case .studying: String(localized: "field.employment.studying")
        case .working: String(localized: "field.employment.working")
        case .both: String(localized: "field.employment.both")
        case .seeking: String(localized: "field.employment.seeking")
        case .notWorking: String(localized: "field.employment.not_working")
        }
    }
}

enum ChildrenStatus: String, CaseIterable, Codable, Identifiable {
    // Raw values are the backend's children enum.
    case have = "yes"
    case none = "no"
    case planning
    var id: String { rawValue }

    var label: String {
        switch self {
        case .have: String(localized: "field.children.have")
        case .none: String(localized: "field.children.none")
        case .planning: String(localized: "field.children.planning")
        }
    }
}

// MARK: Zodiac

enum Zodiac: String, Codable, CaseIterable {
    case aries, taurus, gemini, cancer, leo, virgo
    case libra, scorpio, sagittarius, capricorn, aquarius, pisces

    /// Spelled out rather than built from `rawValue` so the keys stay literal —
    /// an interpolated key would extract as "zodiac.%@" and resolve to nothing.
    var name: String {
        switch self {
        case .aries: String(localized: "zodiac.aries")
        case .taurus: String(localized: "zodiac.taurus")
        case .gemini: String(localized: "zodiac.gemini")
        case .cancer: String(localized: "zodiac.cancer")
        case .leo: String(localized: "zodiac.leo")
        case .virgo: String(localized: "zodiac.virgo")
        case .libra: String(localized: "zodiac.libra")
        case .scorpio: String(localized: "zodiac.scorpio")
        case .sagittarius: String(localized: "zodiac.sagittarius")
        case .capricorn: String(localized: "zodiac.capricorn")
        case .aquarius: String(localized: "zodiac.aquarius")
        case .pisces: String(localized: "zodiac.pisces")
        }
    }

    /// U+FE0E forces text presentation — without it iOS renders these as
    /// colour emoji, which ignores the label's tint.
    var glyph: String {
        let symbol: String = switch self {
        case .aries: "♈"
        case .taurus: "♉"
        case .gemini: "♊"
        case .cancer: "♋"
        case .leo: "♌"
        case .virgo: "♍"
        case .libra: "♎"
        case .scorpio: "♏"
        case .sagittarius: "♐"
        case .capricorn: "♑"
        case .aquarius: "♒"
        case .pisces: "♓"
        }
        return symbol + "\u{FE0E}"
    }

    /// Western tropical zodiac. Each entry is the sign's *start* day within its
    /// month; a date before its month's cutoff belongs to the previous sign.
    /// The backend also derives this from the DOB and returns the same value —
    /// this keeps the label live while the user is still picking a date.
    private static let cutoffs: [(month: Int, day: Int, sign: Zodiac)] = [
        (1, 20, .aquarius), (2, 19, .pisces), (3, 21, .aries), (4, 20, .taurus),
        (5, 21, .gemini), (6, 21, .cancer), (7, 23, .leo), (8, 23, .virgo),
        (9, 23, .libra), (10, 23, .scorpio), (11, 22, .sagittarius), (12, 22, .capricorn),
    ]

    static func from(day: Int, month: Int) -> Zodiac? {
        guard (1...12).contains(month), (1...31).contains(day) else { return nil }
        let cutoff = cutoffs[month - 1]
        if day >= cutoff.day { return cutoff.sign }
        // Before the cutoff → the sign that started in the previous month.
        return cutoffs[(month + 10) % 12].sign
    }
}

// MARK: Profile

struct UserProfile: Codable, Equatable {
    var name = ""
    var identity: Identity?
    var birthDay: Int?
    var birthMonth: Int?
    var birthYear: Int?
    var relationship: RelationshipStatus?
    var employment: Employment?
    var countryCode: String?
    var children: ChildrenStatus?
    var interests: Set<String> = []

    var zodiac: Zodiac? {
        guard let birthDay, let birthMonth else { return nil }
        return Zodiac.from(day: birthDay, month: birthMonth)
    }

    /// A profile counts as "created" once the user has saved a name — that's
    /// the only field the rest of the app currently reads.
    var isCreated: Bool { !name.trimmingCharacters(in: .whitespaces).isEmpty }
}

@MainActor
@Observable
final class UserProfileStore {
    private(set) var profile = UserProfile()
    private(set) var isLoaded = false
    var isSaving = false

    private let repository: ProfileRepository

    init(repository: ProfileRepository = ProfileRepository()) {
        self.repository = repository
    }

    /// Pull the profile once the token exists. A failure leaves the empty
    /// default in place — the screens treat that as "no profile yet".
    func load() async {
        guard !isLoaded else { return }
        if let fetched = try? await repository.fetch() {
            profile = fetched
        }
        isLoaded = true
    }

    func save(_ new: UserProfile, completingOnboarding: Bool = false) async throws {
        isSaving = true
        defer { isSaving = false }
        profile = try await repository.update(new, completingOnboarding: completingOnboarding)
    }

    /// Deletes the server account. The caller then mints a fresh guest token
    /// (the old one is now invalid) so the app keeps working.
    func deleteAccount() async {
        try? await repository.deleteAccount()
        profile = UserProfile()
        isLoaded = false
    }
}

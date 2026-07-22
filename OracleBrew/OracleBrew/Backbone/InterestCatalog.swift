import SwiftUI

struct Interest: Identifiable, Hashable {
    let id: String
    let label: String
    let hue: Color
}

enum InterestCatalog {
    static let all: [Interest] = [
        Interest(id: "love", label: String(localized: "interest.love"), hue: Color(hex: 0xFF7EE1)),
        Interest(id: "family", label: String(localized: "interest.family"), hue: Color(hex: 0xACD867)),
        Interest(id: "children", label: String(localized: "interest.children"), hue: Color(hex: 0xFFA77E)),
        Interest(id: "money", label: String(localized: "interest.money"), hue: Color(hex: 0xFFD47E)),
        Interest(id: "self_growth", label: String(localized: "interest.self_growth"), hue: Color(hex: 0xFF7EAB)),
        Interest(id: "career", label: String(localized: "interest.career"), hue: Color(hex: 0x7E9DFF)),
        Interest(id: "destiny", label: String(localized: "interest.destiny"), hue: Color(hex: 0xE57EFF)),
        Interest(id: "health", label: String(localized: "interest.health"), hue: Color(hex: 0x63FBB2)),
        Interest(id: "travel", label: String(localized: "interest.travel"), hue: Color(hex: 0x7EE7FF)),
        Interest(id: "life_change", label: String(localized: "interest.life_change"), hue: Color(hex: 0x987EFF)),
        Interest(id: "relationship", label: String(localized: "interest.relationship"), hue: Color(hex: 0xFD7174)),
        Interest(id: "other", label: String(localized: "interest.other"), hue: Color(hex: 0xBB7EF7)),
    ]
}

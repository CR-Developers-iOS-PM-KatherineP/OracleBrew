import Foundation

extension String {
    /// The AI writes its readings with markdown emphasis — `**Tree**`,
    /// `*feather*` — and a plain `Text` printed the asterisks. Parsed
    /// inline-only so the prose's own line breaks survive; a string that
    /// fails to parse falls back to itself, asterisks and all, rather
    /// than to nothing.
    var oracleProse: AttributedString {
        (try? AttributedString(
            markdown: self,
            options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        )) ?? AttributedString(self)
    }
}

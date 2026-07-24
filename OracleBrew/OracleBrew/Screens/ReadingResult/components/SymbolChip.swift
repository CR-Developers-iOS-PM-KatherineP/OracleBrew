import SwiftUI

struct SymbolChip: View {
    let symbol: ReadingSymbol

    private var entry: SymbolCatalog.Entry? { SymbolCatalog.entry(forSlug: symbol.slug) }

    var body: some View {
        HStack(spacing: 6) {
            // Skipped rather than reserved for: an empty 24pt gap reads as a
            // broken image, whereas the chip without one is just the text-only
            // chip this used to be.
            if let entry, entry.hasIcon {
                Image(entry.icon)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    // Accent, as the design's own stroke colour is — the icon
                    // reads with the keyword, not with the name beside it.
                    .foregroundStyle(Pigment.accent)
            }
            Text(symbol.name)
                .font(Lettering.bodySemibold(14))
                .foregroundStyle(Pigment.cream)
            // Verbatim: it is a glyph, not copy. As a localizable string it was
            // extracted as its own key and sat there untranslatable.
            Text(verbatim: "→")
                .font(Lettering.body(13))
                .foregroundStyle(Pigment.cream.opacity(0.6))
            Text(symbol.keyword)
                .font(Lettering.body(14))
                .foregroundStyle(Pigment.accent)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(RoundedRectangle(cornerRadius: 14).fill(Color(hex: 0x271C3E)))
        .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(Color.white.opacity(0.15), lineWidth: 1))
    }
}

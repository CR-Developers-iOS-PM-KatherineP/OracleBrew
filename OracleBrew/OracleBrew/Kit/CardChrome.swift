import SwiftUI

/// The design's panel treatment, in one place.
///
/// A filled rounded panel with a hairline white border shows up on cards, chips,
/// instruction boxes and pill buttons across the app. It was written out by hand
/// at every site, which meant the same colour lived under two different local
/// names and a change to the border would have had to be found by grep.
extension View {
    /// A filled panel with the design's hairline border.
    func cardPanel(radius: CGFloat,
                   fill: Color = Pigment.card,
                   lineWidth: CGFloat = 1) -> some View {
        background(RoundedRectangle(cornerRadius: radius).fill(fill))
            .overlay(RoundedRectangle(cornerRadius: radius)
                .strokeBorder(Pigment.panelBorder, lineWidth: lineWidth))
    }

    /// The border alone — for content that already draws and clips its own
    /// background, like a photo or a piece of artwork.
    func cardBorder(radius: CGFloat, lineWidth: CGFloat = 1) -> some View {
        overlay(RoundedRectangle(cornerRadius: radius)
            .strokeBorder(Pigment.panelBorder, lineWidth: lineWidth))
    }

    /// The secondary button's pill: a capsule in the darker fill, same border.
    func pillPanel(fill: Color = Pigment.pill, lineWidth: CGFloat = 1) -> some View {
        background(Capsule().fill(fill))
            .overlay(Capsule().strokeBorder(Pigment.panelBorder, lineWidth: lineWidth))
    }
}

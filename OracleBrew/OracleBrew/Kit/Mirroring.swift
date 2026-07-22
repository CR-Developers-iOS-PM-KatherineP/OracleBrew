import SwiftUI

extension LayoutDirection {
    /// +1 reading left-to-right, -1 in Arabic. Multiply a hardcoded horizontal
    /// offset or rotation by this so it keeps pointing the same way relative to
    /// the reading direction.
    ///
    /// Semantic alignments (`.leading`, `.bottomTrailing`, `HStack` order) and
    /// `.padding(.leading:)` mirror themselves and need none of this. What does
    /// not mirror: `.offset(x:)`, `.rotationEffect`, `.position(x:)`, a `Shape`'s
    /// path, and a custom `Layout`'s placement — those read absolute geometry
    /// and never see the layout direction.
    var sign: CGFloat { self == .rightToLeft ? -1 : 1 }

    /// Gradient endpoints that follow the reading direction. `UnitPoint.leading`
    /// and `.trailing` are fixed x=0 and x=1 inside a gradient — they do not
    /// mirror the way a semantic alignment does. A fade positioned by a mirrored
    /// `.overlay(alignment:)` therefore runs the wrong way in Arabic and turns
    /// into a hard seam, so hand the gradient these instead.
    var startEdge: UnitPoint { self == .rightToLeft ? .trailing : .leading }
    var endEdge: UnitPoint { self == .rightToLeft ? .leading : .trailing }
}

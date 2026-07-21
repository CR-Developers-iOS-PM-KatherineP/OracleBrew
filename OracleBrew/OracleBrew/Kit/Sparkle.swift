import SwiftUI

/// A four-point star with concave edges — the glyph beside the splash wordmark.
///
/// Drawn rather than exported: Figma ships it as a two-path SVG whose curves are
/// the same shape at two radii, so one parametric `Shape` reproduces both and
/// stays tintable and resolution-free. The control points below are the Figma
/// path's, normalised against the star's radius.
struct Sparkle: Shape {
    func path(in rect: CGRect) -> Path {
        let r = min(rect.width, rect.height) / 2
        let c = CGPoint(x: rect.midX, y: rect.midY)

        // Each edge runs from one tip to the next, bowing in toward the centre.
        let near = 0.0199 * r   // control offset along the edge's own axis
        let far = 0.4562 * r    // control offset along the perpendicular axis

        // Tips, clockwise from the top, paired with the controls of the edge
        // leaving each one.
        let tips = [
            CGPoint(x: c.x, y: c.y - r),
            CGPoint(x: c.x + r, y: c.y),
            CGPoint(x: c.x, y: c.y + r),
            CGPoint(x: c.x - r, y: c.y),
        ]
        let controls = [
            (CGPoint(x: c.x + near, y: c.y - far), CGPoint(x: c.x + far, y: c.y - near)),
            (CGPoint(x: c.x + far, y: c.y + near), CGPoint(x: c.x + near, y: c.y + far)),
            (CGPoint(x: c.x - near, y: c.y + far), CGPoint(x: c.x - far, y: c.y + near)),
            (CGPoint(x: c.x - far, y: c.y - near), CGPoint(x: c.x - near, y: c.y - far)),
        ]

        var path = Path()
        path.move(to: tips[0])
        for i in 0..<4 {
            let (c1, c2) = controls[i]
            path.addCurve(to: tips[(i + 1) % 4], control1: c1, control2: c2)
        }
        path.closeSubpath()
        return path
    }
}

/// The splash's star pair, laid out on Figma's 20×26 canvas: a 12pt star up top,
/// a 8pt one trailing below it.
struct SparklePair: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Sparkle()
                .frame(width: 12, height: 12)
                .offset(x: 0, y: 0)
            Sparkle()
                .frame(width: 8, height: 8)
                .offset(x: 12, y: 13)
        }
        .frame(width: 20, height: 26, alignment: .topLeading)
        .foregroundStyle(Pigment.splashSpark)
    }
}

#Preview {
    SparklePair()
        .padding()
        .background(Pigment.background)
}

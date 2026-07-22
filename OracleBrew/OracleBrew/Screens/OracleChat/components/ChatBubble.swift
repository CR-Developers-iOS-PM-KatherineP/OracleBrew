import SwiftUI

struct ChatBubble: View {
    let message: ChatMessage

    @Environment(\.layoutDirection) private var layoutDirection

    private var isUser: Bool { message.isFromUser }
    private let oracleFill = Color(hex: 0x2C1E48)

    /// Which physical edge the tail hangs off. The alignment below is semantic
    /// and mirrors itself in Arabic, but a Shape's path and an offset are both
    /// absolute — so the direction has to be spelled out for them.
    private var tailOnLeft: Bool {
        layoutDirection == .rightToLeft ? isUser : !isUser
    }

    var body: some View {
        HStack(spacing: 0) {
            if isUser { Spacer(minLength: 44) }

            Text(message.text)
                .font(Lettering.bodyMedium(14))
                .foregroundStyle(Pigment.cream)
                .lineSpacing(3)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(background)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                // The tail tucks under the bubble and fills the corner the
                // radius rounds off; only its tip clears the edge.
                .background(alignment: isUser ? .bottomTrailing : .bottomLeading) { tail }

            if !isUser { Spacer(minLength: 44) }
        }
    }

    @ViewBuilder
    private var background: some View {
        if isUser { Pigment.accentGradient } else { oracleFill }
    }

    private var tail: some View {
        BubbleTail(leading: tailOnLeft)
            .fill(isUser ? AnyShapeStyle(Pigment.accentGradient) : AnyShapeStyle(oracleFill))
            .frame(width: BubbleTail.size.width, height: BubbleTail.size.height)
            .offset(x: tailOnLeft ? -3 : 3)
    }
}

//
//  ChatBubble.swift
//  OracleBrew
//
//  Single message row — user bubbles trail right in the accent gradient with a
//  tail on the right, oracle bubbles lead left in a dark surface with a tail on
//  the left.
//

import SwiftUI

struct ChatBubble: View {
    let message: ChatMessage

    private var isUser: Bool { message.isFromUser }

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            if isUser { Spacer(minLength: 44) }
            if !isUser { tail(leading: true) }

            Text(message.text)
                .font(Lettering.body(14))
                .foregroundStyle(isUser ? Pigment.cardInk : Pigment.cream)
                .lineSpacing(3)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(background)
                .clipShape(RoundedRectangle(cornerRadius: 18))

            if isUser { tail(leading: false) }
            if !isUser { Spacer(minLength: 44) }
        }
    }

    @ViewBuilder
    private var background: some View {
        if isUser {
            Pigment.accentGradient
        } else {
            Color(hex: 0x2C1E48)
        }
    }

    /// Small pointed tail at the bubble's bottom corner.
    private func tail(leading: Bool) -> some View {
        BubbleTail(leading: leading)
            .fill(isUser ? AnyShapeStyle(Pigment.accentGradient) : AnyShapeStyle(Color(hex: 0x2C1E48)))
            .frame(width: 9, height: 16)
            .offset(x: leading ? 3 : -3)
    }
}

/// A curved tail that meets the bubble's bottom edge — points outward.
private struct BubbleTail: Shape {
    let leading: Bool

    func path(in rect: CGRect) -> Path {
        var path = Path()
        if leading {
            path.move(to: CGRect(x: rect.maxX, y: rect.minY, width: 0, height: 0).origin)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY),
                              control: CGPoint(x: rect.midX, y: rect.maxY))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY),
                              control: CGPoint(x: rect.maxX - 2, y: rect.midY))
        } else {
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY),
                              control: CGPoint(x: rect.midX, y: rect.maxY))
            path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.minY),
                              control: CGPoint(x: rect.minX + 2, y: rect.midY))
        }
        return path
    }
}

import SwiftUI

/// One row in the History list: the cup that was read, with the oracle badged
/// onto it, then the date, the topic and the reading itself. The chat chip is
/// present only when a chat grew from this reading and jumps into it; tapping
/// the card body opens the full result.
struct HistoryCard: View {
    let item: HistoryItem
    /// Opens the chat this reading led to.
    var onOpenChat: () -> Void = {}

    private let cardFill = Color(hex: 0x211836)

    private var dateLabel: String {
        item.date.formatted(.dateTime.month(.wide).day().year())
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            imageStack

            VStack(alignment: .leading, spacing: 4) {
                Text(dateLabel)
                    .font(Lettering.body(10))
                    .textCase(.uppercase)
                    .foregroundStyle(Pigment.cream.opacity(0.4))

                if let topic = item.topic {
                    topicChip(topic)
                }

                Text(item.preview)
                    .font(Lettering.body(12))
                    .foregroundStyle(Pigment.cream.opacity(0.8))
                    .lineSpacing(6)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 16)
        .background(RoundedRectangle(cornerRadius: 24).fill(cardFill))
        .overlay(alignment: .topTrailing) {
            if item.hasChat { chatChip }
        }
    }

    /// The cup fills the circle; the oracle sits in a rounded square notched
    /// into its bottom-right, ringed in the card's own fill.
    private var imageStack: some View {
        cup
            .frame(width: 80, height: 80)
            .clipShape(Circle())
            .overlay(alignment: .bottomTrailing) {
                oracleBadge.offset(x: 8, y: 8)
            }
            .frame(width: 80, height: 80)
    }

    private var cup: some View {
        Group {
            if let url = item.cupImageURL, !url.isEmpty {
                RemoteImage(urlString: url, cornerRadius: 40)
            } else {
                Image("SampleCupCard").resizable().scaledToFill()
            }
        }
    }

    private var oracleBadge: some View {
        Group {
            if let url = item.teller.portraitURL, !url.isEmpty {
                RemoteImage(urlString: url, cornerRadius: 12)
            } else {
                Image(item.teller.portrait).resizable().scaledToFill()
            }
        }
        .frame(width: 36, height: 36)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12).strokeBorder(cardFill, lineWidth: 3)
        )
    }

    /// The chip takes the topic's own hue, as the design does.
    private func topicChip(_ topic: Topic) -> some View {
        Text(topic.name)
            .font(Lettering.bodyMedium(10))
            .foregroundStyle(topic.color)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Capsule().fill(topic.color.opacity(0.15)))
            .overlay(Capsule().strokeBorder(topic.color.opacity(0.4), lineWidth: 1))
    }

    private var chatChip: some View {
        Button(action: onOpenChat) {
            Image("IconChat")
                .renderingMode(.template)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(Pigment.accent)
                .padding(6)
                .background(Circle().fill(Color.white.opacity(0.05)))
                // The chip is 32pt in the design; the hit area reaches the 44pt
                // minimum without it growing.
                .frame(width: Cadence.tapTarget, height: Cadence.tapTarget)
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .padding(.top, 4)
        .padding(.trailing, 4)
    }
}

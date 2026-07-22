import SwiftUI

/// One row in the Chats list. Flat with a hairline under it — not a card. The
/// avatar carries the cup from the reading the chat grew out of; a direct
/// Oracle Chat has no badge.
struct ChatThreadRow: View {
    let summary: ChatSummary
    /// The reading's cup photo, when it can be resolved. The chat list endpoint
    /// only carries `reading_id`, so this is looked up from History.
    var cupImageURL: String?

    @Environment(\.layoutDirection) private var layoutDirection

    var body: some View {
        HStack(spacing: 16) {
            avatar

            VStack(alignment: .leading, spacing: 4) {
                Text(summary.teller.name)
                    .font(Lettering.displayMedium(18))
                    .foregroundStyle(Pigment.cream)
                Text(summary.preview)
                    .font(Lettering.body(12))
                    .foregroundStyle(Pigment.cream.opacity(0.6))
                    .lineLimit(1)
                    .truncationMode(.tail)
            }

            Spacer(minLength: 8)

            VStack(alignment: .trailing, spacing: 0) {
                Text(RelativeTime.short(summary.date))
                    .font(Lettering.body(12))
                    .foregroundStyle(Pigment.cream.opacity(0.4))
                Spacer(minLength: 0)
                if summary.hasUnread {
                    Circle().fill(Pigment.accent).frame(width: 8, height: 8)
                }
            }
            .frame(height: 40)
        }
        .padding(12)
        .frame(height: 84)
        .background(Pigment.inkDeep)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.white.opacity(0.1))
                .frame(height: 1)
        }
    }

    private var avatar: some View {
        Group {
            if let url = summary.teller.portraitURL, !url.isEmpty {
                RemoteImage(urlString: url, cornerRadius: 24)
            } else {
                Image(summary.teller.portrait).resizable().scaledToFill()
            }
        }
        .frame(width: 60, height: 60)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(alignment: .bottomTrailing) {
            // `.bottomTrailing` mirrors itself; the nudge that pushes the badge
            // clear of the avatar's corner does not.
            if summary.fromReading { cupBadge.offset(x: 4 * layoutDirection.sign, y: 4) }
        }
    }

    /// The cup the reading was cast from. Falls back to a glyph while the photo
    /// can't be resolved — the badge still says "this came from a reading".
    private var cupBadge: some View {
        Group {
            if let cupImageURL, !cupImageURL.isEmpty {
                RemoteImage(urlString: cupImageURL, cornerRadius: 14)
            } else {
                Image(systemName: "cup.and.saucer.fill")
                    .font(.system(size: 11))
                    .foregroundStyle(Pigment.cream)
                    .frame(width: 28, height: 28)
                    .background(Circle().fill(Pigment.accent))
            }
        }
        .frame(width: 28, height: 28)
        .clipShape(Circle())
        .overlay(Circle().strokeBorder(Color(hex: 0x211836), lineWidth: 3))
    }
}

import SwiftUI
import UniformTypeIdentifiers

enum ShareCardRenderer {
    /// Stories artwork is 1080×1920; the card is laid out at the design's
    /// 900×1600, so rendering at 1.2× lands exactly on it.
    private static let scale: CGFloat = 1080 / ShareCard.size.width

    @MainActor
    static func render(photo: UIImage?, advice: String, timeframe: String) -> UIImage? {
        let renderer = ImageRenderer(content: ShareCard(photo: photo, advice: advice, timeframe: timeframe))
        renderer.scale = scale
        renderer.isOpaque = true
        return renderer.uiImage
    }
}

/// What the share sheet receives.
///
/// The file representation comes first, and deliberately so: several share
/// extensions — Telegram above all — silently fail to attach an image that
/// arrives as in-memory data, while a file-backed PNG goes through
/// everywhere. The data representation stays as the fallback for receivers
/// that ask for raw bytes.
struct ShareCardImage: Transferable {
    let image: UIImage

    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(exportedContentType: .png) { card in
            let url = FileManager.default.temporaryDirectory
                .appendingPathComponent("oraclebrew-reading.png")
            guard let data = card.image.pngData() else {
                throw ShareCardError.encodingFailed
            }
            try data.write(to: url, options: .atomic)
            return SentTransferredFile(url)
        }
        DataRepresentation(exportedContentType: .png) { card in
            guard let data = card.image.pngData() else {
                throw ShareCardError.encodingFailed
            }
            return data
        }
        .suggestedFileName("oraclebrew-reading.png")
    }
}

enum ShareCardError: Error {
    case encodingFailed
}

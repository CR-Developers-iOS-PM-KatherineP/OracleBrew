import SwiftUI

/// The design's cup-photo box: 353×395 at a 20pt radius, with 20pt side margins.
///
/// Both photo steps — shooting your own cup and being shown a random one — draw
/// the same box, and they used to size it two different ways. The flexible
/// `minHeight:maxHeight:` version let the photo grow until the content below it
/// no longer fit on a short screen; this one holds the design's aspect and fits
/// inside whatever room is left instead.
///
/// `Color.clear` is the size root on purpose: an image placed straight into the
/// frame lets `scaledToFill`'s own intrinsic size drive the layout, which is
/// what made the photo bleed past the side margins.
/// The box's own numbers, straight off the design. Non-generic so a caller can
/// reach the radius without naming a content type.
enum CupPhoto {
    static let radius: CGFloat = 20
    static let width: CGFloat = 353
    static let height: CGFloat = 395
}

struct CupPhotoBox<Content: View>: View {
    /// Whether the box clips its content. On for a photo that should fill and
    /// crop; off when the content draws its own shape — a dashed border sitting
    /// exactly on the clip boundary would otherwise lose half its stroke.
    var clipsContent: Bool = true
    @ViewBuilder var content: () -> Content

    var body: some View {
        let box = Color.clear
            .aspectRatio(CupPhoto.width / CupPhoto.height, contentMode: .fit)
            .frame(maxWidth: CupPhoto.width, maxHeight: CupPhoto.height)
            .overlay { content() }

        return Group {
            if clipsContent {
                box.clipShape(RoundedRectangle(cornerRadius: CupPhoto.radius))
            } else {
                box
            }
        }
        .frame(maxWidth: .infinity)
    }
}

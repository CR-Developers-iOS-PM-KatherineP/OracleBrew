import Photos
import UIKit

/// Saving an image to the user's library, with an answer about whether it worked.
///
/// `UIImageWriteToSavedPhotosAlbum` was here before, called with a nil
/// completion — so the confirmation fired the instant the call returned, before
/// the write had happened and whether or not it ever would. A user who had
/// refused photo access got "Saved to your photos" and nothing in their library.
enum PhotoLibrary {
    enum Failure: Error {
        /// The user has refused add-only access, so there is nowhere to write.
        case notPermitted
    }

    /// Adds the image to the library. Returns once it is actually written, and
    /// throws if it wasn't.
    static func save(_ image: UIImage) async throws {
        // Add-only: the app writes a card and never reads the library back, and
        // asking for less is the difference between one permission prompt and
        // the scarier full-access one.
        var status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        if status == .notDetermined {
            status = await PHPhotoLibrary.requestAuthorization(for: .addOnly)
        }
        guard status == .authorized || status == .limited else {
            throw Failure.notPermitted
        }

        try await PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }
    }
}

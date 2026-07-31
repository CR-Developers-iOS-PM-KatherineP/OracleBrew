import Foundation

/// Client-first features waiting on their backend half.
enum FeatureGates {
    /// Swipe-to-delete for chats and readings — live since the backend shipped
    /// DELETE /chats/{id}/ and /history/{id}/. The gate stays as the kill
    /// switch it was born as.
    static let deletion = true
}

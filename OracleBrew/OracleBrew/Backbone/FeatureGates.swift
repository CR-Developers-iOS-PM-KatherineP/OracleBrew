import Foundation

/// Client-first features waiting on their backend half.
enum FeatureGates {
    /// Swipe-to-delete for chats and readings. The client flow is done and the
    /// requests are final, but DELETE /chats/{id}/ and /readings/{id}/ answer
    /// 405 until the backend ships them — and a row that only pretends to die
    /// (it returns on the next fetch) reads as a bug, not a feature. Flip to
    /// true the day the endpoints go live; nothing else needs touching.
    static let deletion = false
}

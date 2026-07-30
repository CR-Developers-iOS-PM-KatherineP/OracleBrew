import AppTrackingTransparency

/// App Tracking Transparency — the one place the tracking prompt is raised.
///
/// Raised from the splash before its clip starts, so the dialog never hangs
/// over a moving screen. The system shows it once per install; later calls
/// resolve immediately with the settled status.
enum Beacon {
    /// Returns once the user has answered — whichever way they answered.
    static func request() async {
        _ = await ATTrackingManager.requestTrackingAuthorization()
    }
}

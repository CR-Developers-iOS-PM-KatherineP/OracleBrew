import AppTrackingTransparency

/// App Tracking Transparency — the one place the tracking prompt is raised.
///
/// Raised from the splash before its clip starts, so the dialog never hangs
/// over a moving screen. The system shows it once per install; later calls
/// resolve immediately with the settled status.
enum Beacon {
    /// Returns once the user has answered — whichever way they answered — with
    /// the settled status, for reporting.
    @discardableResult
    static func request() async -> String {
        let status = await ATTrackingManager.requestTrackingAuthorization()
        return label(for: status)
    }

    private static func label(for status: ATTrackingManager.AuthorizationStatus) -> String {
        switch status {
        case .authorized: "authorized"
        case .denied: "denied"
        case .restricted: "restricted"
        case .notDetermined: "not_determined"
        @unknown default: "unknown"
        }
    }
}

import SwiftUI

/// The app's way of saying something that doesn't need answering.
///
/// A photo saved, a message that didn't send — facts the user should see but
/// never has to acknowledge. An alert for those costs a tap and steals focus
/// from what they were doing; this appears, is read, and leaves.
///
/// Anything that genuinely needs a decision stays an alert.
@MainActor
@Observable
final class Tidings {
    static let shared = Tidings()

    private(set) var message: LocalizedStringKey?

    private var dismissal: Task<Void, Never>?

    private init() {}

    /// Shows a message, replacing whatever was on screen — the newest fact is
    /// the one worth reading, and two stacked capsules read as a mess.
    func say(_ message: LocalizedStringKey) {
        self.message = message
        dismissal?.cancel()
        dismissal = Task { [weak self] in
            try? await Task.sleep(for: .seconds(3))
            guard !Task.isCancelled else { return }
            self?.message = nil
        }
    }
}

extension View {
    /// Hosts the toast. Applied once, at the app's root, so a toast survives the
    /// screen that raised it going away.
    func toastLayer() -> some View {
        overlay(alignment: .top) { ToastCapsule() }
    }
}

private struct ToastCapsule: View {
    @State private var tidings = Tidings.shared

    var body: some View {
        ZStack {
            if let message = tidings.message {
                Text(message)
                    .font(Lettering.bodyMedium(13))
                    .foregroundStyle(Pigment.cream)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 12)
                    .pillPanel()
                    .padding(.horizontal, 32)
                    // Top, not bottom: every screen carries something along its
                    // bottom edge — the floating tab bar, an action row, the
                    // chat's input — and a capsule down there lands on one of
                    // them. Cleared past the tallest header (the flow's title,
                    // subtitle and step dots) so it sits over content instead.
                    .padding(.top, 150)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.25), value: tidings.message == nil)
        // Decoration over whatever the user is doing — it must never take a tap
        // meant for the screen underneath.
        .allowsHitTesting(false)
    }
}

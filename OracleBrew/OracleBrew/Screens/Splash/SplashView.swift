import SwiftUI

/// The launch screen: the ball, the wordmark, and the two corner glows.
///
/// It also owns the tracking prompt and the app's boot work. The order is
/// deliberate — the screen appears static, ATT is requested over it, and only
/// once the user has answered does the reveal animation run. Raising the dialog
/// over a moving screen looks broken, so nothing moves until it's dismissed.
struct SplashView: View {
    /// Boot work to run behind the animation — the session, catalog and profile.
    let bootstrap: () async -> Void
    let onFinish: () -> Void

    /// The splash holds at least this long once the animation starts, so a warm
    /// launch doesn't flash it for a single frame.
    private static let minimumHold = Duration.seconds(1.5)

    @Environment(\.scenePhase) private var scenePhase

    @State private var revealed = false
    @State private var pulsing = false
    @State private var started = false

    var body: some View {
        ZStack {
            // The glows overlay the backdrop rather than sitting behind it —
            // behind an opaque gradient they render to nothing.
            Pigment.splashBackdrop
                .overlay(alignment: .topLeading) { topGlow }
                .overlay(alignment: .bottomTrailing) { bottomGlow }

            Image("Ball")
                .resizable()
                .frame(width: 200, height: 200)
                .offset(y: -26)
                .opacity(revealed ? 1 : 0)
                .scaleEffect(revealed ? 1 : 0.85)

            VStack {
                Spacer()
                HStack(spacing: 4) {
                    // Verbatim, not a catalog key — the wordmark is the brand
                    // name and reads the same in every locale.
                    Text(verbatim: "Oracle Brew")
                        .font(Lettering.displayMedium(22))
                        .foregroundStyle(Pigment.cream)
                    SparklePair()
                }
                .padding(.bottom, 44)
                .opacity(revealed ? 1 : 0)
            }
        }
        .ignoresSafeArea()
        // Keyed on scenePhase because ATT only presents its dialog once the
        // scene is active — asked any earlier the system returns notDetermined
        // without ever showing it, and the prompt is then lost for good.
        .task(id: scenePhase) {
            guard scenePhase == .active, !started else { return }
            started = true

            await Beacon.request()

            withAnimation(.easeOut(duration: 0.6)) { revealed = true }
            withAnimation(.easeInOut(duration: 2.4).repeatForever(autoreverses: true)) {
                pulsing = true
            }

            let start = ContinuousClock.now
            await bootstrap()
            let remaining = Self.minimumHold - start.duration(to: .now)
            if remaining > .zero { try? await Task.sleep(for: remaining) }

            onFinish()
        }
    }

    // Figma draws both glows as a blurred circle inside an oversized frame that
    // hangs off the edge of the screen. The offsets place that frame's origin,
    // so they stay pinned to their corner on any diagonal.
    private var topGlow: some View {
        Circle()
            .fill(Pigment.splashGlowTop)
            .frame(width: 340, height: 340)
            .blur(radius: 110)
            .scaleEffect(pulsing ? 1.12 : 1)
            .offset(x: -150, y: -120)
    }

    private var bottomGlow: some View {
        Circle()
            .fill(Pigment.splashGlowBottom)
            .frame(width: 220, height: 220)
            .blur(radius: 55)
            .scaleEffect(pulsing ? 1.15 : 1)
            .offset(x: 67, y: -60)
    }
}

#Preview {
    SplashView(bootstrap: {}, onFinish: {})
}

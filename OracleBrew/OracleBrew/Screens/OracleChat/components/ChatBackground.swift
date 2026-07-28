import SwiftUI

struct ChatBackground: View {
    var body: some View {
        Pigment.background
            .overlay {
                Image("ChatBackground")
                    .resizable()
                    .scaledToFill()
            }
            .ignoresSafeArea()
            .allowsHitTesting(false)
            // Wallpaper. Without this VoiceOver announces the asset's name.
            .accessibilityHidden(true)
    }
}

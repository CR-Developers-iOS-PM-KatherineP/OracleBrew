import UIKit

/// The app's one way to make the phone respond to a touch.
///
/// Generators are never called inline: keeping them here means the strength of a
/// given moment is decided in one place, and a change to how the app feels is a
/// change to this file.
enum Resonance {
    /// A primary button — Continue, Take Photo, Send.
    static func tap() { UIImpactFeedbackGenerator(style: .light).impactOccurred() }

    /// A weighty, deliberate action: starting a reading, saving the profile.
    static func commit() { UIImpactFeedbackGenerator(style: .medium).impactOccurred() }

    /// Stepping through a set of values — picking a drink, an oracle, a topic, a
    /// date component.
    static func select() { UISelectionFeedbackGenerator().selectionChanged() }

    /// The reading landed, the profile saved.
    static func success() { UINotificationFeedbackGenerator().notificationOccurred(.success) }

    /// Something the user has to deal with.
    static func failure() { UINotificationFeedbackGenerator().notificationOccurred(.error) }

    /// How a shared button should feel, so a screen can say "this one is
    /// weighty" without reaching for a generator itself.
    enum Feel {
        case tap, commit, select, silent

        func play() {
            switch self {
            case .tap: Resonance.tap()
            case .commit: Resonance.commit()
            case .select: Resonance.select()
            case .silent: break
            }
        }
    }
}

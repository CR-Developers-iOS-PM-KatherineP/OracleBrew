import SwiftUI

/// Whether the user lets us share their purchase details with Apple to process
/// a refund.
///
/// Asked once, right after a purchase goes through, and reachable afterwards
/// from Settings — the answer is theirs to change. Both entry points drive this
/// one object so the alert can't end up with two versions of the truth.
@MainActor
@Observable
final class RefundConsent {
    static let shared = RefundConsent()

    /// Held in UserDefaults rather than `@AppStorage`: this is a service, and
    /// `@AppStorage` only tracks changes inside a view.
    private static let askedKey = "consent.refundAsked"

    var isPresented = false

    /// Drives the Settings row's visibility. Before the first purchase there is
    /// nothing to manage, and a row that opens a question about a purchase the
    /// user hasn't made reads as a mistake.
    private(set) var hasBeenAsked: Bool

    private init() {
        hasBeenAsked = UserDefaults.standard.bool(forKey: Self.askedKey)
    }

    /// Called from the purchase service's success path.
    ///
    /// Delayed on purpose: the paywall is still dismissing when a purchase
    /// completes, and an alert raised into that animation either fights it or is
    /// swallowed by it.
    func askAfterPurchase() {
        Task {
            try? await Task.sleep(for: .milliseconds(600))
            isPresented = true
        }
    }

    /// The Settings row — same question, asked again.
    func reopen() {
        isPresented = true
    }

    /// Either answer is reported. A refusal is an answer the backend needs too,
    /// and treating silence and "no" the same would lose that.
    func answer(consented: Bool) {
        hasBeenAsked = true
        UserDefaults.standard.set(true, forKey: Self.askedKey)
        Tally.shared.refund(consented: consented)
    }
}

extension View {
    /// Applied once at the root, like the toast layer: the alert outlives the
    /// screen that triggered it, and a paywall that dismisses itself would take
    /// an alert attached to it along.
    func refundConsentAlert() -> some View {
        modifier(RefundConsentAlert())
    }
}

private struct RefundConsentAlert: ViewModifier {
    @State private var consent = RefundConsent.shared

    func body(content: Content) -> some View {
        content
            .alert("consent.title", isPresented: $consent.isPresented) {
                Button("consent.allow") { consent.answer(consented: true) }
                Button("consent.deny", role: .cancel) { consent.answer(consented: false) }
            } message: {
                Text("consent.message")
            }
    }
}

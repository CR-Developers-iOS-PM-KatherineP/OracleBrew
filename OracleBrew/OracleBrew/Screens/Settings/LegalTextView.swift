import SwiftUI

struct LegalTextView: View {
    let title: LocalizedStringKey
    let text: String
    let onBack: () -> Void

    var body: some View {
        ZStack(alignment: .top) {
            Pigment.background.ignoresSafeArea()

            VStack(spacing: 0) {
                header
                ScrollView(showsIndicators: false) {
                    Text(text)
                        .font(Lettering.body(14))
                        .foregroundStyle(Pigment.cream.opacity(0.7))
                        .lineSpacing(5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                }
            }
            .padding(.horizontal, 20)
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private var header: some View {
        ZStack {
            Text(title)
                .font(Lettering.displayMedium(22))
                .foregroundStyle(Pigment.cream)
            HStack {
                Button(action: onBack) {
                    Image(systemName: "arrow.backward")
                        .accessibilityLabel("a11y.back")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Pigment.cream)
                        .frame(width: Cadence.tapTarget, height: Cadence.tapTarget)
                        .background(Circle().fill(Pigment.surface))
                }
                .buttonStyle(.plain)
                Spacer()
            }
        }
        .padding(.top, 4)
    }
}

enum LegalCopy {
    /// Held in the string catalog rather than as Swift literals: these are the
    /// only screens a reader might actually need in their own language, and as
    /// plain strings they stayed English while the rest of the app translated.
    static var privacyPolicy: String { String(localized: "legal.privacy") }
    static var termsOfUse: String { String(localized: "legal.terms") }
}

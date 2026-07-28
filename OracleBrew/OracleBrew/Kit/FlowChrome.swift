import SwiftUI

/// Centered title/subtitle with step dots, plus a top-right close chip.
struct FlowHeader: View {
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey
    /// nil hides the step dots (single-step flows, e.g. Oracle Chat's oracle pick).
    var step: Int? = nil
    var onBack: (() -> Void)? = nil
    let onClose: () -> Void

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 4) {
                Text(title)
                    .font(Lettering.displayMedium(24))
                    .foregroundStyle(Pigment.cream)
                Text(subtitle)
                    .font(Lettering.body(12))
                    .foregroundStyle(Pigment.creamDim)
                    .multilineTextAlignment(.center)
                if let step {
                    StepDots(current: step)
                        .padding(.top, 12)
                }
            }
            .frame(maxWidth: .infinity)

            HStack {
                if let onBack {
                    chip(systemName: "arrow.backward", label: "a11y.back", action: onBack)
                }
                Spacer()
                chip(systemName: "xmark", label: "a11y.close", action: onClose)
            }
        }
    }

    private func chip(systemName: String,
                      label: LocalizedStringKey,
                      action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Pigment.cream)
                .frame(width: Cadence.tapTarget, height: Cadence.tapTarget)
                .background(Circle().fill(Pigment.surface))
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        // Spelled out rather than left to the symbol: VoiceOver reads
        // "arrow.backward" as the identifier itself, and an explicit label keeps
        // both chips consistent.
        .accessibilityLabel(label)
    }
}

/// Full-width gradient pill CTA.
struct PrimaryButton: View {
    let title: LocalizedStringKey
    var enabled: Bool = true
    /// Light by default; a screen marks its weighty CTA `.commit`.
    var feel: Resonance.Feel = .tap
    let action: () -> Void

    var body: some View {
        Button { feel.play(); action() } label: {
            Text(title)
                .font(Lettering.displayMedium(20))
                .foregroundStyle(Pigment.cream)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Capsule().fill(Pigment.accentGradient))
                .contentShape(Capsule())
        }
        .buttonStyle(.plain)
        .opacity(enabled ? 1 : 0.5)
        .disabled(!enabled)
    }
}

/// Full-width outlined secondary CTA (same footprint as PrimaryButton).
struct SecondaryButton: View {
    let title: LocalizedStringKey
    var feel: Resonance.Feel = .tap
    let action: () -> Void

    var body: some View {
        Button { feel.play(); action() } label: {
            Text(title)
                .font(Lettering.displayMedium(20))
                .foregroundStyle(Pigment.cream)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .pillPanel()
                .contentShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

//
//  SettingsRow.swift
//  OracleBrew
//

import SwiftUI

/// One tappable row inside a SettingsCard — icon, title, trailing chevron.
struct SettingsRow: View {
    enum Weight { case medium, semibold }

    let icon: String
    let title: LocalizedStringKey
    var tint: Color = Pigment.cream
    var iconTint: Color = Pigment.accent
    var weight: Weight = .medium
    let action: () -> Void

    private var titleFont: Font {
        switch weight {
        case .medium: Lettering.displayMedium(16)
        case .semibold: Lettering.displaySemibold(16)
        }
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(iconTint)
                    .frame(width: 18, height: 18)

                Text(title)
                    .font(titleFont)
                    .foregroundStyle(tint)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Pigment.cream.opacity(0.4))
            }
            .padding(.horizontal, 16)
            .frame(height: 52)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

/// One row inside a SettingsCard with a trailing toggle instead of a chevron.
struct SettingsToggleRow: View {
    let icon: String
    let title: LocalizedStringKey
    var iconTint: Color = Pigment.accent
    @Binding var isOn: Bool
    var interactive: Bool = true
    var onTap: (() -> Void)? = nil

    var body: some View {
        // A row-wide onTapGesture would steal touches from the Toggle itself, so
        // it's only attached when the toggle is disabled (Camera/Notifications,
        // where the whole row deep-links to system Settings instead).
        Group {
            if interactive {
                row
            } else {
                row
                    .contentShape(Rectangle())
                    .onTapGesture { onTap?() }
            }
        }
    }

    private var row: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(iconTint)
                .frame(width: 18, height: 18)

            Text(title)
                .font(Lettering.displayMedium(16))
                .foregroundStyle(Pigment.cream)

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(Pigment.accent)
                .disabled(!interactive)
        }
        .padding(.horizontal, 16)
        .frame(height: 52)
    }
}

/// Card container — rounded, bordered, groups rows with SettingsDivider between them.
struct SettingsCard<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        VStack(spacing: 0) { content }
            .background(RoundedRectangle(cornerRadius: Cadence.cardRadius).fill(Pigment.settingsCard))
            .overlay(RoundedRectangle(cornerRadius: Cadence.cardRadius).strokeBorder(Color.white.opacity(0.1), lineWidth: 1))
            .clipShape(RoundedRectangle(cornerRadius: Cadence.cardRadius))
    }
}

struct SettingsDivider: View {
    var body: some View {
        Rectangle().fill(Color.white.opacity(0.1)).frame(height: 1)
    }
}

/// Uppercase muted label above a SettingsCard.
struct SettingsSectionLabel: View {
    let title: LocalizedStringKey

    var body: some View {
        Text(title)
            .font(Lettering.bodyMedium(12))
            .foregroundStyle(Pigment.cream.opacity(0.2))
            .textCase(.uppercase)
    }
}

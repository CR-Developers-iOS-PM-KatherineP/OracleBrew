//
//  SettingsButton.swift
//  OracleBrew
//
//  The gear that opens Settings. Lives in every tab's header, so it pushes
//  onto whichever tab's Pathfinder is in the environment.
//

import SwiftUI

struct SettingsButton: View {
    @Environment(Pathfinder.self) private var router

    var body: some View {
        Button {
            router.push(.settings)
        } label: {
            Image(systemName: "gearshape")
                .font(.system(size: 18))
                .foregroundStyle(Pigment.cream)
                .frame(width: Cadence.tapTarget, height: Cadence.tapTarget)
                .background(Circle().fill(Pigment.surface))
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
    }
}

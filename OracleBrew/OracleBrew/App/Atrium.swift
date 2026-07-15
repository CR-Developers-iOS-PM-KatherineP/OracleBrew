//
//  Atrium.swift
//  OracleBrew
//
//  Root container: 3-tab shell (Brew / Chats / History) with a custom floating
//  pill tab bar. Each tab owns its own NavigationStack + Pathfinder router.
//

import SwiftUI

struct Atrium: View {
    @State private var tab: RootTab = .brew
    @State private var brewRouter = Pathfinder()
    @State private var profileStore = UserProfileStore()

    /// The floating tab bar only makes sense at each tab's root — once a tab
    /// pushes a destination, it'd otherwise float on top of that content too
    /// (it's a ZStack sibling, not scoped to any one NavigationStack).
    private var showTabBar: Bool {
        switch tab {
        case .brew: brewRouter.path.isEmpty
        case .chats, .history: true
        }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Pigment.background.ignoresSafeArea()

            switch tab {
            case .brew:
                NavigationStack(path: $brewRouter.path) {
                    BrewView()
                        .waypointDestinations(brewRouter)
                }
                .environment(brewRouter)
            case .chats:
                TabPlaceholder(title: "tab.chats")
            case .history:
                TabPlaceholder(title: "tab.history")
            }

            if showTabBar {
                TabBar(selection: $tab)
            }
        }
        .environment(profileStore)
    }
}

/// Temporary stand-in for tabs/flows not yet built.
private struct TabPlaceholder: View {
    let title: LocalizedStringKey
    var body: some View {
        ZStack {
            Pigment.background.ignoresSafeArea()
            Text(title)
                .font(Lettering.displayMedium(24))
                .foregroundStyle(Pigment.cream)
        }
    }
}

#Preview {
    Atrium()
}

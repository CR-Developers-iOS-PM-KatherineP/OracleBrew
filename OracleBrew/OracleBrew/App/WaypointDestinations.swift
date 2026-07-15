//
//  WaypointDestinations.swift
//  OracleBrew
//
//  Every tab can reach Settings (and Profile through it), so each tab's
//  NavigationStack registers the same Waypoint destinations against its own
//  router rather than Atrium owning them for the Brew tab alone.
//

import SwiftUI

extension View {
    func waypointDestinations(_ router: Pathfinder) -> some View {
        navigationDestination(for: Waypoint.self) { waypoint in
            switch waypoint {
            case .settings:
                SettingsView(onBack: router.pop) { router.push(.profile) }
            case .profile:
                ProfileView(onBack: router.pop, onSaved: router.pop)
            }
        }
    }
}

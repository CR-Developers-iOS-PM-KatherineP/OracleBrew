//
//  TabChrome.swift
//  OracleBrew
//
//  The 3 root tabs and the custom floating pill tab bar.
//

import SwiftUI

enum RootTab: CaseIterable {
    case brew, chats, history

    var titleKey: LocalizedStringKey {
        switch self {
        case .brew: "tab.brew"
        case .chats: "tab.chats"
        case .history: "tab.history"
        }
    }

    var symbol: String {
        switch self {
        case .brew: "cup.and.saucer"
        case .chats: "bubble.left"
        case .history: "list.bullet.rectangle"
        }
    }
}

struct TabBar: View {
    @Binding var selection: RootTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(RootTab.allCases, id: \.self) { tab in
                Button {
                    selection = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.symbol)
                            .font(.system(size: 20, weight: .regular))
                            .frame(height: 28)
                        Text(tab.titleKey)
                            .font(Lettering.body(11))
                    }
                    .foregroundStyle(selection == tab ? Pigment.accent : Pigment.mutedText)
                    .frame(maxWidth: .infinity)
                    .frame(height: Cadence.tabBarHeight)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, Cadence.tabBarSidePadding)
        .frame(height: Cadence.tabBarHeight)
        .background(
            Capsule().fill(Pigment.surface)
        )
        .padding(.horizontal, Cadence.sidePadding)
        .padding(.bottom, Cadence.tabBarInset)
    }
}

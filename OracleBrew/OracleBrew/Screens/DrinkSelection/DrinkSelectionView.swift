//
//  DrinkSelectionView.swift
//  OracleBrew
//
//  Brew Reading — step 1. Pick a drink (or Random Cup) from the catalog.
//

import SwiftUI

struct DrinkSelectionView: View {
    @Environment(ReadingDraft.self) private var draft
    let onContinue: () -> Void
    let onClose: () -> Void

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ZStack(alignment: .top) {
            Pigment.background.ignoresSafeArea()

            VStack(spacing: 0) {
                FlowHeader(
                    title: "drink.title",
                    subtitle: "drink.subtitle",
                    step: 1,
                    onClose: onClose
                )
                .padding(.top, 4)

                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(DrinkCatalog.all) { drink in
                            DrinkCard(
                                drink: drink,
                                isSelected: draft.drink == drink,
                                dimmed: draft.drink != nil && draft.drink != drink
                            ) {
                                draft.drink = drink
                            }
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 110)
                }
            }
            .padding(.horizontal, 20)

            if draft.drink != nil {
                continueBar
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private var continueBar: some View {
        VStack {
            Spacer()
            PrimaryButton(title: "flow.continue", action: onContinue)
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
                .background(
                    LinearGradient(
                        colors: [Pigment.background.opacity(0), Pigment.background],
                        startPoint: .top, endPoint: .bottom
                    )
                    .frame(height: 120)
                    .allowsHitTesting(false),
                    alignment: .bottom
                )
        }
    }
}

//
//  ChatBackground.swift
//  OracleBrew
//
//  The chat's ornament, now the designer's own artwork rather than the code
//  approximation that stood in for it. The tile is drawn at screen size in the
//  design, so it fills rather than repeats.
//

import SwiftUI

struct ChatBackground: View {
    var body: some View {
        Pigment.background
            .overlay {
                Image("ChatBackground")
                    .resizable()
                    .scaledToFill()
            }
            .ignoresSafeArea()
            .allowsHitTesting(false)
    }
}

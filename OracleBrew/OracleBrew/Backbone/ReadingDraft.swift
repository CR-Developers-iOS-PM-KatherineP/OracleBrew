//
//  ReadingDraft.swift
//  OracleBrew
//
//  In-progress Brew Reading, shared across the flow steps via environment.
//  Grows as later steps (teller, intention, photo) land.
//

import SwiftUI

@Observable
final class ReadingDraft {
    var drink: Drink?
    var teller: FortuneTeller?
    // intention / photo added as their steps are built.
}

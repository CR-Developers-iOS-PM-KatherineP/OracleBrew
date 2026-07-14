# Graph Report - OracleBrew  (2026-07-14)

## Corpus Check
- 38 files · ~8,608 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 263 nodes · 373 edges · 22 communities (16 shown, 6 thin omitted)
- Extraction: 94% EXTRACTED · 6% INFERRED · 0% AMBIGUOUS · INFERRED: 21 edges (avg confidence: 0.81)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `f72d4ae9`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- Backbone Services & Mock Data
- Layout Metrics (Cadence)
- App Entry & Typography
- Root Shell & Flow Chrome
- Brew Reading Wizard
- Drink Catalog & Reading Draft
- Fortune Teller Data
- Colors & Flow Cards
- Routing (Pathfinder)
- Flow Layout Engine
- Teller Card & Chips
- Tab Bar & Root Tabs
- Star Rating
- Design System Concepts (spec)
- App Architecture (spec)
- Figma MCP Config
- LocalizedStringKey
- String
- Int
- Waypoint
- PhotoUploadView
- ReadingDraft

## God Nodes (most connected - your core abstractions)
1. `SwiftUI` - 30 edges
2. `FortuneTeller` - 17 edges
3. `CameraPicker` - 12 edges
4. `Drink` - 12 edges
5. `Topic` - 11 edges
6. `Coordinator` - 9 edges
7. `PhotoUploadView` - 9 edges
8. `RootTab` - 9 edges
9. `ReadingDraft` - 8 edges
10. `TimeHorizon` - 8 edges

## Surprising Connections (you probably didn't know these)
- `BrewReadingFlow` --calls--> `ReadingDraft`  [INFERRED]
  OracleBrew/OracleBrew/Screens/BrewReading/BrewReadingFlow.swift → OracleBrew/OracleBrew/Backbone/ReadingDraft.swift
- `Pigment` --calls--> `Color`  [INFERRED]
  OracleBrew/OracleBrew/Kit/StarRating.swift → OracleBrew/OracleBrew/Kit/Pigment.swift
- `TellerCard` --calls--> `Color`  [INFERRED]
  OracleBrew/OracleBrew/Screens/FortuneTellers/components/TellerCard.swift → OracleBrew/OracleBrew/Kit/Pigment.swift
- `Atrium` --references--> `RootTab`  [EXTRACTED]
  OracleBrew/OracleBrew/App/Atrium.swift → OracleBrew/OracleBrew/Kit/TabChrome.swift
- `Atrium` --calls--> `Pathfinder`  [INFERRED]
  OracleBrew/OracleBrew/App/Atrium.swift → OracleBrew/OracleBrew/Backbone/Pathfinder.swift

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **** — docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_brew_reading_flow, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_drink_catalog, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_reading_engine, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_reading_result, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_fortune_teller_provider [INFERRED 0.80]
- **** — docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_mvvm_router, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_pathfinder, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_waypoint, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_atrium [INFERRED 0.80]

## Communities (22 total, 6 thin omitted)

### Community 0 - "Backbone Services & Mock Data"
Cohesion: 0.10
Nodes (26): Backbone (Services + Mock Data), Brew Reading Flow, ChatEngine, Deferred Scope (Not in v1.0), DrinkCatalog, Fortune Teller Characters, FortuneTellerProvider, HistoryStore (+18 more)

### Community 1 - "Layout Metrics (Cadence)"
Cohesion: 0.11
Nodes (14): CoreText, Bool, String, TopicChip, BrewModel, LocalizedStringKey, String, BrewView (+6 more)

### Community 2 - "App Entry & Typography"
Cohesion: 0.15
Nodes (9): App, Font, Ignition, Lettering, CGFloat, LocalizedStringKey, Void, TellerProfileView (+1 more)

### Community 3 - "Root Shell & Flow Chrome"
Cohesion: 0.13
Nodes (11): Binding, Color, Content, Item, SegmentedSelector, LocalizedStringKey, IntentionView, Bool (+3 more)

### Community 4 - "Brew Reading Wizard"
Cohesion: 0.13
Nodes (19): Int, FlowHeader, PrimaryButton, SecondaryButton, Bool, LocalizedStringKey, String, Void (+11 more)

### Community 5 - "Drink Catalog & Reading Draft"
Cohesion: 0.21
Nodes (9): Equatable, Drink, DrinkCatalog, Bool, LocalizedStringKey, String, DrinkCard, Bool (+1 more)

### Community 6 - "Fortune Teller Data"
Cohesion: 0.21
Nodes (11): Identifiable, FortuneTeller, FortuneTellerRoster, Review, Bool, Double, Int, String (+3 more)

### Community 7 - "Colors & Flow Cards"
Cohesion: 0.11
Nodes (16): LinearGradient, Color, Pigment, Double, Pigment, RatingLabel, StarRow, CGFloat (+8 more)

### Community 9 - "Flow Layout Engine"
Cohesion: 0.27
Nodes (7): CGRect, CGSize, Layout, FlowLayout, CGFloat, ProposedViewSize, Subviews

### Community 11 - "Tab Bar & Root Tabs"
Cohesion: 0.12
Nodes (16): Any, Context, NSObject, Cadence, Screen, CGFloat, CameraPicker, Coordinator (+8 more)

### Community 12 - "Star Rating"
Cohesion: 0.08
Nodes (22): CaseIterable, Hasher, LocalizedStringKey, Bool, LocalizedStringKey, TimeHorizon, days, month (+14 more)

### Community 13 - "Design System Concepts (spec)"
Cohesion: 0.33
Nodes (6): Cadence (Metrics), Design System (Kit), Figma Source of Truth, Lettering (Fonts), Pigment (Colors), Platform Constraints (iOS 17, iPhone, Portrait, Light)

### Community 14 - "App Architecture (spec)"
Cohesion: 1.00
Nodes (3): Atrium (Root Container), Build Order, Ignition (@main App Entry)

### Community 19 - "Waypoint"
Cohesion: 0.13
Nodes (10): Foundation, Hashable, Atrium, LocalizedStringKey, TabPlaceholder, Pathfinder, Waypoint, brewReading (+2 more)

### Community 20 - "PhotoUploadView"
Cohesion: 0.22
Nodes (6): PhotoUploadView, Bool, LocalizedStringKey, Void, PhotosPickerItem, PhotosUI

### Community 21 - "ReadingDraft"
Cohesion: 0.25
Nodes (7): Drink, FortuneTeller, ReadingDraft, String, UIImage, TimeHorizon, Topic

## Knowledge Gaps
- **28 isolated node(s):** `tellers`, `intention`, `photo`, `result`, `PhotosUI` (+23 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **6 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `SwiftUI` connect `Layout Metrics (Cadence)` to `App Entry & Typography`, `Root Shell & Flow Chrome`, `Brew Reading Wizard`, `Drink Catalog & Reading Draft`, `Fortune Teller Data`, `Colors & Flow Cards`, `Flow Layout Engine`, `Tab Bar & Root Tabs`, `Star Rating`, `Waypoint`, `PhotoUploadView`, `ReadingDraft`?**
  _High betweenness centrality (0.332) - this node is a cross-community bridge._
- **Why does `FortuneTeller` connect `Fortune Teller Data` to `Layout Metrics (Cadence)`, `App Entry & Typography`, `Drink Catalog & Reading Draft`, `Star Rating`, `Waypoint`?**
  _High betweenness centrality (0.062) - this node is a cross-community bridge._
- **Are the 2 inferred relationships involving `CameraPicker` (e.g. with `.imagePickerController()` and `.imagePickerControllerDidCancel()`) actually correct?**
  _`CameraPicker` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `tellers`, `intention`, `photo` to the rest of the system?**
  _28 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Backbone Services & Mock Data` be split into smaller, more focused modules?**
  _Cohesion score 0.10153846153846154 - nodes in this community are weakly interconnected._
- **Should `Layout Metrics (Cadence)` be split into smaller, more focused modules?**
  _Cohesion score 0.11052631578947368 - nodes in this community are weakly interconnected._
- **Should `Root Shell & Flow Chrome` be split into smaller, more focused modules?**
  _Cohesion score 0.13333333333333333 - nodes in this community are weakly interconnected._
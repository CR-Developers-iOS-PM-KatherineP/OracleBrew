# Graph Report - OracleBrew  (2026-07-15)

## Corpus Check
- 51 files · ~14,019 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 437 nodes · 674 edges · 50 communities (20 shown, 30 thin omitted)
- Extraction: 93% EXTRACTED · 7% INFERRED · 0% AMBIGUOUS · INFERRED: 47 edges (avg confidence: 0.81)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `117f9d28`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- ReadingDraft
- View
- Drink
- SwiftUI
- ReadingSession
- Backbone (Services + Mock Data)
- FortuneTeller
- CameraPicker
- RootTab
- Lettering
- ReadingStep
- Reading
- FlowLayout
- FlowHeader
- Design System (Kit)
- OracleChatEntryFlow
- Atrium (Root Container)
- .mcp.json
- CGFloat
- Drink
- FortuneTeller
- Int
- LocalizedStringKey
- ReadingDraft
- ReadingDraft
- ReadingDraft
- RootTab
- TimeHorizon
- Topic
- Void
- Double
- Interest
- RootTab
- Date
- Bool
- Bool
- FortuneTeller
- Hasher
- Bool
- Drink
- FortuneTeller
- Hasher
- UIImage
- UUID
- CGFloat
- NavigationPath
- String
- String
- CGFloat
- NavigationPath

## God Nodes (most connected - your core abstractions)
1. `SwiftUI` - 40 edges
2. `Zodiac` - 19 edges
3. `UserProfile` - 17 edges
4. `FortuneTeller` - 17 edges
5. `ProfileView` - 15 edges
6. `ReadingDraft` - 14 edges
7. `ReadingResultView` - 13 edges
8. `Employment` - 12 edges
9. `Drink` - 12 edges
10. `Topic` - 12 edges

## Surprising Connections (you probably didn't know these)
- `Atrium` --calls--> `UserProfileStore`  [INFERRED]
  OracleBrew/OracleBrew/App/Atrium.swift → OracleBrew/OracleBrew/Backbone/UserProfile.swift
- `ProfileView` --calls--> `UserProfile`  [INFERRED]
  OracleBrew/OracleBrew/Screens/Profile/ProfileView.swift → OracleBrew/OracleBrew/Backbone/UserProfile.swift
- `Pigment` --calls--> `Color`  [INFERRED]
  OracleBrew/OracleBrew/Kit/StarRating.swift → OracleBrew/OracleBrew/Kit/Pigment.swift
- `TellerCard` --calls--> `Color`  [INFERRED]
  OracleBrew/OracleBrew/Screens/FortuneTellers/components/TellerCard.swift → OracleBrew/OracleBrew/Kit/Pigment.swift
- `BrewReadingFlow` --calls--> `ReadingDraft`  [INFERRED]
  OracleBrew/OracleBrew/Screens/BrewReading/BrewReadingFlow.swift → OracleBrew/OracleBrew/Backbone/ReadingDraft.swift

## Import Cycles
- None detected.

## Communities (50 total, 30 thin omitted)

### Community 0 - "ReadingDraft"
Cohesion: 0.10
Nodes (19): Equatable, Foundation, ChatEngine, ChatMessage, Bool, FortuneTeller, String, ReadingDraft (+11 more)

### Community 1 - "View"
Cohesion: 0.11
Nodes (24): Binding, Color, Reading, IntentionView, Bool, LocalizedStringKey, String, Void (+16 more)

### Community 2 - "Drink"
Cohesion: 0.10
Nodes (18): Double, Drink, DrinkCatalog, Bool, LocalizedStringKey, String, Color, Pigment (+10 more)

### Community 3 - "SwiftUI"
Cohesion: 0.07
Nodes (19): LinearGradient, StepDots, Int, BrewModel, LocalizedStringKey, String, BrewView, CGFloat (+11 more)

### Community 4 - "ReadingSession"
Cohesion: 0.12
Nodes (15): Hashable, Country, CountryCatalog, String, Bool, Hasher, Topic, TopicCatalog (+7 more)

### Community 5 - "Backbone (Services + Mock Data)"
Cohesion: 0.10
Nodes (26): Backbone (Services + Mock Data), Brew Reading Flow, ChatEngine, Deferred Scope (Not in v1.0), DrinkCatalog, Fortune Teller Characters, FortuneTellerProvider, HistoryStore (+18 more)

### Community 6 - "FortuneTeller"
Cohesion: 0.11
Nodes (18): Hasher, Identifiable, FortuneTeller, FortuneTellerRoster, Review, Bool, Double, Int (+10 more)

### Community 7 - "CameraPicker"
Cohesion: 0.12
Nodes (16): Any, Context, NSObject, Cadence, Screen, CGFloat, CameraPicker, Coordinator (+8 more)

### Community 8 - "RootTab"
Cohesion: 0.14
Nodes (9): Atrium, LocalizedStringKey, TabPlaceholder, Pathfinder, Waypoint, brewReading, profile, settings (+1 more)

### Community 9 - "Lettering"
Cohesion: 0.13
Nodes (10): App, CGFloat, CoreText, Font, Ignition, Lettering, LocalizedStringKey, Void (+2 more)

### Community 10 - "ReadingStep"
Cohesion: 0.18
Nodes (10): BrewReadingFlow, FlowStub, ReadingStep, chat, intention, photo, result, tellers (+2 more)

### Community 11 - "Reading"
Cohesion: 0.36
Nodes (6): ReadingEngine, ReadingSymbol, SeededGenerator, String, RandomNumberGenerator, UInt64

### Community 12 - "FlowLayout"
Cohesion: 0.27
Nodes (7): CGRect, CGSize, Layout, FlowLayout, CGFloat, ProposedViewSize, Subviews

### Community 13 - "FlowHeader"
Cohesion: 0.31
Nodes (8): FlowHeader, PrimaryButton, SecondaryButton, Bool, Int, LocalizedStringKey, String, Void

### Community 14 - "Design System (Kit)"
Cohesion: 0.33
Nodes (6): Cadence (Metrics), Design System (Kit), Figma Source of Truth, Lettering (Fonts), Pigment (Colors), Platform Constraints (iOS 17, iPhone, Portrait, Light)

### Community 15 - "OracleChatEntryFlow"
Cohesion: 0.06
Nodes (46): CaseIterable, Codable, LocalizedStringKey, TimeHorizon, days, month, year, ChildrenStatus (+38 more)

### Community 16 - "Atrium (Root Container)"
Cohesion: 1.00
Nodes (3): Atrium (Root Container), Build Order, Ignition (@main App Entry)

### Community 26 - "RootTab"
Cohesion: 0.09
Nodes (27): Content, Item, Label, SegmentedSelector, LocalizedStringKey, DropdownChevron, DropdownOverlay, DropdownRow (+19 more)

### Community 31 - "Interest"
Cohesion: 0.19
Nodes (10): Interest, InterestCatalog, String, InterestChip, ProfileChip, ProfileSectionLabel, Bool, LocalizedStringKey (+2 more)

### Community 32 - "RootTab"
Cohesion: 0.29
Nodes (7): RootTab, brew, chats, history, LocalizedStringKey, String, TabBar

## Knowledge Gaps
- **63 isolated node(s):** `female`, `male`, `ratherNot`, `married`, `inRelationship` (+58 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **30 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `SwiftUI` connect `SwiftUI` to `ReadingDraft`, `RootTab`, `Drink`, `View`, `ReadingSession`, `FortuneTeller`, `CameraPicker`, `RootTab`, `Lettering`, `ReadingStep`, `FlowLayout`, `FlowHeader`, `RootTab`, `Interest`?**
  _High betweenness centrality (0.243) - this node is a cross-community bridge._
- **Why does `ProfileView` connect `RootTab` to `RootTab`, `View`, `Interest`, `OracleChatEntryFlow`?**
  _High betweenness centrality (0.075) - this node is a cross-community bridge._
- **Why does `UserProfile` connect `OracleChatEntryFlow` to `ReadingDraft`, `RootTab`?**
  _High betweenness centrality (0.067) - this node is a cross-community bridge._
- **What connects `female`, `male`, `ratherNot` to the rest of the system?**
  _63 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ReadingDraft` be split into smaller, more focused modules?**
  _Cohesion score 0.09788359788359788 - nodes in this community are weakly interconnected._
- **Should `View` be split into smaller, more focused modules?**
  _Cohesion score 0.11261261261261261 - nodes in this community are weakly interconnected._
- **Should `Drink` be split into smaller, more focused modules?**
  _Cohesion score 0.10144927536231885 - nodes in this community are weakly interconnected._
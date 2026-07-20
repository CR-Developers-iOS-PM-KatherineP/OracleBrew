# Graph Report - OracleBrew  (2026-07-20)

## Corpus Check
- 92 files · ~28,235 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 947 nodes · 1568 edges · 99 communities (39 shown, 60 thin omitted)
- Extraction: 93% EXTRACTED · 7% INFERRED · 0% AMBIGUOUS · INFERRED: 115 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `ce75c270`
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
- Drink
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
- Topic
- Double
- Interest
- RootTab
- Date
- Bool
- Bool
- Hasher
- Bool
- Drink
- FortuneTeller
- Hasher
- UIImage
- UUID
- CGFloat
- NavigationPath
- FlowHeader
- .section
- NavigationPath
- LocalizedStringKey
- DecodedImages
- IntentionView
- FlowCard
- HistoryItem
- String
- ChatsView
- Country
- RandomCupView
- Ignition
- DrinkSelectionView
- Pathfinder
- EmptyState
- .short
- TopicChip
- BrewModel
- BrewView
- ChatBubble
- .init
- ChatSummary
- ReadingDraft
- ReadingDraft
- Context
- Emissary
- EmissaryFailure
- Encoder
- Image
- Item
- Drink
- FortuneTeller
- Topic
- FortuneTeller
- Reading
- Drink
- FortuneTeller
- Reading
- Topic
- FortuneTeller
- Pathfinder
- Reading
- FortuneTeller
- Reading
- Reading
- FortuneTeller
- ReadingDTO
- ReadingResultDTO
- ShareCardImage
- Text
- TimeHorizon
- UIImage
- Void

## God Nodes (most connected - your core abstractions)
1. `View` - 70 edges
2. `SwiftUI` - 62 edges
3. `FortuneTeller` - 27 edges
4. `EmissaryRequest` - 25 edges
5. `CodingKeys` - 22 edges
6. `EmissaryFailure` - 22 edges
7. `Color` - 22 edges
8. `Foundation` - 21 edges
9. `CodingKeys` - 20 edges
10. `ReadingDraft` - 20 edges

## Surprising Connections (you probably didn't know these)
- `Pigment` --calls--> `Color`  [INFERRED]
  OracleBrew/OracleBrew/Kit/StarRating.swift → OracleBrew/OracleBrew/Kit/Pigment.swift
- `SettingsButton` --references--> `View`  [EXTRACTED]
  OracleBrew/OracleBrew/Kit/SettingsButton.swift → OracleBrew/OracleBrew/App/WaypointDestinations.swift
- `ChatBackground` --references--> `View`  [EXTRACTED]
  OracleBrew/OracleBrew/Screens/OracleChat/components/ChatBackground.swift → OracleBrew/OracleBrew/App/WaypointDestinations.swift
- `OracleChatView` --calls--> `ChatRepository`  [INFERRED]
  OracleBrew/OracleBrew/Screens/OracleChat/OracleChatView.swift → OracleBrew/OracleBrew/Backbone/Network/ChatRepository.swift
- `ReadingLoadingView` --calls--> `ReadingService`  [INFERRED]
  OracleBrew/OracleBrew/Screens/Loading/ReadingLoadingView.swift → OracleBrew/OracleBrew/Backbone/Network/ReadingService.swift

## Import Cycles
- None detected.

## Communities (99 total, 60 thin omitted)

### Community 0 - "ReadingDraft"
Cohesion: 0.18
Nodes (11): Employment, Interest, InterestCatalog, String, InterestChip, ProfileChip, ProfileSectionLabel, Bool (+3 more)

### Community 1 - "View"
Cohesion: 0.25
Nodes (9): Reading, Color, Double, ReadingResultView, Image, LocalizedStringKey, String, Void (+1 more)

### Community 2 - "Drink"
Cohesion: 0.12
Nodes (14): CatalogStore, Int, String, Drink, DrinkCatalog, Bool, LocalizedStringKey, String (+6 more)

### Community 3 - "SwiftUI"
Cohesion: 0.09
Nodes (24): HTTPURLResponse, AnyEncodable, Data, HTTPMethod, delete, get, patch, post (+16 more)

### Community 4 - "ReadingSession"
Cohesion: 0.05
Nodes (41): CodingKey, CodingKeys, assistantMessage, createdAt, hasUnreadFromOracle, id, lastMessage, messages (+33 more)

### Community 5 - "Backbone (Services + Mock Data)"
Cohesion: 0.10
Nodes (26): Backbone (Services + Mock Data), Brew Reading Flow, ChatEngine, Deferred Scope (Not in v1.0), DrinkCatalog, Fortune Teller Characters, FortuneTellerProvider, HistoryStore (+18 more)

### Community 6 - "FortuneTeller"
Cohesion: 0.14
Nodes (10): LegalCopy, LegalTextView, LocalizedStringKey, String, Void, SettingsDestination, privacy, terms (+2 more)

### Community 7 - "CameraPicker"
Cohesion: 0.12
Nodes (16): NSObject, Cadence, Screen, CGFloat, CameraPicker, Coordinator, Any, Bool (+8 more)

### Community 8 - "RootTab"
Cohesion: 0.06
Nodes (36): Encodable, JSONDecoder, APIConfig, String, CatalogMapper, CatalogRepository, DailyFortuneDTO, Int (+28 more)

### Community 9 - "Lettering"
Cohesion: 0.33
Nodes (4): CGFloat, CoreText, Font, Lettering

### Community 10 - "ReadingStep"
Cohesion: 0.06
Nodes (51): Decodable, CodingKeys, authorName, bio, createdAt, description, id, illustration (+43 more)

### Community 11 - "Reading"
Cohesion: 0.09
Nodes (15): Pathfinder, HistoryItem, ReadingHistoryStore, Bool, Date, Hasher, Int, String (+7 more)

### Community 12 - "FlowLayout"
Cohesion: 0.07
Nodes (26): CGSize, Error, Layout, BubbleTail, Bool, CGRect, FlowLayout, CGFloat (+18 more)

### Community 13 - "Drink"
Cohesion: 0.40
Nodes (3): RandomCupView, Int, Void

### Community 14 - "Design System (Kit)"
Cohesion: 0.33
Nodes (6): Cadence (Metrics), Design System (Kit), Figma Source of Truth, Lettering (Fonts), Pigment (Colors), Platform Constraints (iOS 17, iPhone, Portrait, Light)

### Community 15 - "OracleChatEntryFlow"
Cohesion: 0.05
Nodes (47): CaseIterable, Codable, ChildrenStatus, have, none, planning, Employment, both (+39 more)

### Community 16 - "Atrium (Root Container)"
Cohesion: 1.00
Nodes (3): Atrium (Root Container), Build Order, Ignition (@main App Entry)

### Community 19 - "Drink"
Cohesion: 0.06
Nodes (39): Equatable, Identifiable, ChatEngine, ChatMessage, Bool, String, FortuneTeller, FortuneTellerRoster (+31 more)

### Community 20 - "FortuneTeller"
Cohesion: 0.40
Nodes (4): EmptyState, LocalizedStringKey, String, Void

### Community 22 - "LocalizedStringKey"
Cohesion: 0.07
Nodes (27): AnyClass, AVCapturePhoto, AVCapturePhotoCaptureDelegate, AVCapturePhotoOutput, AVCaptureSession, AVCaptureVideoPreviewLayer, CameraPreview, CupCamera (+19 more)

### Community 24 - "ReadingDraft"
Cohesion: 0.14
Nodes (13): BrewReadingFlow, FlowStub, ReadingStep, chat, intention, loading, photo, result (+5 more)

### Community 26 - "RootTab"
Cohesion: 0.10
Nodes (26): Label, DropdownChevron, DropdownOverlay, DropdownRow, ProfileFieldBox, Bool, CGFloat, Content (+18 more)

### Community 30 - "Double"
Cohesion: 0.29
Nodes (7): Kind, failure, offline, ScreenStateView, LocalizedStringKey, String, Void

### Community 35 - "Bool"
Cohesion: 0.10
Nodes (22): ChatListItemDTO, ChatMessage, ChatRepository, Date, FortuneTeller, Hashable, Hasher, Int (+14 more)

### Community 38 - "Bool"
Cohesion: 0.33
Nodes (5): Image, LocalizedStringKey, String, Text, ThumbCard

### Community 44 - "CGFloat"
Cohesion: 0.09
Nodes (13): AVFoundation, SegmentedSelector, Item, LocalizedStringKey, SettingsButton, StepDots, Int, ChatBackground (+5 more)

### Community 47 - "FlowHeader"
Cohesion: 0.31
Nodes (8): FlowHeader, PrimaryButton, SecondaryButton, Bool, Int, LocalizedStringKey, String, Void

### Community 48 - ".section"
Cohesion: 0.33
Nodes (4): Content, LocalizedStringKey, Void, TellerProfileView

### Community 50 - "LocalizedStringKey"
Cohesion: 0.20
Nodes (7): Bool, String, TopicChip, Bool, Int, Void, TellerCard

### Community 52 - "DecodedImages"
Cohesion: 0.22
Nodes (11): ContentMode, NSCache, NSString, DecodedImages, RemoteImage, ShimmerFill, Bool, CGFloat (+3 more)

### Community 53 - "IntentionView"
Cohesion: 0.20
Nodes (7): IntentionView, Binding, Bool, Content, LocalizedStringKey, String, Void

### Community 54 - "FlowCard"
Cohesion: 0.22
Nodes (7): LinearGradient, Pigment, FlowCard, CGFloat, LocalizedStringKey, String, Void

### Community 55 - "HistoryItem"
Cohesion: 0.33
Nodes (6): Pigment, RatingLabel, StarRow, CGFloat, Double, Int

### Community 56 - "String"
Cohesion: 0.28
Nodes (6): ChatThread, OracleChatView, Bool, String, Void, ScrollViewProxy

### Community 58 - "ChatsView"
Cohesion: 0.07
Nodes (33): Color, Content, HistoryItem, LocalizedStringKey, Atrium, LocalizedStringKey, TabPlaceholder, ChatsView (+25 more)

### Community 60 - "Country"
Cohesion: 0.05
Nodes (32): Foundation, EmissaryFailure, decoding, encoding, notFound, notSubscribed, offline, rateLimited (+24 more)

### Community 61 - "RandomCupView"
Cohesion: 0.14
Nodes (12): View, FortuneTellersView, Int, LocalizedStringKey, Void, ReadingLoadingView, CGFloat, Double (+4 more)

### Community 62 - "Ignition"
Cohesion: 0.40
Nodes (3): App, Ignition, Scene

### Community 68 - "BrewModel"
Cohesion: 0.25
Nodes (6): BrewModel, LocalizedStringKey, String, BrewView, CGFloat, LocalizedStringKey

## Knowledge Gaps
- **160 isolated node(s):** `medium`, `semibold`, `days`, `month`, `year` (+155 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **60 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `SwiftUI` connect `CGFloat` to `ReadingDraft`, `Drink`, `FortuneTeller`, `CameraPicker`, `RootTab`, `Lettering`, `Reading`, `FlowLayout`, `Drink`, `OracleChatEntryFlow`, `Drink`, `FortuneTeller`, `LocalizedStringKey`, `ReadingDraft`, `RootTab`, `Double`, `Bool`, `Bool`, `FlowHeader`, `.section`, `LocalizedStringKey`, `DecodedImages`, `IntentionView`, `FlowCard`, `HistoryItem`, `ChatsView`, `RandomCupView`, `Ignition`, `BrewModel`?**
  _High betweenness centrality (0.220) - this node is a cross-community bridge._
- **Why does `View` connect `RandomCupView` to `ReadingDraft`, `View`, `Drink`, `FortuneTeller`, `Reading`, `FlowLayout`, `Drink`, `OracleChatEntryFlow`, `Drink`, `FortuneTeller`, `LocalizedStringKey`, `ReadingDraft`, `RootTab`, `Double`, `Bool`, `Bool`, `CGFloat`, `FlowHeader`, `.section`, `LocalizedStringKey`, `DecodedImages`, `IntentionView`, `FlowCard`, `HistoryItem`, `String`, `BrewModel`?**
  _High betweenness centrality (0.203) - this node is a cross-community bridge._
- **Why does `Foundation` connect `Country` to `Bool`, `SwiftUI`, `ReadingSession`, `RootTab`, `ReadingStep`, `Reading`, `OracleChatEntryFlow`, `Drink`?**
  _High betweenness centrality (0.102) - this node is a cross-community bridge._
- **Are the 17 inferred relationships involving `EmissaryRequest` (e.g. with `.dailyFortune()` and `.drinks()`) actually correct?**
  _`EmissaryRequest` has 17 INFERRED edges - model-reasoned connections that need verification._
- **What connects `medium`, `semibold`, `days` to the rest of the system?**
  _160 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Drink` be split into smaller, more focused modules?**
  _Cohesion score 0.11857707509881422 - nodes in this community are weakly interconnected._
- **Should `SwiftUI` be split into smaller, more focused modules?**
  _Cohesion score 0.08961593172119488 - nodes in this community are weakly interconnected._
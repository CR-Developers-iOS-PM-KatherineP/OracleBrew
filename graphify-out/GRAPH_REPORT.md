# Graph Report - OracleBrew  (2026-07-20)

## Corpus Check
- 92 files · ~28,235 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1051 nodes · 1778 edges · 114 communities (54 shown, 60 thin omitted)
- Extraction: 93% EXTRACTED · 7% INFERRED · 0% AMBIGUOUS · INFERRED: 121 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `dd055c03`
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
- ReadingService
- Hasher
- Bool
- Drink
- FortuneTeller
- Hasher
- UIImage
- UUID
- CGFloat
- NavigationPath
- Zodiac
- FlowHeader
- .section
- NavigationPath
- LocalizedStringKey
- OnboardingControl
- DecodedImages
- IntentionView
- FlowCard
- HistoryItem
- String
- .run
- ChatsView
- .buildURLRequest
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
- CodingKeys
- OnboardingView
- ChatSummary
- SessionGate
- ReadingSymbol
- ReadingDraft
- ReadingDraft
- PhotoUploadView
- Context
- Emissary
- EmissaryFailure
- Encoder
- RootTab
- Image
- Emissary
- Item
- SegmentedSelector
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
- LocalizedStringKey
- Set

## God Nodes (most connected - your core abstractions)
1. `View` - 70 edges
2. `SwiftUI` - 67 edges
3. `FortuneTeller` - 27 edges
4. `EmissaryRequest` - 25 edges
5. `Foundation` - 24 edges
6. `UserProfile` - 24 edges
7. `CodingKeys` - 22 edges
8. `EmissaryFailure` - 22 edges
9. `Color` - 22 edges
10. `Zodiac` - 20 edges

## Surprising Connections (you probably didn't know these)
- `Pigment` --calls--> `Color`  [INFERRED]
  OracleBrew/OracleBrew/Kit/StarRating.swift → OracleBrew/OracleBrew/Kit/Pigment.swift
- `Atrium` --calls--> `UserProfileStore`  [INFERRED]
  OracleBrew/OracleBrew/App/Atrium.swift → OracleBrew/OracleBrew/Backbone/UserProfile.swift
- `OnboardingView` --calls--> `OnboardingFlow`  [INFERRED]
  OracleBrew/OracleBrew/Screens/Onboarding/OnboardingView.swift → OracleBrew/OracleBrew/Screens/Onboarding/OnboardingFlow.swift
- `SettingsButton` --references--> `View`  [EXTRACTED]
  OracleBrew/OracleBrew/Kit/SettingsButton.swift → OracleBrew/OracleBrew/App/WaypointDestinations.swift
- `ChatBackground` --references--> `View`  [EXTRACTED]
  OracleBrew/OracleBrew/Screens/OracleChat/components/ChatBackground.swift → OracleBrew/OracleBrew/App/WaypointDestinations.swift

## Import Cycles
- None detected.

## Communities (114 total, 60 thin omitted)

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
Cohesion: 0.20
Nodes (12): Data, HTTPMethod, delete, get, patch, post, MultipartPart, RequestBody (+4 more)

### Community 4 - "ReadingSession"
Cohesion: 0.05
Nodes (39): CodingKey, CodingKeys, assistantMessage, createdAt, hasUnreadFromOracle, id, lastMessage, messages (+31 more)

### Community 5 - "Backbone (Services + Mock Data)"
Cohesion: 0.10
Nodes (26): Backbone (Services + Mock Data), Brew Reading Flow, ChatEngine, Deferred Scope (Not in v1.0), DrinkCatalog, Fortune Teller Characters, FortuneTellerProvider, HistoryStore (+18 more)

### Community 6 - "FortuneTeller"
Cohesion: 0.12
Nodes (12): AVFoundation, LegalCopy, LegalTextView, LocalizedStringKey, String, Void, SettingsDestination, privacy (+4 more)

### Community 7 - "CameraPicker"
Cohesion: 0.13
Nodes (15): Cadence, Screen, CGFloat, CameraPicker, Coordinator, Any, Bool, Context (+7 more)

### Community 8 - "RootTab"
Cohesion: 0.21
Nodes (7): CatalogRepository, DailyFortuneDTO, Int, String, EmissaryRequest, HistoryRepository, Int

### Community 9 - "Lettering"
Cohesion: 0.26
Nodes (5): CGFloat, CoreText, Font, Lettering, LocalizedStringKey

### Community 10 - "ReadingStep"
Cohesion: 0.05
Nodes (56): Decodable, Encodable, Foundation, ChatDetailDTO, ChatListItemDTO, ChatMapper, ChatMessageDTO, ChatRepository (+48 more)

### Community 11 - "Reading"
Cohesion: 0.06
Nodes (22): ScreenPhase, content, loadFailure, loading, offline, Bool, Content, Pathfinder (+14 more)

### Community 12 - "FlowLayout"
Cohesion: 0.07
Nodes (26): CGSize, Error, Layout, BubbleTail, Bool, CGRect, FlowLayout, CGFloat (+18 more)

### Community 13 - "Drink"
Cohesion: 0.18
Nodes (12): Duration, Equatable, Line, OnboardingFlow, Stage, asking, ready, saving (+4 more)

### Community 14 - "Design System (Kit)"
Cohesion: 0.33
Nodes (6): Cadence (Metrics), Design System (Kit), Figma Source of Truth, Lettering (Fonts), Pigment (Colors), Platform Constraints (iOS 17, iPhone, Portrait, Light)

### Community 15 - "OracleChatEntryFlow"
Cohesion: 0.09
Nodes (27): CaseIterable, Identifiable, LocalizedStringKey, TimeHorizon, days, month, year, ChildrenStatus (+19 more)

### Community 16 - "Atrium (Root Container)"
Cohesion: 1.00
Nodes (3): Atrium (Root Container), Build Order, Ignition (@main App Entry)

### Community 19 - "Drink"
Cohesion: 0.06
Nodes (32): ChatThread, ChatEngine, ChatMessage, Bool, String, FortuneTeller, FortuneTellerRoster, Review (+24 more)

### Community 20 - "FortuneTeller"
Cohesion: 0.40
Nodes (4): EmptyState, LocalizedStringKey, String, Void

### Community 22 - "LocalizedStringKey"
Cohesion: 0.08
Nodes (23): AnyClass, AVCapturePhoto, AVCapturePhotoCaptureDelegate, AVCapturePhotoOutput, AVCaptureSession, AVCaptureVideoPreviewLayer, NSObject, CameraPreview (+15 more)

### Community 24 - "ReadingDraft"
Cohesion: 0.09
Nodes (21): Hashable, Country, CountryCatalog, String, BrewReadingFlow, FlowStub, ReadingStep, chat (+13 more)

### Community 26 - "RootTab"
Cohesion: 0.10
Nodes (26): Label, DropdownChevron, DropdownOverlay, DropdownRow, ProfileFieldBox, Bool, CGFloat, Content (+18 more)

### Community 30 - "Double"
Cohesion: 0.29
Nodes (7): Kind, failure, offline, ScreenStateView, LocalizedStringKey, String, Void

### Community 34 - "Bool"
Cohesion: 0.10
Nodes (20): CodingKeys, adviceHeadline, aiJobId, baseDescription, cupImage, hasChat, icon, id (+12 more)

### Community 35 - "Bool"
Cohesion: 0.10
Nodes (20): ChatListItemDTO, ChatMessage, ChatRepository, Date, FortuneTeller, Hasher, Int, ChatSessionStore (+12 more)

### Community 36 - "ReadingService"
Cohesion: 0.22
Nodes (8): AnyJSON, int, string, ReadingMapper, ReadingService, Encoder, Int, String

### Community 38 - "Bool"
Cohesion: 0.33
Nodes (5): Image, LocalizedStringKey, String, Text, ThumbCard

### Community 44 - "CGFloat"
Cohesion: 0.12
Nodes (9): SettingsButton, StepDots, Int, ChatBackground, ChatBubble, Bool, SymbolChip, ReviewCard (+1 more)

### Community 46 - "Zodiac"
Cohesion: 0.14
Nodes (14): Int, Zodiac, aquarius, aries, cancer, capricorn, gemini, leo (+6 more)

### Community 47 - "FlowHeader"
Cohesion: 0.33
Nodes (9): View, FlowHeader, PrimaryButton, SecondaryButton, Bool, Int, LocalizedStringKey, String (+1 more)

### Community 48 - ".section"
Cohesion: 0.33
Nodes (4): Content, LocalizedStringKey, Void, TellerProfileView

### Community 50 - "LocalizedStringKey"
Cohesion: 0.20
Nodes (7): Bool, String, TopicChip, Bool, Int, Void, TellerCard

### Community 51 - "OnboardingControl"
Cohesion: 0.20
Nodes (13): OnboardingChoice, OnboardingControl, birthDate, countryWheel, employmentWheel, interests, options, relationshipWheel (+5 more)

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
Cohesion: 0.26
Nodes (7): Codable, ProfileDTO, ProfileMapper, Bool, Int, String, T

### Community 57 - ".run"
Cohesion: 0.24
Nodes (7): HTTPURLResponse, Bool, Error, String, URLRequest, WireLog, URLError

### Community 58 - "ChatsView"
Cohesion: 0.06
Nodes (47): Color, Content, HistoryItem, LocalizedStringKey, Atrium, Bool, HistoryCard, String (+39 more)

### Community 59 - ".buildURLRequest"
Cohesion: 0.23
Nodes (7): APIConfig, String, AnyEncodable, Encodable, Encoder, URLRequest, Void

### Community 60 - "Country"
Cohesion: 0.18
Nodes (11): EmissaryFailure, decoding, encoding, notFound, notSubscribed, offline, rateLimited, server (+3 more)

### Community 61 - "RandomCupView"
Cohesion: 0.10
Nodes (13): FortuneTellersView, Int, LocalizedStringKey, Void, ReadingLoadingView, CGFloat, Double, Void (+5 more)

### Community 62 - "Ignition"
Cohesion: 0.40
Nodes (3): App, Ignition, Scene

### Community 68 - "BrewModel"
Cohesion: 0.25
Nodes (6): BrewModel, LocalizedStringKey, String, BrewView, CGFloat, LocalizedStringKey

### Community 72 - "CodingKeys"
Cohesion: 0.17
Nodes (12): CodingKeys, children, country, dataConsent, dateOfBirth, employmentStatus, gender, name (+4 more)

### Community 73 - "OnboardingView"
Cohesion: 0.26
Nodes (8): OnboardingLeavePopup, OnboardingLoadingView, OnboardingReadyView, OnboardingView, Int, Set, String, Void

### Community 75 - "SessionGate"
Cohesion: 0.29
Nodes (4): SessionGate, Any, String, TokenVault

### Community 76 - "ReadingSymbol"
Cohesion: 0.36
Nodes (6): ReadingEngine, ReadingSymbol, SeededGenerator, String, RandomNumberGenerator, UInt64

### Community 79 - "PhotoUploadView"
Cohesion: 0.22
Nodes (6): PhotoUploadView, Bool, LocalizedStringKey, Void, PhotosPickerItem, PhotosUI

### Community 81 - "Emissary"
Cohesion: 0.26
Nodes (6): Emissary, ProfileRepository, Bool, Set, UserProfile, UserProfileStore

### Community 84 - "RootTab"
Cohesion: 0.29
Nodes (7): RootTab, brew, chats, history, LocalizedStringKey, String, TabBar

### Community 86 - "Emissary"
Cohesion: 0.47
Nodes (4): JSONDecoder, Emissary, Error, URLSession

### Community 88 - "SegmentedSelector"
Cohesion: 0.50
Nodes (3): SegmentedSelector, Item, LocalizedStringKey

## Knowledge Gaps
- **181 isolated node(s):** `name`, `gender`, `country`, `children`, `dateOfBirth` (+176 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **60 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `SwiftUI` connect `CGFloat` to `ReadingDraft`, `Drink`, `FortuneTeller`, `CameraPicker`, `RootTab`, `Lettering`, `Reading`, `FlowLayout`, `Drink`, `Drink`, `FortuneTeller`, `LocalizedStringKey`, `ReadingDraft`, `RootTab`, `Double`, `Bool`, `Bool`, `FlowHeader`, `.section`, `LocalizedStringKey`, `OnboardingControl`, `DecodedImages`, `IntentionView`, `FlowCard`, `HistoryItem`, `ChatsView`, `RandomCupView`, `Ignition`, `BrewModel`, `OnboardingView`, `PhotoUploadView`, `RootTab`, `SegmentedSelector`?**
  _High betweenness centrality (0.288) - this node is a cross-community bridge._
- **Why does `Foundation` connect `ReadingStep` to `Bool`, `SwiftUI`, `ReadingSession`, `Reading`, `ReadingSymbol`, `Drink`, `OracleChatEntryFlow`, `Drink`, `OnboardingControl`, `ReadingDraft`, `String`, `.buildURLRequest`?**
  _High betweenness centrality (0.170) - this node is a cross-community bridge._
- **Why does `View` connect `FlowHeader` to `ReadingDraft`, `View`, `Drink`, `FortuneTeller`, `Reading`, `FlowLayout`, `Drink`, `FortuneTeller`, `ReadingDraft`, `RootTab`, `Double`, `Bool`, `CGFloat`, `.section`, `LocalizedStringKey`, `DecodedImages`, `IntentionView`, `FlowCard`, `HistoryItem`, `RandomCupView`, `BrewModel`, `PhotoUploadView`, `RootTab`, `SegmentedSelector`?**
  _High betweenness centrality (0.169) - this node is a cross-community bridge._
- **Are the 17 inferred relationships involving `EmissaryRequest` (e.g. with `.dailyFortune()` and `.drinks()`) actually correct?**
  _`EmissaryRequest` has 17 INFERRED edges - model-reasoned connections that need verification._
- **What connects `name`, `gender`, `country` to the rest of the system?**
  _181 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Drink` be split into smaller, more focused modules?**
  _Cohesion score 0.11857707509881422 - nodes in this community are weakly interconnected._
- **Should `ReadingSession` be split into smaller, more focused modules?**
  _Cohesion score 0.05128205128205128 - nodes in this community are weakly interconnected._
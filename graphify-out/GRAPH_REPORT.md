# Graph Report - OracleBrew  (2026-07-27)

## Corpus Check
- 114 files · ~49,569 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1111 nodes · 1918 edges · 107 communities (63 shown, 44 thin omitted)
- Extraction: 93% EXTRACTED · 7% INFERRED · 0% AMBIGUOUS · INFERRED: 132 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `90a54140`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- Chat & Catalog DTOs
- History & Navigation
- Country Catalog & API Config
- Reading Service & JSON
- Chat Wire Models
- Flow Layout & Bubble Shapes
- Onboarding Conversation Flow
- App Root & Catalog Store
- Cup Camera Capture
- Profile Dropdown Controls
- Oracle Entity API Contract
- Daily Fortune Catalog
- Project Design Notes
- Oracle & Review DTOs
- Intention: Topic & Horizon
- Settings Row Components
- User Profile Enums
- Chat Session Store
- Emissary Request Building
- Typography & Nav Chrome
- Catalog Repository
- Reading Result Screen
- Splash Video Player
- Remote Image Cache
- Network Send & Retry
- Onboarding Chrome
- Zodiac Signs
- Brew Reading Flow Steps
- Session Gate & Bootstrap
- Interests & Profile Chips
- PhotoCaptor
- Network Failure Types
- Profile Field Keys
- Profile DTO Mapping
- ReadingStep
- Lettering Fonts
- Oracle Chat Screen
- Flow Buttons & Header
- Topic & Teller Chips
- Chats List Screen
- LegalTextView
- Palette & Brew Cards
- Profile Repository & Store
- Intention Screen
- Emissary Core
- Encodable Request Bodies
- Community 46
- Community 47
- Community 48
- Community 49
- SessionGate
- Community 51
- LayoutDirection
- SegmentedSelector
- ShareCardRenderer.swift
- Community 55
- Community 56
- FortuneTeller
- Community 58
- IntentionView
- Community 60
- CGFloat
- ScrollViewProxy
- Community 63
- Void
- PhotoUploadView
- ReadingStep
- RootTab
- Community 68
- .create
- Community 70
- RelationshipStatus
- Ignition
- FortuneTellersView
- ChatBubble
- FortuneTeller
- .section
- LocalizedStringKey
- String
- Void
- Int
- Date
- ReadingDraft
- AnyClass
- Context
- Error
- Binding
- Int
- Reading
- ReadingDraft
- Topic
- Reading Result
- Screen Bundles Folder Structure (F20)
- EmptyState
- Int
- Reading
- String
- Throb (Haptics)
- UserProfileStore
- Vault (Storage)
- Waypoint (Route)
- Item
- Content
- ThumbCard
- SymbolChip
- LocalizedStringKey
- String

## God Nodes (most connected - your core abstractions)
1. `View` - 80 edges
2. `SwiftUI` - 74 edges
3. `EmissaryRequest` - 29 edges
4. `FortuneTeller` - 25 edges
5. `UserProfile` - 25 edges
6. `View` - 24 edges
7. `Foundation` - 24 edges
8. `EmissaryFailure` - 23 edges
9. `Color` - 22 edges
10. `CodingKeys` - 22 edges

## Surprising Connections (you probably didn't know these)
- `Pigment` --calls--> `Color`  [INFERRED]
  OracleBrew/OracleBrew/Kit/StarRating.swift → OracleBrew/OracleBrew/Kit/Pigment.swift
- `TellerCard` --calls--> `Color`  [INFERRED]
  OracleBrew/OracleBrew/Screens/FortuneTellers/components/TellerCard.swift → OracleBrew/OracleBrew/Kit/Pigment.swift
- `HistoryCard` --calls--> `Color`  [INFERRED]
  OracleBrew/OracleBrew/Screens/History/components/HistoryCard.swift → OracleBrew/OracleBrew/Kit/Pigment.swift
- `Atrium` --calls--> `ChatSessionStore`  [INFERRED]
  OracleBrew/OracleBrew/App/Atrium.swift → OracleBrew/OracleBrew/Backbone/ChatSessionStore.swift
- `Atrium` --calls--> `Pathfinder`  [INFERRED]
  OracleBrew/OracleBrew/App/Atrium.swift → OracleBrew/OracleBrew/Backbone/Pathfinder.swift

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **** — docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_brew_reading_flow, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_drink_catalog, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_reading_engine, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_reading_result, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_fortune_teller_provider [INFERRED 0.80]
- **** — docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_mvvm_router, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_pathfinder, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_waypoint, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_atrium [INFERRED 0.80]

## Communities (107 total, 44 thin omitted)

### Community 0 - "Chat & Catalog DTOs"
Cohesion: 0.06
Nodes (46): Decodable, Encodable, JSONDecoder, Atrium, Bool, CatalogStore, String, CatalogRepository (+38 more)

### Community 1 - "History & Navigation"
Cohesion: 0.29
Nodes (5): ProfileRepository, Bool, Set, UserProfile, UserProfileStore

### Community 2 - "Country Catalog & API Config"
Cohesion: 0.09
Nodes (14): CGFloat, Content, LocalizedStringKey, CupPhoto, CupPhotoBox, Bool, PhotoUploadView, Bool (+6 more)

### Community 3 - "Reading Service & JSON"
Cohesion: 0.09
Nodes (22): NSObject, OracleContent, OracleContentCatalog, Bool, Double, Int, String, Cadence (+14 more)

### Community 4 - "Chat Wire Models"
Cohesion: 0.06
Nodes (44): CodingKeys, authorName, bio, createdAt, description, id, illustration, image (+36 more)

### Community 5 - "Flow Layout & Bubble Shapes"
Cohesion: 0.15
Nodes (9): BubbleTail, Bool, CGRect, Path, Sparkle, SparklePair, CGRect, Path (+1 more)

### Community 6 - "Onboarding Conversation Flow"
Cohesion: 0.06
Nodes (37): HTTPURLResponse, Bool, Hasher, Int, LocalizedStringKey, TimeHorizon, days, month (+29 more)

### Community 7 - "App Root & Catalog Store"
Cohesion: 0.10
Nodes (26): Duration, Equatable, Identifiable, Line, OnboardingFlow, Stage, asking, ready (+18 more)

### Community 8 - "Cup Camera Capture"
Cohesion: 0.17
Nodes (9): CardOffsetKey, OracleChatView, Bool, CGFloat, ScrollViewProxy, Void, TellerPeek, TypingBubble (+1 more)

### Community 9 - "Profile Dropdown Controls"
Cohesion: 0.10
Nodes (26): Label, DropdownChevron, DropdownOverlay, DropdownRow, ProfileFieldBox, Bool, CGFloat, Content (+18 more)

### Community 10 - "Oracle Entity API Contract"
Cohesion: 0.17
Nodes (10): AVFoundation, AVPlayer, AVPlayerLayer, PlayerView, AnyClass, Context, VideoLayerView, SplashView (+2 more)

### Community 11 - "Daily Fortune Catalog"
Cohesion: 0.19
Nodes (13): OnboardingBirthPicker, OnboardingContinue, OnboardingInterests, OnboardingOptions, OnboardingTextEntry, OnboardingWheel, Bool, Int (+5 more)

### Community 13 - "Oracle & Review DTOs"
Cohesion: 0.14
Nodes (14): Int, Zodiac, aquarius, aries, cancer, capricorn, gemini, leo (+6 more)

### Community 14 - "Intention: Topic & Horizon"
Cohesion: 0.06
Nodes (35): Hashable, ChatMessage, ChatSessionStore, ChatSummary, ChatThread, Bool, Date, Hasher (+27 more)

### Community 15 - "Settings Row Components"
Cohesion: 0.15
Nodes (17): SettingsArrow, SettingsCard, SettingsDivider, SettingsIcon, SettingsRow, SettingsSectionLabel, SettingsToggleRow, Bool (+9 more)

### Community 16 - "User Profile Enums"
Cohesion: 0.15
Nodes (16): CaseIterable, Codable, ChildrenStatus, have, none, planning, Employment, both (+8 more)

### Community 17 - "Chat Session Store"
Cohesion: 0.10
Nodes (11): CoreText, EmptyState, LocalizedStringKey, String, Void, SettingsButton, StepDots, Int (+3 more)

### Community 18 - "Emissary Request Building"
Cohesion: 0.17
Nodes (12): CodingKeys, children, country, dataConsent, dateOfBirth, employmentStatus, gender, name (+4 more)

### Community 19 - "Typography & Nav Chrome"
Cohesion: 0.29
Nodes (5): BrewModel, LocalizedStringKey, BrewView, CGFloat, LocalizedStringKey

### Community 20 - "Catalog Repository"
Cohesion: 0.06
Nodes (31): ContentMode, Double, NSCache, NSString, Drink, DrinkCatalog, Bool, LocalizedStringKey (+23 more)

### Community 21 - "Reading Result Screen"
Cohesion: 0.31
Nodes (8): ReadingResultView, Image, LocalizedStringKey, String, Void, Reading, ShareCardImage, Text

### Community 22 - "Splash Video Player"
Cohesion: 0.32
Nodes (6): ProfileDTO, ProfileMapper, Bool, Int, String, T

### Community 23 - "Remote Image Cache"
Cohesion: 0.24
Nodes (6): CGFloat, View, Bool, String, TopicChip, Int

### Community 24 - "Network Send & Retry"
Cohesion: 0.22
Nodes (7): Binding, Pigment, IntentionView, Bool, LocalizedStringKey, String, Void

### Community 25 - "Onboarding Chrome"
Cohesion: 0.29
Nodes (7): Kind, failure, offline, ScreenStateView, LocalizedStringKey, String, Void

### Community 26 - "Zodiac Signs"
Cohesion: 0.17
Nodes (13): View, HistoryCard, String, Void, OnboardingBackground, OnboardingBubble, OnboardingHeader, OnboardingPanel (+5 more)

### Community 27 - "Brew Reading Flow Steps"
Cohesion: 0.31
Nodes (8): FlowHeader, PrimaryButton, SecondaryButton, Bool, Int, LocalizedStringKey, String, Void

### Community 28 - "Session Gate & Bootstrap"
Cohesion: 0.19
Nodes (10): Interest, InterestCatalog, String, InterestChip, ProfileChip, ProfileSectionLabel, Bool, LocalizedStringKey (+2 more)

### Community 29 - "Interests & Profile Chips"
Cohesion: 0.29
Nodes (6): BrewReadingFlow, FlowStub, Binding, Bool, LocalizedStringKey, Void

### Community 30 - "PhotoCaptor"
Cohesion: 0.18
Nodes (11): EmissaryFailure, decoding, encoding, notFound, notSubscribed, offline, rateLimited, server (+3 more)

### Community 31 - "Network Failure Types"
Cohesion: 0.14
Nodes (12): CardGradient, Spec, Bool, CGFloat, CGSize, Double, UnitPoint, FlowCard (+4 more)

### Community 32 - "Profile Field Keys"
Cohesion: 0.05
Nodes (44): CodingKey, CodingKeys, assistantMessageId, createdAt, hasUnreadFromOracle, id, job, lastMessage (+36 more)

### Community 33 - "Profile DTO Mapping"
Cohesion: 0.15
Nodes (12): A. New features (new product value), B. Polish & UX, C. Networking & reliability, Competitive insights (2026 research), D. Content & known tails (from this session), E0. What each new feature needs from the backend, E. Backend asks (from the entity docs), F. Repo hygiene (+4 more)

### Community 34 - "ReadingStep"
Cohesion: 0.50
Nodes (3): LayoutDirection, CGFloat, UnitPoint

### Community 35 - "Lettering Fonts"
Cohesion: 0.15
Nodes (12): 10. Deferred (NOT in v1.0), 11. Open questions (resolve at build), 1. What it is, 2. Project combo (fixed), 3. Platform & constraints (from base regimen), 4. Screen inventory, 5. Mock / data layer (Backbone), 6. Registration (+4 more)

### Community 36 - "Oracle Chat Screen"
Cohesion: 0.15
Nodes (11): Calendar, OnboardingLeavePopup, OnboardingLoadingView, OnboardingReadyView, OnboardingView, Int, LocalizedStringKey, ScrollViewProxy (+3 more)

### Community 37 - "Flow Buttons & Header"
Cohesion: 0.20
Nodes (8): AVCaptureSession, CupCamera, Phase, denied, idle, running, unavailable, Bool

### Community 38 - "Topic & Teller Chips"
Cohesion: 0.29
Nodes (6): Error, ShareCardError, encodingFailed, ShareCardRenderer, CGFloat, UniformTypeIdentifiers

### Community 39 - "Chats List Screen"
Cohesion: 0.38
Nodes (4): FortuneCatalog, Date, Int, String

### Community 40 - "LegalTextView"
Cohesion: 0.06
Nodes (27): HistoryRepository, Pathfinder, Reading, ReadingEngine, ReadingSymbol, SeededGenerator, String, HistoryItem (+19 more)

### Community 41 - "Palette & Brew Cards"
Cohesion: 0.22
Nodes (7): ScreenPhase, content, loadFailure, loading, offline, Bool, Content

### Community 42 - "Profile Repository & Store"
Cohesion: 0.27
Nodes (7): Layout, FlowLayout, CGFloat, CGRect, CGSize, ProposedViewSize, Subviews

### Community 43 - "Intention Screen"
Cohesion: 0.29
Nodes (7): ReadingStep, chat, intention, loading, photo, result, tellers

### Community 44 - "Emissary Core"
Cohesion: 0.07
Nodes (19): Foundation, Country, CountryCatalog, String, APIConfig, String, Paginated, Bool (+11 more)

### Community 45 - "Encodable Request Bodies"
Cohesion: 0.47
Nodes (3): Lettering, CGFloat, Font

### Community 46 - "Community 46"
Cohesion: 0.33
Nodes (6): RelationshipStatus, complicated, divorced, inRelationship, married, single

### Community 47 - "Community 47"
Cohesion: 0.50
Nodes (3): Item, SegmentedSelector, LocalizedStringKey

### Community 48 - "Community 48"
Cohesion: 0.33
Nodes (3): App, Ignition, Scene

### Community 49 - "Community 49"
Cohesion: 0.40
Nodes (4): ReadingLoadingView, CGFloat, Double, Void

### Community 50 - "SessionGate"
Cohesion: 0.33
Nodes (5): LegalCopy, LegalTextView, LocalizedStringKey, String, Void

### Community 52 - "LayoutDirection"
Cohesion: 0.33
Nodes (5): Drink, DrinkCard, Bool, CGFloat, Void

### Community 54 - "ShareCardRenderer.swift"
Cohesion: 0.22
Nodes (6): SettingsDestination, privacy, terms, SettingsView, Void, UserNotifications

### Community 55 - "Community 55"
Cohesion: 0.33
Nodes (4): Content, LocalizedStringKey, Void, TellerProfileView

### Community 56 - "Community 56"
Cohesion: 0.29
Nodes (7): AVCapturePhoto, AVCapturePhotoCaptureDelegate, AVCapturePhotoOutput, PhotoCaptor, Error, UIImage, Void

### Community 57 - "FortuneTeller"
Cohesion: 0.20
Nodes (8): ShareCard, String, UIImage, ShareCardImage, String, UIImage, Transferable, TransferRepresentation

### Community 59 - "IntentionView"
Cohesion: 0.29
Nodes (6): Content, Fields, Gaps against the content we are shipping, Language, Oracle — what the iOS client expects, Reading language — resolved

### Community 61 - "CGFloat"
Cohesion: 0.40
Nodes (4): FortuneTeller, Bool, Void, TellerCard

### Community 67 - "RootTab"
Cohesion: 0.29
Nodes (7): RootTab, brew, chats, history, LocalizedStringKey, String, TabBar

### Community 69 - ".create"
Cohesion: 0.33
Nodes (5): Assets still to add (client-side, not backend), Drinks list — unchanged, Random cup — now client-side, What changed on the client, What the backend no longer needs

### Community 83 - "AnyClass"
Cohesion: 0.28
Nodes (6): AVCaptureVideoPreviewLayer, CameraPreview, PreviewView, AnyClass, Context, UIViewRepresentable

### Community 93 - "EmptyState"
Cohesion: 0.40
Nodes (4): FortuneTellersView, Int, LocalizedStringKey, Void

### Community 103 - "ThumbCard"
Cohesion: 0.40
Nodes (4): Image, LocalizedStringKey, String, ThumbCard

### Community 104 - "SymbolChip"
Cohesion: 0.50
Nodes (3): SymbolChip, ReadingSymbol, SymbolCatalog

## Knowledge Gaps
- **238 isolated node(s):** `PhotosUI`, `Competitive insights (2026 research)`, `A. New features (new product value)`, `B. Polish & UX`, `C. Networking & reliability` (+233 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **44 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `SwiftUI` connect `Chat Session Store` to `Chat & Catalog DTOs`, `Country Catalog & API Config`, `Reading Service & JSON`, `Flow Layout & Bubble Shapes`, `Onboarding Conversation Flow`, `App Root & Catalog Store`, `Cup Camera Capture`, `Profile Dropdown Controls`, `Oracle Entity API Contract`, `Daily Fortune Catalog`, `Intention: Topic & Horizon`, `Settings Row Components`, `Typography & Nav Chrome`, `Catalog Repository`, `Remote Image Cache`, `Network Send & Retry`, `Onboarding Chrome`, `Zodiac Signs`, `Brew Reading Flow Steps`, `Session Gate & Bootstrap`, `Interests & Profile Chips`, `Network Failure Types`, `ReadingStep`, `Oracle Chat Screen`, `Flow Buttons & Header`, `Topic & Teller Chips`, `LegalTextView`, `Profile Repository & Store`, `Community 47`, `Community 48`, `Community 49`, `SessionGate`, `LayoutDirection`, `ShareCardRenderer.swift`, `Community 55`, `FortuneTeller`, `CGFloat`, `RootTab`, `EmptyState`, `ThumbCard`, `SymbolChip`?**
  _High betweenness centrality (0.271) - this node is a cross-community bridge._
- **Why does `View` connect `Zodiac Signs` to `Chat & Catalog DTOs`, `Flow Layout & Bubble Shapes`, `Onboarding Conversation Flow`, `Cup Camera Capture`, `Profile Dropdown Controls`, `Oracle Entity API Contract`, `Daily Fortune Catalog`, `Intention: Topic & Horizon`, `Settings Row Components`, `Chat Session Store`, `Typography & Nav Chrome`, `Catalog Repository`, `Onboarding Chrome`, `Session Gate & Bootstrap`, `Interests & Profile Chips`, `Network Failure Types`, `Oracle Chat Screen`, `LegalTextView`, `Community 49`, `SessionGate`, `ShareCardRenderer.swift`, `Community 55`, `FortuneTeller`, `RootTab`, `EmptyState`?**
  _High betweenness centrality (0.180) - this node is a cross-community bridge._
- **Why does `Foundation` connect `Emissary Core` to `Chat & Catalog DTOs`, `History & Navigation`, `Profile Field Keys`, `Chat Wire Models`, `Onboarding Conversation Flow`, `Chats List Screen`, `LegalTextView`, `Palette & Brew Cards`, `App Root & Catalog Store`, `Intention: Topic & Horizon`, `User Profile Enums`?**
  _High betweenness centrality (0.164) - this node is a cross-community bridge._
- **Are the 21 inferred relationships involving `EmissaryRequest` (e.g. with `.dailyFortune()` and `.drinks()`) actually correct?**
  _`EmissaryRequest` has 21 INFERRED edges - model-reasoned connections that need verification._
- **What connects `PhotosUI`, `Competitive insights (2026 research)`, `A. New features (new product value)` to the rest of the system?**
  _238 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Chat & Catalog DTOs` be split into smaller, more focused modules?**
  _Cohesion score 0.056134723336006415 - nodes in this community are weakly interconnected._
- **Should `Country Catalog & API Config` be split into smaller, more focused modules?**
  _Cohesion score 0.09420289855072464 - nodes in this community are weakly interconnected._
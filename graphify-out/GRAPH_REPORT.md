# Graph Report - OracleBrew  (2026-07-24)

## Corpus Check
- 111 files · ~46,961 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1114 nodes · 1848 edges · 95 communities (62 shown, 33 thin omitted)
- Extraction: 96% EXTRACTED · 4% INFERRED · 0% AMBIGUOUS · INFERRED: 77 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `c4f0638c`
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
- EmptyState
- Int
- Reading
- String

## God Nodes (most connected - your core abstractions)
1. `View` - 73 edges
2. `SwiftUI` - 72 edges
3. `UserProfile` - 25 edges
4. `Foundation` - 24 edges
5. `CodingKeys` - 22 edges
6. `CodingKeys` - 22 edges
7. `FortuneTeller` - 20 edges
8. `CodingKeys` - 20 edges
9. `Zodiac` - 20 edges
10. `EmissaryFailure` - 19 edges

## Surprising Connections (you probably didn't know these)
- `Pigment` --calls--> `Color`  [INFERRED]
  OracleBrew/OracleBrew/Kit/StarRating.swift → OracleBrew/OracleBrew/Kit/Pigment.swift
- `ReadingLoadingView` --calls--> `ReadingService`  [INFERRED]
  OracleBrew/OracleBrew/Screens/Loading/ReadingLoadingView.swift → OracleBrew/OracleBrew/Backbone/Network/ReadingService.swift
- `BrewReadingFlow` --calls--> `ReadingDraft`  [INFERRED]
  OracleBrew/OracleBrew/Screens/BrewReading/BrewReadingFlow.swift → OracleBrew/OracleBrew/Backbone/ReadingDraft.swift
- `SegmentedSelector` --calls--> `Color`  [INFERRED]
  OracleBrew/OracleBrew/Kit/SegmentedSelector.swift → OracleBrew/OracleBrew/Kit/Pigment.swift
- `HistoryCard` --calls--> `Color`  [INFERRED]
  OracleBrew/OracleBrew/Screens/History/components/HistoryCard.swift → OracleBrew/OracleBrew/Kit/Pigment.swift

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **** — docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_brew_reading_flow, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_drink_catalog, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_reading_engine, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_reading_result, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_fortune_teller_provider [INFERRED 0.80]
- **** — docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_mvvm_router, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_pathfinder, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_waypoint, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_atrium [INFERRED 0.80]

## Communities (95 total, 33 thin omitted)

### Community 0 - "Chat & Catalog DTOs"
Cohesion: 0.10
Nodes (27): AIJobDTO, ChatMessage, Emissary, Encodable, Encoder, Int, ChatDetailDTO, ChatJobDTO (+19 more)

### Community 1 - "History & Navigation"
Cohesion: 0.24
Nodes (7): HistoryItem, HistoryReplayView, HistoryView, CGFloat, Pathfinder, Reading, Void

### Community 2 - "Country Catalog & API Config"
Cohesion: 0.12
Nodes (15): Binding, EmissaryFailure, BrewReadingFlow, FlowStub, ReadingStep, chat, intention, loading (+7 more)

### Community 3 - "Reading Service & JSON"
Cohesion: 0.09
Nodes (22): NSObject, OracleContent, OracleContentCatalog, Bool, Double, Int, String, Cadence (+14 more)

### Community 4 - "Chat Wire Models"
Cohesion: 0.06
Nodes (52): Decodable, CodingKeys, authorName, bio, createdAt, description, id, illustration (+44 more)

### Community 5 - "Flow Layout & Bubble Shapes"
Cohesion: 0.15
Nodes (9): CGRect, BubbleTail, Bool, Sparkle, SparklePair, CGRect, Path, Path (+1 more)

### Community 6 - "Onboarding Conversation Flow"
Cohesion: 0.19
Nodes (14): Identifiable, OnboardingChoice, OnboardingControl, birthDate, countryWheel, employmentWheel, interests, options (+6 more)

### Community 7 - "App Root & Catalog Store"
Cohesion: 0.08
Nodes (26): Calendar, Date, Duration, Equatable, FortuneCatalog, Int, String, Line (+18 more)

### Community 8 - "Cup Camera Capture"
Cohesion: 0.06
Nodes (38): HTTPURLResponse, JSONDecoder, APIConfig, String, AnyEncodable, Data, Emissary, EmissaryRequest (+30 more)

### Community 9 - "Profile Dropdown Controls"
Cohesion: 0.10
Nodes (26): Label, DropdownChevron, DropdownOverlay, DropdownRow, ProfileFieldBox, Bool, CGFloat, Content (+18 more)

### Community 10 - "Oracle Entity API Contract"
Cohesion: 0.13
Nodes (14): AnyClass, AVCaptureSession, AVCaptureVideoPreviewLayer, AVPlayer, AVPlayerLayer, Context, CameraPreview, PreviewView (+6 more)

### Community 11 - "Daily Fortune Catalog"
Cohesion: 0.19
Nodes (13): OnboardingBirthPicker, OnboardingContinue, OnboardingInterests, OnboardingOptions, OnboardingTextEntry, OnboardingWheel, Bool, Int (+5 more)

### Community 12 - "Project Design Notes"
Cohesion: 0.10
Nodes (26): Backbone (Services + Mock Data), Brew Reading Flow, ChatEngine, Deferred Scope (Not in v1.0), DrinkCatalog, Fortune Teller Characters, FortuneTellerProvider, HistoryStore (+18 more)

### Community 13 - "Oracle & Review DTOs"
Cohesion: 0.14
Nodes (14): Int, Zodiac, aquarius, aries, cancer, capricorn, gemini, leo (+6 more)

### Community 14 - "Intention: Topic & Horizon"
Cohesion: 0.06
Nodes (31): CatalogStore, String, FortuneTeller, FortuneTellerRoster, Review, Bool, Double, Hasher (+23 more)

### Community 15 - "Settings Row Components"
Cohesion: 0.17
Nodes (15): SettingsArrow, SettingsDivider, SettingsIcon, SettingsRow, SettingsSectionLabel, SettingsToggleRow, Bool, CGFloat (+7 more)

### Community 16 - "User Profile Enums"
Cohesion: 0.14
Nodes (15): Codable, ChildrenStatus, have, none, planning, Identity, female, male (+7 more)

### Community 18 - "Emissary Request Building"
Cohesion: 0.17
Nodes (12): CodingKeys, children, country, dataConsent, dateOfBirth, employmentStatus, gender, name (+4 more)

### Community 19 - "Typography & Nav Chrome"
Cohesion: 0.29
Nodes (5): BrewModel, LocalizedStringKey, BrewView, CGFloat, LocalizedStringKey

### Community 20 - "Catalog Repository"
Cohesion: 0.10
Nodes (17): Drink, DrinkCatalog, Bool, Color, LocalizedStringKey, String, UIImage, HistoryItem (+9 more)

### Community 21 - "Reading Result Screen"
Cohesion: 0.29
Nodes (8): Image, ReadingResultView, LocalizedStringKey, String, Void, Reading, ShareCardImage, View

### Community 23 - "Remote Image Cache"
Cohesion: 0.22
Nodes (11): ContentMode, NSCache, NSString, DecodedImages, RemoteImage, ShimmerFill, Bool, CGFloat (+3 more)

### Community 24 - "Network Send & Retry"
Cohesion: 0.40
Nodes (3): RandomCupView, String, Void

### Community 25 - "Onboarding Chrome"
Cohesion: 0.29
Nodes (7): Kind, failure, offline, ScreenStateView, LocalizedStringKey, String, Void

### Community 26 - "Zodiac Signs"
Cohesion: 0.11
Nodes (16): View, SettingsButton, StepDots, Int, OnboardingBackground, OnboardingBubble, OnboardingHeader, OnboardingPanel (+8 more)

### Community 27 - "Brew Reading Flow Steps"
Cohesion: 0.17
Nodes (12): CaseIterable, LocalizedStringKey, TimeHorizon, days, month, year, Employment, both (+4 more)

### Community 28 - "Session Gate & Bootstrap"
Cohesion: 0.29
Nodes (6): ProfileDTO, ProfileMapper, Bool, Int, String, T

### Community 30 - "PhotoCaptor"
Cohesion: 0.33
Nodes (5): ProfileRepository, Bool, Set, UserProfile, UserProfileStore

### Community 31 - "Network Failure Types"
Cohesion: 0.22
Nodes (7): Bool, Atrium, CardGradient, Spec, CGFloat, Double, RootTab

### Community 32 - "Profile Field Keys"
Cohesion: 0.05
Nodes (44): CodingKey, CodingKeys, assistantMessageId, createdAt, hasUnreadFromOracle, id, job, lastMessage (+36 more)

### Community 33 - "Profile DTO Mapping"
Cohesion: 0.28
Nodes (6): ChatSummary, ChatsView, Bool, CGFloat, Pathfinder, String

### Community 34 - "ReadingStep"
Cohesion: 0.20
Nodes (7): CGSize, LayoutDirection, CGFloat, ShareCard, String, UIImage, UnitPoint

### Community 36 - "Oracle Chat Screen"
Cohesion: 0.22
Nodes (7): ChatThread, OracleChatView, Bool, Reading, String, Void, ScrollViewProxy

### Community 37 - "Flow Buttons & Header"
Cohesion: 0.31
Nodes (8): FlowHeader, PrimaryButton, SecondaryButton, Bool, Int, LocalizedStringKey, String, Void

### Community 38 - "Topic & Teller Chips"
Cohesion: 0.29
Nodes (5): Bool, FortuneTeller, Int, Void, TellerCard

### Community 39 - "Chats List Screen"
Cohesion: 0.06
Nodes (32): ChatListItemDTO, ChatRepository, Hashable, Hasher, ChatMessage, ChatSessionStore, ChatSummary, ChatThread (+24 more)

### Community 40 - "LegalTextView"
Cohesion: 0.19
Nodes (12): Reading, ReadingEngine, ReadingSymbol, SeededGenerator, ReadingDraft, String, Entry, String (+4 more)

### Community 42 - "Profile Repository & Store"
Cohesion: 0.31
Nodes (6): Layout, FlowLayout, CGFloat, CGRect, ProposedViewSize, Subviews

### Community 44 - "Emissary Core"
Cohesion: 0.05
Nodes (32): Foundation, Country, CountryCatalog, String, EmissaryFailure, decoding, encoding, notFound (+24 more)

### Community 46 - "Community 46"
Cohesion: 0.33
Nodes (5): CGFloat, Drink, DrinkCard, Bool, Void

### Community 47 - "Community 47"
Cohesion: 0.25
Nodes (6): Color, Pigment, Double, ChatBubble, Bool, UInt32

### Community 48 - "Community 48"
Cohesion: 0.33
Nodes (6): Pigment, RatingLabel, StarRow, CGFloat, Double, Int

### Community 49 - "Community 49"
Cohesion: 0.28
Nodes (7): InterestChip, ProfileChip, ProfileSectionLabel, Bool, LocalizedStringKey, String, Void

### Community 51 - "Community 51"
Cohesion: 0.33
Nodes (6): Cadence (Metrics), Design System (Kit), Figma Source of Truth, Lettering (Fonts), Pigment (Colors), Platform Constraints (iOS 17, iPhone, Portrait, Light)

### Community 52 - "LayoutDirection"
Cohesion: 0.22
Nodes (7): ReadingDraft, Int, Reading, String, UIImage, OracleChatEntryFlow, Void

### Community 53 - "SegmentedSelector"
Cohesion: 0.09
Nodes (16): App, CoreText, Ignition, Lettering, CGFloat, Font, IntentionView, Binding (+8 more)

### Community 54 - "ShareCardRenderer.swift"
Cohesion: 0.43
Nodes (3): AVFoundation, SwiftUI, UserNotifications

### Community 55 - "Community 55"
Cohesion: 0.67
Nodes (3): Interest, InterestCatalog, String

### Community 56 - "Community 56"
Cohesion: 0.06
Nodes (29): AVCapturePhoto, AVCapturePhotoCaptureDelegate, AVCapturePhotoOutput, Error, CupCamera, Phase, denied, idle (+21 more)

### Community 57 - "FortuneTeller"
Cohesion: 0.40
Nodes (4): ReadingLoadingView, CGFloat, Double, Void

### Community 58 - "Community 58"
Cohesion: 0.33
Nodes (5): Image, LocalizedStringKey, String, Text, ThumbCard

### Community 59 - "IntentionView"
Cohesion: 0.29
Nodes (6): Content, Fields, Gaps against the content we are shipping, Language, Oracle — what the iOS client expects, Reading language — resolved

### Community 61 - "CGFloat"
Cohesion: 0.40
Nodes (4): CardOffsetKey, CGFloat, TypingBubble, PreferenceKey

### Community 64 - "Void"
Cohesion: 0.50
Nodes (3): SegmentedSelector, Item, LocalizedStringKey

### Community 65 - "PhotoUploadView"
Cohesion: 0.50
Nodes (3): Bool, String, TopicChip

### Community 66 - "ReadingStep"
Cohesion: 0.50
Nodes (3): HistoryCard, String, Void

### Community 67 - "RootTab"
Cohesion: 0.29
Nodes (7): RootTab, brew, chats, history, LocalizedStringKey, String, TabBar

### Community 68 - "Community 68"
Cohesion: 1.00
Nodes (3): Atrium (Root Container), Build Order, Ignition (@main App Entry)

### Community 69 - ".create"
Cohesion: 0.33
Nodes (5): Assets still to add (client-side, not backend), Drinks list — unchanged, Random cup — now client-side, What changed on the client, What the backend no longer needs

### Community 72 - "Ignition"
Cohesion: 0.29
Nodes (5): LocalizedStringKey, FlowCard, CGFloat, SplashView, Void

### Community 76 - ".section"
Cohesion: 0.29
Nodes (5): Content, FortuneTeller, LocalizedStringKey, Void, TellerProfileView

### Community 93 - "EmptyState"
Cohesion: 0.40
Nodes (4): EmptyState, LocalizedStringKey, String, Void

## Knowledge Gaps
- **195 isolated node(s):** `int`, `string`, `days`, `month`, `year` (+190 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **33 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `SwiftUI` connect `ShareCardRenderer.swift` to `History & Navigation`, `Country Catalog & API Config`, `Reading Service & JSON`, `Flow Layout & Bubble Shapes`, `Onboarding Conversation Flow`, `App Root & Catalog Store`, `Profile Dropdown Controls`, `Daily Fortune Catalog`, `Intention: Topic & Horizon`, `Settings Row Components`, `Typography & Nav Chrome`, `Catalog Repository`, `Reading Result Screen`, `Remote Image Cache`, `Network Send & Retry`, `Onboarding Chrome`, `Zodiac Signs`, `Network Failure Types`, `Profile DTO Mapping`, `ReadingStep`, `Flow Buttons & Header`, `Topic & Teller Chips`, `Chats List Screen`, `LegalTextView`, `Profile Repository & Store`, `Community 46`, `Community 47`, `Community 48`, `Community 49`, `LayoutDirection`, `SegmentedSelector`, `Community 55`, `Community 56`, `FortuneTeller`, `Community 58`, `CGFloat`, `Void`, `PhotoUploadView`, `ReadingStep`, `RootTab`, `Ignition`, `.section`, `EmptyState`?**
  _High betweenness centrality (0.277) - this node is a cross-community bridge._
- **Why does `Foundation` connect `Emissary Core` to `Chat & Catalog DTOs`, `Profile Field Keys`, `Chat Wire Models`, `Onboarding Conversation Flow`, `App Root & Catalog Store`, `Cup Camera Capture`, `Chats List Screen`, `LegalTextView`, `Intention: Topic & Horizon`, `User Profile Enums`, `Session Gate & Bootstrap`?**
  _High betweenness centrality (0.210) - this node is a cross-community bridge._
- **Why does `View` connect `Zodiac Signs` to `Flow Layout & Bubble Shapes`, `App Root & Catalog Store`, `Profile Dropdown Controls`, `Daily Fortune Catalog`, `Intention: Topic & Horizon`, `Settings Row Components`, `Typography & Nav Chrome`, `Catalog Repository`, `Remote Image Cache`, `Onboarding Chrome`, `ReadingStep`, `Flow Buttons & Header`, `Chats List Screen`, `Community 47`, `Community 48`, `Community 49`, `SegmentedSelector`, `Community 56`, `FortuneTeller`, `Community 58`, `Void`, `PhotoUploadView`, `ReadingStep`, `RootTab`, `EmptyState`?**
  _High betweenness centrality (0.163) - this node is a cross-community bridge._
- **What connects `int`, `string`, `days` to the rest of the system?**
  _195 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Chat & Catalog DTOs` be split into smaller, more focused modules?**
  _Cohesion score 0.09725158562367865 - nodes in this community are weakly interconnected._
- **Should `Country Catalog & API Config` be split into smaller, more focused modules?**
  _Cohesion score 0.12418300653594772 - nodes in this community are weakly interconnected._
- **Should `Reading Service & JSON` be split into smaller, more focused modules?**
  _Cohesion score 0.0873440285204991 - nodes in this community are weakly interconnected._
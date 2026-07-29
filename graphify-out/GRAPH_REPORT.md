# Graph Report - OracleBrew  (2026-07-29)

## Corpus Check
- 113 files · ~45,601 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1162 nodes · 2032 edges · 102 communities (63 shown, 39 thin omitted)
- Extraction: 93% EXTRACTED · 7% INFERRED · 0% AMBIGUOUS · INFERRED: 134 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `36074322`
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
- FlowHeader
- Emissary Core
- .step
- Community 46
- Community 47
- Community 48
- Community 49
- ReadingStep
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
- Context
- Error
- Binding
- Int
- Reading
- ReadingDraft
- Topic
- Reading Result
- Screen Bundles Folder Structure (F20)
- Int
- Reading
- String
- Throb (Haptics)
- UserProfileStore
- Vault (Storage)
- Waypoint (Route)
- Item
- Content
- LocalizedStringKey

## God Nodes (most connected - your core abstractions)
1. `SwiftUI` - 77 edges
2. `EmissaryRequest` - 29 edges
3. `FortuneTeller` - 27 edges
4. `Foundation` - 25 edges
5. `EmissaryFailure` - 25 edges
6. `UserProfile` - 25 edges
7. `CodingKeys` - 22 edges
8. `CodingKeys` - 22 edges
9. `Emissary` - 21 edges
10. `ReadingDraft` - 21 edges

## Surprising Connections (you probably didn't know these)
- `Atrium` --calls--> `ChatSessionStore`  [INFERRED]
  OracleBrew/OracleBrew/App/Atrium.swift → OracleBrew/OracleBrew/Backbone/ChatSessionStore.swift
- `Atrium` --calls--> `Pathfinder`  [INFERRED]
  OracleBrew/OracleBrew/App/Atrium.swift → OracleBrew/OracleBrew/Backbone/Pathfinder.swift
- `Atrium` --calls--> `ReadingHistoryStore`  [INFERRED]
  OracleBrew/OracleBrew/App/Atrium.swift → OracleBrew/OracleBrew/Backbone/ReadingHistory.swift
- `Atrium` --calls--> `UserProfileStore`  [INFERRED]
  OracleBrew/OracleBrew/App/Atrium.swift → OracleBrew/OracleBrew/Backbone/UserProfile.swift
- `OracleChatView` --calls--> `ChatRepository`  [INFERRED]
  OracleBrew/OracleBrew/Screens/OracleChat/OracleChatView.swift → OracleBrew/OracleBrew/Backbone/Network/ChatRepository.swift

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **** — docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_brew_reading_flow, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_drink_catalog, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_reading_engine, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_reading_result, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_fortune_teller_provider [INFERRED 0.80]
- **** — docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_mvvm_router, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_pathfinder, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_waypoint, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_atrium [INFERRED 0.80]

## Communities (102 total, 39 thin omitted)

### Community 0 - "Chat & Catalog DTOs"
Cohesion: 0.06
Nodes (33): Encodable, Atrium, Bool, CatalogStore, String, CatalogRepository, DailyFortuneDTO, Int (+25 more)

### Community 1 - "History & Navigation"
Cohesion: 0.06
Nodes (21): LocalizedStringKey, View, Pathfinder, Waypoint, profile, settings, ChatsView, Bool (+13 more)

### Community 2 - "Country Catalog & API Config"
Cohesion: 0.05
Nodes (35): AVCapturePhoto, AVCapturePhotoCaptureDelegate, AVCapturePhotoOutput, Never, CupCamera, Phase, denied, idle (+27 more)

### Community 3 - "Reading Service & JSON"
Cohesion: 0.09
Nodes (21): NSObject, Cadence, Screen, CGFloat, CameraPicker, Coordinator, Any, Bool (+13 more)

### Community 4 - "Chat Wire Models"
Cohesion: 0.10
Nodes (20): CodingKeys, authorName, bio, createdAt, description, id, illustration, image (+12 more)

### Community 5 - "Flow Layout & Bubble Shapes"
Cohesion: 0.15
Nodes (9): BubbleTail, Bool, CGRect, Path, Sparkle, SparklePair, CGRect, Path (+1 more)

### Community 6 - "Onboarding Conversation Flow"
Cohesion: 0.05
Nodes (44): HTTPURLResponse, JSONDecoder, APIConfig, String, AnyEncodable, Data, Emissary, HTTPMethod (+36 more)

### Community 7 - "App Root & Catalog Store"
Cohesion: 0.16
Nodes (13): Calendar, OnboardingLeavePopup, OnboardingLoadingView, OnboardingReadyView, OnboardingView, Int, LocalizedStringKey, ScrollViewProxy (+5 more)

### Community 8 - "Cup Camera Capture"
Cohesion: 0.18
Nodes (9): CardOffsetKey, OracleChatView, Bool, CGFloat, ScrollViewProxy, Void, TellerPeek, TypingBubble (+1 more)

### Community 9 - "Profile Dropdown Controls"
Cohesion: 0.07
Nodes (32): Label, IntBox, ProfileBirthField, ProfileField, country, day, month, relationship (+24 more)

### Community 10 - "Oracle Entity API Contract"
Cohesion: 0.15
Nodes (13): CodingKeys, adviceHeadline, createdAt, cupImage, drink, hasChat, id, oracle (+5 more)

### Community 11 - "Daily Fortune Catalog"
Cohesion: 0.19
Nodes (13): OnboardingBirthPicker, OnboardingContinue, OnboardingInterests, OnboardingOptions, OnboardingTextEntry, OnboardingWheel, Bool, Int (+5 more)

### Community 13 - "Oracle & Review DTOs"
Cohesion: 0.09
Nodes (27): CaseIterable, Codable, LocalizedStringKey, TimeHorizon, days, month, year, ChildrenStatus (+19 more)

### Community 14 - "Intention: Topic & Horizon"
Cohesion: 0.07
Nodes (18): Foundation, FortuneCatalog, Date, Int, String, Paginated, Bool, Int (+10 more)

### Community 15 - "Settings Row Components"
Cohesion: 0.15
Nodes (17): SettingsArrow, SettingsCard, SettingsDivider, SettingsIcon, SettingsRow, SettingsSectionLabel, SettingsToggleRow, Bool (+9 more)

### Community 16 - "User Profile Enums"
Cohesion: 0.07
Nodes (27): HistoryRepository, Int, Reading, ReadingEngine, ReadingSymbol, SeededGenerator, String, HistoryItem (+19 more)

### Community 17 - "Chat Session Store"
Cohesion: 0.12
Nodes (9): CoreText, SettingsButton, StepDots, Int, ChatBackground, ChatBubble, Bool, SwiftUI (+1 more)

### Community 18 - "Emissary Request Building"
Cohesion: 0.10
Nodes (20): CodingKeys, adviceHeadline, aiJobId, baseDescription, cupImage, hasChat, icon, id (+12 more)

### Community 19 - "Typography & Nav Chrome"
Cohesion: 0.29
Nodes (5): BrewModel, LocalizedStringKey, BrewView, CGFloat, LocalizedStringKey

### Community 20 - "Catalog Repository"
Cohesion: 0.10
Nodes (16): Drink, DrinkCatalog, Bool, LocalizedStringKey, String, UIImage, DrinkCard, Bool (+8 more)

### Community 21 - "Reading Result Screen"
Cohesion: 0.22
Nodes (8): Lettering, CGFloat, Font, ReadingResultView, Image, LocalizedStringKey, String, Void

### Community 22 - "Splash Video Player"
Cohesion: 0.14
Nodes (14): Int, Zodiac, aquarius, aries, cancer, capricorn, gemini, leo (+6 more)

### Community 23 - "Remote Image Cache"
Cohesion: 0.20
Nodes (7): Bool, String, TopicChip, Bool, Int, Void, TellerCard

### Community 24 - "Network Send & Retry"
Cohesion: 0.19
Nodes (14): Identifiable, OnboardingChoice, OnboardingControl, birthDate, countryWheel, employmentWheel, interests, options (+6 more)

### Community 25 - "Onboarding Chrome"
Cohesion: 0.29
Nodes (7): Kind, failure, offline, ScreenStateView, LocalizedStringKey, String, Void

### Community 26 - "Zodiac Signs"
Cohesion: 0.20
Nodes (9): OnboardingBackground, OnboardingBubble, OnboardingHeader, OnboardingPanel, OnboardingTyping, Bool, Content, Double (+1 more)

### Community 27 - "Brew Reading Flow Steps"
Cohesion: 0.11
Nodes (18): CodingKeys, assistantMessageId, createdAt, hasUnreadFromOracle, id, job, lastMessage, messages (+10 more)

### Community 28 - "Session Gate & Bootstrap"
Cohesion: 0.26
Nodes (7): Duration, Line, OnboardingFlow, Bool, Double, String, Void

### Community 29 - "Interests & Profile Chips"
Cohesion: 0.27
Nodes (6): AVCaptureSession, AVCaptureVideoPreviewLayer, CameraPreview, PreviewView, AnyClass, Context

### Community 30 - "PhotoCaptor"
Cohesion: 0.22
Nodes (11): ContentMode, NSCache, NSString, DecodedImages, RemoteImage, ShimmerFill, Bool, CGFloat (+3 more)

### Community 31 - "Network Failure Types"
Cohesion: 0.25
Nodes (7): CardGradient, Spec, Bool, CGFloat, CGSize, Double, UnitPoint

### Community 32 - "Profile Field Keys"
Cohesion: 0.20
Nodes (11): ProfileDTO, ProfileMapper, ProfileRepository, Bool, Int, String, T, Bool (+3 more)

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
Cohesion: 0.17
Nodes (12): CodingKeys, children, country, dataConsent, dateOfBirth, employmentStatus, gender, name (+4 more)

### Community 37 - "Flow Buttons & Header"
Cohesion: 0.20
Nodes (9): Making the API key, Making the certificate and profile, Notes for later, Releasing OracleBrew, Running it, Secrets to create, The SPM signing script, Things it does not do (+1 more)

### Community 38 - "Topic & Teller Chips"
Cohesion: 0.20
Nodes (7): IntentionView, Binding, Bool, Content, LocalizedStringKey, String, Void

### Community 39 - "Chats List Screen"
Cohesion: 0.50
Nodes (8): AIJobDTO, ReadingDTO, ReadingResultDTO, ReadingSymbolDTO, Bool, Int, String, SymbolDTO

### Community 40 - "LegalTextView"
Cohesion: 0.33
Nodes (6): CodingKey, AuthResponse, CodingKeys, shareCode, token, String

### Community 41 - "Palette & Brew Cards"
Cohesion: 0.33
Nodes (3): App, Ignition, Scene

### Community 42 - "Profile Repository & Store"
Cohesion: 0.27
Nodes (7): Layout, FlowLayout, CGFloat, CGRect, CGSize, ProposedViewSize, Subviews

### Community 43 - "FlowHeader"
Cohesion: 0.33
Nodes (5): Image, LocalizedStringKey, String, Text, ThumbCard

### Community 44 - "Emissary Core"
Cohesion: 0.05
Nodes (42): ChatMessage, ChatSessionStore, ChatSummary, ChatThread, Bool, Date, Hasher, Int (+34 more)

### Community 45 - ".step"
Cohesion: 0.33
Nodes (4): Content, LocalizedStringKey, Void, TellerProfileView

### Community 46 - "Community 46"
Cohesion: 0.06
Nodes (29): Hashable, Country, CountryCatalog, String, Bool, Hasher, Int, Topic (+21 more)

### Community 47 - "Community 47"
Cohesion: 0.19
Nodes (10): Interest, InterestCatalog, String, InterestChip, ProfileChip, ProfileSectionLabel, Bool, LocalizedStringKey (+2 more)

### Community 48 - "Community 48"
Cohesion: 0.40
Nodes (5): Equatable, Stage, asking, ready, saving

### Community 49 - "Community 49"
Cohesion: 0.18
Nodes (8): FortuneTellersView, Int, LocalizedStringKey, Void, ReadingLoadingView, CGFloat, Double, Void

### Community 50 - "ReadingStep"
Cohesion: 0.50
Nodes (3): SegmentedSelector, Item, LocalizedStringKey

### Community 52 - "LayoutDirection"
Cohesion: 0.33
Nodes (6): Pigment, RatingLabel, StarRow, CGFloat, Double, Int

### Community 54 - "ShareCardRenderer.swift"
Cohesion: 0.16
Nodes (11): AVFoundation, AVPlayer, AVPlayerLayer, PlayerView, AnyClass, Context, VideoLayerView, SplashView (+3 more)

### Community 55 - "Community 55"
Cohesion: 0.50
Nodes (3): SymbolChip, ReadingSymbol, SymbolCatalog

### Community 56 - "Community 56"
Cohesion: 0.33
Nodes (5): CupPhoto, CupPhotoBox, Bool, CGFloat, Content

### Community 57 - "FortuneTeller"
Cohesion: 0.12
Nodes (14): Error, ShareCard, String, UIImage, ShareCardError, encodingFailed, ShareCardImage, ShareCardRenderer (+6 more)

### Community 58 - "Community 58"
Cohesion: 0.42
Nodes (11): Decodable, DrinkDTO, OracleDTO, ReviewDTO, SpecializationDTO, Double, Int, String (+3 more)

### Community 59 - "IntentionView"
Cohesion: 0.29
Nodes (6): Content, Fields, Gaps against the content we are shipping, Language, Oracle — what the iOS client expects, Reading language — resolved

### Community 61 - "CGFloat"
Cohesion: 0.33
Nodes (5): FlowCard, CGFloat, LocalizedStringKey, String, Void

### Community 67 - "RootTab"
Cohesion: 0.29
Nodes (7): RootTab, brew, chats, history, LocalizedStringKey, String, TabBar

### Community 69 - ".create"
Cohesion: 0.33
Nodes (5): Assets still to add (client-side, not backend), Drinks list — unchanged, Random cup — now client-side, What changed on the client, What the backend no longer needs

### Community 76 - ".section"
Cohesion: 0.40
Nodes (4): Color, Pigment, Double, UInt32

### Community 101 - "Item"
Cohesion: 0.40
Nodes (4): EmptyState, LocalizedStringKey, String, Void

### Community 102 - "Content"
Cohesion: 0.70
Nodes (4): add_provisioning_profile_variants(), exclude_spm_from_signing(), find_main_target_config_list(), find_release_config_variants()

## Knowledge Gaps
- **246 isolated node(s):** `Running it`, `Making the certificate and profile`, `Making the API key`, `What the workflow does`, `The SPM signing script` (+241 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **39 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `SwiftUI` connect `Chat Session Store` to `Chat & Catalog DTOs`, `History & Navigation`, `Country Catalog & API Config`, `Reading Service & JSON`, `Flow Layout & Bubble Shapes`, `App Root & Catalog Store`, `Cup Camera Capture`, `Profile Dropdown Controls`, `Daily Fortune Catalog`, `Settings Row Components`, `User Profile Enums`, `Typography & Nav Chrome`, `Catalog Repository`, `Remote Image Cache`, `Network Send & Retry`, `Onboarding Chrome`, `Zodiac Signs`, `Session Gate & Bootstrap`, `Interests & Profile Chips`, `PhotoCaptor`, `Network Failure Types`, `ReadingStep`, `Topic & Teller Chips`, `Palette & Brew Cards`, `Profile Repository & Store`, `FlowHeader`, `Emissary Core`, `.step`, `Community 46`, `Community 47`, `Community 49`, `ReadingStep`, `LayoutDirection`, `SegmentedSelector`, `ShareCardRenderer.swift`, `Community 55`, `Community 56`, `FortuneTeller`, `CGFloat`, `RootTab`, `.section`, `Item`?**
  _High betweenness centrality (0.245) - this node is a cross-community bridge._
- **Why does `Foundation` connect `Intention: Topic & Horizon` to `Chat & Catalog DTOs`, `Profile Field Keys`, `History & Navigation`, `Onboarding Conversation Flow`, `Chats List Screen`, `LegalTextView`, `Oracle Entity API Contract`, `Emissary Core`, `Oracle & Review DTOs`, `Community 46`, `User Profile Enums`, `Network Send & Retry`, `Community 58`, `Session Gate & Bootstrap`?**
  _High betweenness centrality (0.165) - this node is a cross-community bridge._
- **Why does `OracleChatView` connect `Cup Camera Capture` to `Chat & Catalog DTOs`, `Community 49`, `Emissary Core`, `App Root & Catalog Store`?**
  _High betweenness centrality (0.055) - this node is a cross-community bridge._
- **Are the 21 inferred relationships involving `EmissaryRequest` (e.g. with `.dailyFortune()` and `.drinks()`) actually correct?**
  _`EmissaryRequest` has 21 INFERRED edges - model-reasoned connections that need verification._
- **What connects `Running it`, `Making the certificate and profile`, `Making the API key` to the rest of the system?**
  _246 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Chat & Catalog DTOs` be split into smaller, more focused modules?**
  _Cohesion score 0.0635814889336016 - nodes in this community are weakly interconnected._
- **Should `History & Navigation` be split into smaller, more focused modules?**
  _Cohesion score 0.06190476190476191 - nodes in this community are weakly interconnected._
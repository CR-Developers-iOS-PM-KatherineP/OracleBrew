# Graph Report - OracleBrew  (2026-07-31)

## Corpus Check
- 117 files · ~50,812 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1140 nodes · 2120 edges · 115 communities (72 shown, 43 thin omitted)
- Extraction: 93% EXTRACTED · 7% INFERRED · 0% AMBIGUOUS · INFERRED: 145 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `f8c91fe8`
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
- Community 48
- Community 49
- ReadingStep
- Community 51
- LayoutDirection
- ShareCardRenderer.swift
- Community 56
- FortuneTeller
- IntentionView
- Community 60
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
- PagedList
- Content
- Topic
- Reading
- StepDots
- Void
- Bool
- PhotoUploadView
- FlowHeader
- ScreenPhase
- AnyJSON
- TokenVault
- UIKit
- EmptyState
- Image
- .section
- .page
- Image
- Text
- Bool
- SegmentedSelector
- APIDate

## God Nodes (most connected - your core abstractions)
1. `String` - 140 edges
2. `SwiftUI` - 77 edges
3. `EmissaryRequest` - 33 edges
4. `Foundation` - 28 edges
5. `EmissaryFailure` - 28 edges
6. `FortuneTeller` - 27 edges
7. `UserProfile` - 25 edges
8. `CodingKeys` - 23 edges
9. `CodingKeys` - 22 edges
10. `ReadingDraft` - 22 edges

## Surprising Connections (you probably didn't know these)
- `Atrium` --calls--> `CatalogStore`  [INFERRED]
  OracleBrew/OracleBrew/App/Atrium.swift → OracleBrew/OracleBrew/Backbone/CatalogStore.swift
- `Atrium` --calls--> `ChatSessionStore`  [INFERRED]
  OracleBrew/OracleBrew/App/Atrium.swift → OracleBrew/OracleBrew/Backbone/ChatSessionStore.swift
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

## Communities (115 total, 43 thin omitted)

### Community 0 - "Chat & Catalog DTOs"
Cohesion: 0.39
Nodes (5): ReadingEngine, ReadingSymbol, SeededGenerator, RandomNumberGenerator, UInt64

### Community 1 - "History & Navigation"
Cohesion: 0.11
Nodes (18): CodingKeys, assistantMessageId, createdAt, hasUnreadFromOracle, id, job, lastMessage, messages (+10 more)

### Community 2 - "Country Catalog & API Config"
Cohesion: 0.29
Nodes (6): Duration, Line, OnboardingFlow, Bool, Double, Void

### Community 3 - "Reading Service & JSON"
Cohesion: 0.06
Nodes (32): Error, Cadence, Screen, CGFloat, CameraPicker, Coordinator, Any, Bool (+24 more)

### Community 4 - "Chat Wire Models"
Cohesion: 0.06
Nodes (46): Decodable, Encodable, MainActor, CatalogStore, CatalogRepository, DailyFortuneDTO, Int, ChatDetailDTO (+38 more)

### Community 5 - "Flow Layout & Bubble Shapes"
Cohesion: 0.15
Nodes (9): BubbleTail, Bool, CGRect, Path, Sparkle, SparklePair, CGRect, Path (+1 more)

### Community 6 - "Onboarding Conversation Flow"
Cohesion: 0.25
Nodes (7): Hashable, Interest, InterestCatalog, ChatEntryStep, chat, OracleChatEntryFlow, Void

### Community 7 - "App Root & Catalog Store"
Cohesion: 0.25
Nodes (6): AVFoundation, Phase, denied, idle, running, unavailable

### Community 8 - "Cup Camera Capture"
Cohesion: 0.10
Nodes (21): CodingKeys, adviceHeadline, aiJobId, baseDescription, createdAt, cupImage, hasChat, icon (+13 more)

### Community 9 - "Profile Dropdown Controls"
Cohesion: 0.08
Nodes (28): IntBox, ProfileBirthField, ProfileField, country, day, month, relationship, year (+20 more)

### Community 10 - "Oracle Entity API Contract"
Cohesion: 0.20
Nodes (6): OnboardingLeavePopup, OnboardingLoadingView, OnboardingView, ScrollViewProxy, Set, Void

### Community 11 - "Daily Fortune Catalog"
Cohesion: 0.14
Nodes (7): Foundation, FeatureGates, Paginated, Bool, Int, Item, Features

### Community 13 - "Oracle & Review DTOs"
Cohesion: 0.05
Nodes (46): CaseIterable, Codable, ProfileDTO, ProfileMapper, ProfileRepository, Bool, Int, T (+38 more)

### Community 14 - "Intention: Topic & Horizon"
Cohesion: 0.15
Nodes (13): Equatable, FortuneTeller, FortuneTellerRoster, Review, Bool, Double, Hasher, Int (+5 more)

### Community 15 - "Settings Row Components"
Cohesion: 0.17
Nodes (14): SettingsArrow, SettingsCard, SettingsDivider, SettingsRow, SettingsSectionLabel, SettingsToggleRow, Bool, Content (+6 more)

### Community 16 - "User Profile Enums"
Cohesion: 0.16
Nodes (12): CodingKeys, adviceHeadline, createdAt, cupImage, drink, hasChat, id, oracle (+4 more)

### Community 17 - "Chat Session Store"
Cohesion: 0.14
Nodes (5): CoreText, SettingsButton, ChatBackground, ReviewCard, SwiftUI

### Community 18 - "Emissary Request Building"
Cohesion: 0.06
Nodes (22): Atrium, Bool, View, SessionGate, Any, TokenVault, Pathfinder, Waypoint (+14 more)

### Community 19 - "Typography & Nav Chrome"
Cohesion: 0.29
Nodes (5): BrewModel, LocalizedStringKey, BrewView, CGFloat, LocalizedStringKey

### Community 20 - "Catalog Repository"
Cohesion: 0.22
Nodes (7): Drink, DrinkCatalog, Bool, LocalizedStringKey, UIImage, DrinkSelectionView, Void

### Community 21 - "Reading Result Screen"
Cohesion: 0.05
Nodes (42): HTTPURLResponse, JSONDecoder, APIConfig, AnyEncodable, Data, Emissary, HTTPMethod, delete (+34 more)

### Community 22 - "Splash Video Player"
Cohesion: 0.27
Nodes (5): HistoryItem, ReadingHistoryStore, Bool, Hasher, Int

### Community 24 - "Network Send & Retry"
Cohesion: 0.36
Nodes (5): AVPlayerLayer, PlayerView, AnyClass, Context, VideoLayerView

### Community 25 - "Onboarding Chrome"
Cohesion: 0.21
Nodes (7): Label, LocalizedStringKey, Never, Task, Void, Tidings, ChatThreadRow

### Community 26 - "Zodiac Signs"
Cohesion: 0.33
Nodes (6): Kind, failure, offline, ScreenStateView, LocalizedStringKey, Void

### Community 27 - "Brew Reading Flow Steps"
Cohesion: 0.33
Nodes (3): App, Ignition, Scene

### Community 28 - "Session Gate & Bootstrap"
Cohesion: 0.20
Nodes (12): OnboardingChoice, OnboardingControl, birthDate, countryWheel, employmentWheel, interests, options, relationshipWheel (+4 more)

### Community 29 - "Interests & Profile Chips"
Cohesion: 0.22
Nodes (8): AVCaptureSession, AVCaptureVideoPreviewLayer, CameraPreview, PreviewView, AnyClass, Context, UIView, UIViewRepresentable

### Community 30 - "PhotoCaptor"
Cohesion: 0.22
Nodes (10): ContentMode, NSCache, NSString, DecodedImages, RemoteImage, ShimmerFill, Bool, CGFloat (+2 more)

### Community 31 - "Network Failure Types"
Cohesion: 0.33
Nodes (5): CodingKey, AuthResponse, CodingKeys, shareCode, token

### Community 32 - "Profile Field Keys"
Cohesion: 0.17
Nodes (12): CodingKeys, children, country, dataConsent, dateOfBirth, employmentStatus, gender, name (+4 more)

### Community 33 - "Profile DTO Mapping"
Cohesion: 0.15
Nodes (12): A. New features (new product value), B. Polish & UX, C. Networking & reliability, Competitive insights (2026 research), D. Content & known tails (from this session), E0. What each new feature needs from the backend, E. Backend asks (from the entity docs), F. Repo hygiene (+4 more)

### Community 35 - "Lettering Fonts"
Cohesion: 0.15
Nodes (12): 10. Deferred (NOT in v1.0), 11. Open questions (resolve at build), 1. What it is, 2. Project combo (fixed), 3. Platform & constraints (from base regimen), 4. Screen inventory, 5. Mock / data layer (Backbone), 6. Registration (+4 more)

### Community 36 - "Oracle Chat Screen"
Cohesion: 0.10
Nodes (20): CodingKeys, authorName, bio, createdAt, description, id, illustration, image (+12 more)

### Community 37 - "Flow Buttons & Header"
Cohesion: 0.20
Nodes (9): Making the API key, Making the certificate and profile, Notes for later, Releasing OracleBrew, Running it, Secrets to create, The SPM signing script, Things it does not do (+1 more)

### Community 39 - "Chats List Screen"
Cohesion: 0.50
Nodes (3): LayoutDirection, CGFloat, UnitPoint

### Community 40 - "LegalTextView"
Cohesion: 0.15
Nodes (11): CardGradient, Spec, Bool, CGFloat, CGSize, Double, UnitPoint, FlowCard (+3 more)

### Community 42 - "Profile Repository & Store"
Cohesion: 0.27
Nodes (7): Layout, FlowLayout, CGFloat, CGRect, CGSize, ProposedViewSize, Subviews

### Community 43 - "FlowHeader"
Cohesion: 0.41
Nodes (5): Reading, ReadingResultView, Image, LocalizedStringKey, Void

### Community 44 - "Emissary Core"
Cohesion: 0.28
Nodes (9): Identifiable, ChatMessage, ChatSessionStore, ChatSummary, ChatThread, Bool, Hasher, Int (+1 more)

### Community 45 - ".step"
Cohesion: 0.50
Nodes (3): Bool, Void, TopicButton

### Community 48 - "Community 48"
Cohesion: 0.25
Nodes (8): AVCapturePhoto, AVCapturePhotoCaptureDelegate, AVCapturePhotoOutput, NSObject, PhotoCaptor, Error, UIImage, Void

### Community 49 - "Community 49"
Cohesion: 0.18
Nodes (9): CardOffsetKey, OracleChatView, Bool, CGFloat, ScrollViewProxy, Void, TellerPeek, TypingBubble (+1 more)

### Community 50 - "ReadingStep"
Cohesion: 0.29
Nodes (6): Color, Pigment, Double, SettingsIcon, CGFloat, UInt32

### Community 52 - "LayoutDirection"
Cohesion: 0.33
Nodes (6): Pigment, RatingLabel, StarRow, CGFloat, Double, Int

### Community 54 - "ShareCardRenderer.swift"
Cohesion: 0.40
Nodes (4): DrinkCard, Bool, CGFloat, Void

### Community 56 - "Community 56"
Cohesion: 0.33
Nodes (5): CupPhoto, CupPhotoBox, Bool, CGFloat, Content

### Community 57 - "FortuneTeller"
Cohesion: 0.15
Nodes (9): ReadingDraft, Int, UIImage, HistoryReplayView, HistoryView, Binding, Bool, CGFloat (+1 more)

### Community 59 - "IntentionView"
Cohesion: 0.29
Nodes (6): Content, Fields, Gaps against the content we are shipping, Language, Oracle — what the iOS client expects, Reading language — resolved

### Community 67 - "RootTab"
Cohesion: 0.14
Nodes (10): FortuneTellersView, Int, LocalizedStringKey, Void, IntentionView, Binding, Bool, Content (+2 more)

### Community 69 - ".create"
Cohesion: 0.33
Nodes (5): Assets still to add (client-side, not backend), Drinks list — unchanged, Random cup — now client-side, What changed on the client, What the backend no longer needs

### Community 101 - "PagedList"
Cohesion: 0.30
Nodes (4): PagedList, Bool, Int, Item

### Community 102 - "Content"
Cohesion: 0.70
Nodes (4): add_provisioning_profile_variants(), exclude_spm_from_signing(), find_main_target_config_list(), find_release_config_variants()

### Community 104 - "Topic"
Cohesion: 0.40
Nodes (4): ReadingLoadingView, CGFloat, Double, Void

### Community 106 - "Reading"
Cohesion: 0.29
Nodes (5): Lettering, CGFloat, Font, OnboardingReadyView, LocalizedStringKey

### Community 111 - "StepDots"
Cohesion: 0.15
Nodes (14): HistoryCard, Void, OnboardingBackground, OnboardingBubble, OnboardingHeader, OnboardingPanel, OnboardingTyping, Bool (+6 more)

### Community 112 - "Void"
Cohesion: 0.33
Nodes (5): AVPlayer, SplashView, Never, Task, Void

### Community 116 - "Bool"
Cohesion: 0.17
Nodes (13): OnboardingBirthPicker, OnboardingContinue, OnboardingInterests, OnboardingOptions, OnboardingTextEntry, OnboardingWheel, Bool, Int (+5 more)

### Community 118 - "PhotoUploadView"
Cohesion: 0.17
Nodes (7): CupCamera, Bool, PhotoUploadView, Bool, Void, PhotosPickerItem, PhotosUI

### Community 123 - "FlowHeader"
Cohesion: 0.15
Nodes (13): FlowHeader, PrimaryButton, SecondaryButton, Bool, Int, LocalizedStringKey, Void, Feel (+5 more)

### Community 128 - "AnyJSON"
Cohesion: 0.22
Nodes (6): Bool, TopicChip, Bool, Int, Void, TellerCard

### Community 131 - "TokenVault"
Cohesion: 0.14
Nodes (10): LegalCopy, LegalTextView, LocalizedStringKey, Void, SettingsDestination, privacy, terms, SettingsView (+2 more)

### Community 138 - "UIKit"
Cohesion: 0.19
Nodes (10): Bool, Hasher, Int, LocalizedStringKey, TimeHorizon, days, month, year (+2 more)

### Community 139 - "EmptyState"
Cohesion: 0.50
Nodes (3): EmptyState, LocalizedStringKey, Void

### Community 144 - "Image"
Cohesion: 0.23
Nodes (10): AttributedString, OracleContent, OracleContentCatalog, Bool, Double, Int, Entry, Bool (+2 more)

### Community 157 - ".section"
Cohesion: 0.33
Nodes (4): Content, LocalizedStringKey, Void, TellerProfileView

### Community 159 - ".page"
Cohesion: 0.22
Nodes (7): ScreenPhase, content, loadFailure, loading, offline, Bool, Content

### Community 160 - "Image"
Cohesion: 0.38
Nodes (6): InterestChip, ProfileChip, ProfileSectionLabel, Bool, LocalizedStringKey, Void

### Community 164 - "Text"
Cohesion: 0.33
Nodes (5): CGFloat, Image, LocalizedStringKey, Text, ThumbCard

### Community 180 - "Bool"
Cohesion: 0.15
Nodes (13): BrewReadingFlow, FlowStub, ReadingStep, chat, intention, loading, photo, result (+5 more)

### Community 181 - "SegmentedSelector"
Cohesion: 0.50
Nodes (3): SegmentedSelector, Item, LocalizedStringKey

### Community 182 - "APIDate"
Cohesion: 0.15
Nodes (8): Calendar, ISO8601DateFormatter, FortuneCatalog, Int, APIDate, Date, RelativeTime, Int

## Knowledge Gaps
- **251 isolated node(s):** `figma-dev-mode`, `AppTrackingTransparency`, `FeatureGates`, `days`, `month` (+246 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **43 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `String` connect `Image` to `Chat & Catalog DTOs`, `History & Navigation`, `AnyJSON`, `Country Catalog & API Config`, `Chat Wire Models`, `TokenVault`, `Onboarding Conversation Flow`, `Reading Service & JSON`, `Cup Camera Capture`, `Profile Dropdown Controls`, `UIKit`, `Daily Fortune Catalog`, `EmptyState`, `Oracle & Review DTOs`, `Intention: Topic & Horizon`, `Oracle Entity API Contract`, `User Profile Enums`, `Settings Row Components`, `Emissary Request Building`, `Catalog Repository`, `Reading Result Screen`, `Splash Video Player`, `Remote Image Cache`, `Onboarding Chrome`, `Zodiac Signs`, `Session Gate & Bootstrap`, `PhotoCaptor`, `Network Failure Types`, `Profile Field Keys`, `Image`, `Oracle Chat Screen`, `Text`, `Topic & Teller Chips`, `LegalTextView`, `FlowHeader`, `Emissary Core`, `ReadingStep`, `APIDate`, `FortuneTeller`, `RootTab`, `Topic`, `Reading`, `StepDots`, `Bool`, `FlowHeader`?**
  _High betweenness centrality (0.459) - this node is a cross-community bridge._
- **Why does `SwiftUI` connect `Chat Session Store` to `AnyJSON`, `Country Catalog & API Config`, `Reading Service & JSON`, `Chat Wire Models`, `Flow Layout & Bubble Shapes`, `Onboarding Conversation Flow`, `App Root & Catalog Store`, `TokenVault`, `Profile Dropdown Controls`, `UIKit`, `EmptyState`, `Oracle Entity API Contract`, `Settings Row Components`, `Emissary Request Building`, `Typography & Nav Chrome`, `Catalog Repository`, `Splash Video Player`, `Remote Image Cache`, `Network Send & Retry`, `Zodiac Signs`, `Brew Reading Flow Steps`, `Session Gate & Bootstrap`, `.section`, `PhotoCaptor`, `Image`, `ReadingStep`, `Text`, `Chats List Screen`, `LegalTextView`, `Palette & Brew Cards`, `Profile Repository & Store`, `.step`, `Community 46`, `Community 49`, `ReadingStep`, `LayoutDirection`, `SegmentedSelector`, `Bool`, `ShareCardRenderer.swift`, `Community 56`, `FortuneTeller`, `RootTab`, `Topic`, `StepDots`, `Bool`, `PhotoUploadView`, `FlowHeader`, `ScreenPhase`?**
  _High betweenness centrality (0.160) - this node is a cross-community bridge._
- **Why does `HistoryItem` connect `Splash Video Player` to `Onboarding Conversation Flow`, `UIKit`, `Emissary Core`, `Intention: Topic & Horizon`, `StepDots`, `User Profile Enums`, `Image`, `Catalog Repository`, `APIDate`, `FortuneTeller`?**
  _High betweenness centrality (0.051) - this node is a cross-community bridge._
- **Are the 25 inferred relationships involving `EmissaryRequest` (e.g. with `.dailyFortune()` and `.drinks()`) actually correct?**
  _`EmissaryRequest` has 25 INFERRED edges - model-reasoned connections that need verification._
- **What connects `figma-dev-mode`, `AppTrackingTransparency`, `FeatureGates` to the rest of the system?**
  _251 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `History & Navigation` be split into smaller, more focused modules?**
  _Cohesion score 0.1111111111111111 - nodes in this community are weakly interconnected._
- **Should `Reading Service & JSON` be split into smaller, more focused modules?**
  _Cohesion score 0.05555555555555555 - nodes in this community are weakly interconnected._
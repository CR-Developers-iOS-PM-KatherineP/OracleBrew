# Graph Report - OracleBrew  (2026-07-31)

## Corpus Check
- 117 files · ~50,812 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1278 nodes · 1979 edges · 181 communities (78 shown, 103 thin omitted)
- Extraction: 97% EXTRACTED · 3% INFERRED · 0% AMBIGUOUS · INFERRED: 55 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `52ca37a4`
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
- ReadingLoadingView
- Context
- Error
- Binding
- Int
- Reading
- ReadingDraft
- Topic
- Reading Result
- Screen Bundles Folder Structure (F20)
- Resonance
- Int
- Reading
- String
- Throb (Haptics)
- UserProfileStore
- Vault (Storage)
- Waypoint (Route)
- PagedList
- Content
- UserProfile
- Topic
- Atrium
- Reading
- OracleContent
- Bool
- FlowHeader
- Int
- StepDots
- Void
- Void
- ThumbCard
- LayoutDirection
- Bool
- Int
- PhotoUploadView
- ReadingDraft
- DrinkCard
- UIKit
- PagedList
- FlowHeader
- Entry
- ScreenPhase
- AnyJSON
- ReadingStep
- PagedList
- TokenVault
- Bool
- Content
- LocalizedStringKey
- String
- Void
- UIKit
- EmptyState
- FortuneTellersView
- Bool
- LocalizedStringKey
- Void
- Image
- LocalizedStringKey
- String
- Void
- CatalogStore
- TopicChip
- TopicButton
- T
- URLRequest
- LocalizedStringKey
- CGFloat
- .section
- APIConfig
- .page
- Image
- Int
- UIImage
- Double
- Text
- HistoryItemDTO
- HTTPMethod
- String
- String
- FortuneTeller
- ReadingDraft
- Image
- LocalizedStringKey
- Reading
- String
- String
- UIImage
- Bool
- SegmentedSelector
- APIDate
- APIConfig
- HistoryRepository
- ReadingDraft
- Emissary
- OracleDTO
- Paginated

## God Nodes (most connected - your core abstractions)
1. `SwiftUI` - 77 edges
2. `Foundation` - 28 edges
3. `EmissaryFailure` - 26 edges
4. `CodingKeys` - 23 edges
5. `UserProfile` - 23 edges
6. `EmissaryRequest` - 22 edges
7. `CodingKeys` - 22 edges
8. `HistoryItem` - 20 edges
9. `CodingKeys` - 20 edges
10. `Emissary` - 19 edges

## Surprising Connections (you probably didn't know these)
- `ProfileView` --calls--> `UserProfile`  [INFERRED]
  OracleBrew/OracleBrew/Screens/Profile/ProfileView.swift → OracleBrew/OracleBrew/Backbone/UserProfile.swift
- `ReadingHistoryStore` --references--> `HistoryRepository`  [EXTRACTED]
  OracleBrew/OracleBrew/Backbone/ReadingHistory.swift → OracleBrew/OracleBrew/Backbone/Network/HistoryRepository.swift
- `HistoryReplayView` --references--> `HistoryItem`  [EXTRACTED]
  OracleBrew/OracleBrew/Screens/History/HistoryView.swift → OracleBrew/OracleBrew/Backbone/ReadingHistory.swift
- `HistoryView` --references--> `HistoryItem`  [EXTRACTED]
  OracleBrew/OracleBrew/Screens/History/HistoryView.swift → OracleBrew/OracleBrew/Backbone/ReadingHistory.swift
- `CatalogRepository` --references--> `Emissary`  [EXTRACTED]
  OracleBrew/OracleBrew/Backbone/Network/CatalogRepository.swift → OracleBrew/OracleBrew/Backbone/Network/Emissary.swift

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **** — docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_brew_reading_flow, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_drink_catalog, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_reading_engine, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_reading_result, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_fortune_teller_provider [INFERRED 0.80]
- **** — docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_mvvm_router, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_pathfinder, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_waypoint, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_atrium [INFERRED 0.80]

## Communities (181 total, 103 thin omitted)

### Community 0 - "Chat & Catalog DTOs"
Cohesion: 0.09
Nodes (22): Date, HistoryItem, ReadingDraft, Reading, String, Reading, ReadingEngine, ReadingSymbol (+14 more)

### Community 1 - "History & Navigation"
Cohesion: 0.16
Nodes (9): JSONDecoder, Emissary, Bool, Double, Error, Int, URLError, URLRequest (+1 more)

### Community 2 - "Country Catalog & API Config"
Cohesion: 0.42
Nodes (5): AIJobDTO, MainActor, ReadingService, Int, ReadingDTO

### Community 3 - "Reading Service & JSON"
Cohesion: 0.07
Nodes (27): AnyJSON, int, string, ReadingMapper, Encoder, String, Cadence, Screen (+19 more)

### Community 4 - "Chat Wire Models"
Cohesion: 0.11
Nodes (34): Decodable, Encodable, ChatDetailDTO, ChatJobDTO, ChatJobResultDTO, ChatListItemDTO, ChatMapper, ChatMessageDTO (+26 more)

### Community 5 - "Flow Layout & Bubble Shapes"
Cohesion: 0.15
Nodes (9): BubbleTail, Bool, CGRect, Path, Sparkle, SparklePair, CGRect, Path (+1 more)

### Community 6 - "Onboarding Conversation Flow"
Cohesion: 0.21
Nodes (8): CatalogStore, String, CatalogRepository, DailyFortuneDTO, Int, String, EmissaryRequest, T

### Community 7 - "App Root & Catalog Store"
Cohesion: 0.14
Nodes (14): Int, Zodiac, aquarius, aries, cancer, capricorn, gemini, leo (+6 more)

### Community 8 - "Cup Camera Capture"
Cohesion: 0.10
Nodes (21): CodingKeys, adviceHeadline, aiJobId, baseDescription, createdAt, cupImage, hasChat, icon (+13 more)

### Community 9 - "Profile Dropdown Controls"
Cohesion: 0.05
Nodes (30): Int, View, Pathfinder, Waypoint, profile, settings, Kind, failure (+22 more)

### Community 10 - "Oracle Entity API Contract"
Cohesion: 0.08
Nodes (23): OnboardingStep, Atrium, Bool, OnboardingLeavePopup, OnboardingLoadingView, OnboardingReadyView, OnboardingView, Int (+15 more)

### Community 11 - "Daily Fortune Catalog"
Cohesion: 0.20
Nodes (4): Foundation, FeatureGates, Features, Security

### Community 13 - "Oracle & Review DTOs"
Cohesion: 0.15
Nodes (16): CaseIterable, Codable, ChildrenStatus, have, none, planning, Employment, both (+8 more)

### Community 14 - "Intention: Topic & Horizon"
Cohesion: 0.09
Nodes (21): FortuneTeller, FortuneTellerRoster, Review, Bool, Double, Hasher, Int, String (+13 more)

### Community 15 - "Settings Row Components"
Cohesion: 0.15
Nodes (17): SettingsArrow, SettingsCard, SettingsDivider, SettingsIcon, SettingsRow, SettingsSectionLabel, SettingsToggleRow, Bool (+9 more)

### Community 16 - "User Profile Enums"
Cohesion: 0.16
Nodes (12): CodingKeys, adviceHeadline, createdAt, cupImage, drink, hasChat, id, oracle (+4 more)

### Community 17 - "Chat Session Store"
Cohesion: 0.09
Nodes (13): AVFoundation, LayoutDirection, CGFloat, UnitPoint, SettingsButton, StepDots, Int, ChatBackground (+5 more)

### Community 18 - "Emissary Request Building"
Cohesion: 0.29
Nodes (4): SessionGate, Any, String, TokenVault

### Community 19 - "Typography & Nav Chrome"
Cohesion: 0.29
Nodes (5): BrewModel, LocalizedStringKey, BrewView, CGFloat, LocalizedStringKey

### Community 20 - "Catalog Repository"
Cohesion: 0.29
Nodes (6): Drink, DrinkCatalog, Bool, LocalizedStringKey, String, UIImage

### Community 21 - "Reading Result Screen"
Cohesion: 0.20
Nodes (12): Data, HTTPMethod, delete, get, patch, post, MultipartPart, RequestBody (+4 more)

### Community 22 - "Splash Video Player"
Cohesion: 0.17
Nodes (10): HistoryItem, ReadingHistoryStore, Bool, Date, FortuneTeller, Hasher, Int, Reading (+2 more)

### Community 23 - "Remote Image Cache"
Cohesion: 0.40
Nodes (3): RandomCupView, String, Void

### Community 24 - "Network Send & Retry"
Cohesion: 0.16
Nodes (14): Data, EmissaryFailure, badRequest, decoding, encoding, notFound, notSubscribed, offline (+6 more)

### Community 25 - "Onboarding Chrome"
Cohesion: 0.22
Nodes (12): Label, DropdownChevron, DropdownOverlay, DropdownRow, ProfileFieldBox, Bool, CGFloat, Content (+4 more)

### Community 26 - "Zodiac Signs"
Cohesion: 0.50
Nodes (3): DrinkSelectionView, String, Void

### Community 28 - "Session Gate & Bootstrap"
Cohesion: 0.10
Nodes (25): Duration, Equatable, Line, OnboardingFlow, Stage, asking, ready, saving (+17 more)

### Community 29 - "Interests & Profile Chips"
Cohesion: 0.13
Nodes (14): AnyClass, AVCaptureSession, AVCaptureVideoPreviewLayer, AVPlayer, AVPlayerLayer, Context, CameraPreview, PreviewView (+6 more)

### Community 30 - "PhotoCaptor"
Cohesion: 0.22
Nodes (11): ContentMode, NSCache, NSString, DecodedImages, RemoteImage, ShimmerFill, Bool, CGFloat (+3 more)

### Community 31 - "Network Failure Types"
Cohesion: 0.33
Nodes (5): HTTPURLResponse, Error, String, URLRequest, WireLog

### Community 32 - "Profile Field Keys"
Cohesion: 0.17
Nodes (12): CodingKeys, children, country, dataConsent, dateOfBirth, employmentStatus, gender, name (+4 more)

### Community 33 - "Profile DTO Mapping"
Cohesion: 0.15
Nodes (12): A. New features (new product value), B. Polish & UX, C. Networking & reliability, Competitive insights (2026 research), D. Content & known tails (from this session), E0. What each new feature needs from the backend, E. Backend asks (from the entity docs), F. Repo hygiene (+4 more)

### Community 34 - "ReadingStep"
Cohesion: 0.33
Nodes (5): Paginated, Bool, Int, Item, String

### Community 35 - "Lettering Fonts"
Cohesion: 0.15
Nodes (12): 10. Deferred (NOT in v1.0), 11. Open questions (resolve at build), 1. What it is, 2. Project combo (fixed), 3. Platform & constraints (from base regimen), 4. Screen inventory, 5. Mock / data layer (Backbone), 6. Registration (+4 more)

### Community 36 - "Oracle Chat Screen"
Cohesion: 0.05
Nodes (44): CodingKey, CodingKeys, assistantMessageId, createdAt, hasUnreadFromOracle, id, job, lastMessage (+36 more)

### Community 37 - "Flow Buttons & Header"
Cohesion: 0.20
Nodes (9): Making the API key, Making the certificate and profile, Notes for later, Releasing OracleBrew, Running it, Secrets to create, The SPM signing script, Things it does not do (+1 more)

### Community 40 - "LegalTextView"
Cohesion: 0.25
Nodes (7): CardGradient, Spec, Bool, CGFloat, CGSize, Double, UnitPoint

### Community 42 - "Profile Repository & Store"
Cohesion: 0.27
Nodes (7): Layout, FlowLayout, CGFloat, CGRect, CGSize, ProposedViewSize, Subviews

### Community 43 - "FlowHeader"
Cohesion: 0.38
Nodes (5): Image, ReadingResultView, Void, Reading, ShareCardImage

### Community 44 - "Emissary Core"
Cohesion: 0.06
Nodes (37): ChatListItemDTO, ChatRepository, ChatThread, FortuneTeller, Hashable, Identifiable, ChatMessage, ChatSessionStore (+29 more)

### Community 48 - "Community 48"
Cohesion: 0.07
Nodes (28): AVCapturePhoto, AVCapturePhotoCaptureDelegate, AVCapturePhotoOutput, CGFloat, Error, NSObject, CupCamera, Phase (+20 more)

### Community 50 - "ReadingStep"
Cohesion: 0.23
Nodes (6): CGFloat, View, Color, Pigment, Double, UInt32

### Community 52 - "LayoutDirection"
Cohesion: 0.33
Nodes (6): Pigment, RatingLabel, StarRow, CGFloat, Double, Int

### Community 56 - "Community 56"
Cohesion: 0.33
Nodes (5): CupPhoto, CupPhotoBox, Bool, CGFloat, Content

### Community 57 - "FortuneTeller"
Cohesion: 0.18
Nodes (9): HistoryReplayView, HistoryView, Binding, Bool, CGFloat, Pathfinder, Reading, ReadingDraft (+1 more)

### Community 59 - "IntentionView"
Cohesion: 0.29
Nodes (6): Content, Fields, Gaps against the content we are shipping, Language, Oracle — what the iOS client expects, Reading language — resolved

### Community 61 - "CGFloat"
Cohesion: 0.32
Nodes (6): ProfileDTO, ProfileMapper, Bool, Int, String, T

### Community 69 - ".create"
Cohesion: 0.33
Nodes (5): Assets still to add (client-side, not backend), Drinks list — unchanged, Random cup — now client-side, What changed on the client, What the backend no longer needs

### Community 101 - "PagedList"
Cohesion: 0.35
Nodes (5): Item, PagedList, Bool, Int, ScreenPhase

### Community 102 - "Content"
Cohesion: 0.70
Nodes (4): add_provisioning_profile_variants(), exclude_spm_from_signing(), find_main_target_config_list(), find_release_config_variants()

### Community 103 - "UserProfile"
Cohesion: 0.29
Nodes (5): ProfileRepository, Bool, Set, UserProfile, UserProfileStore

### Community 104 - "Topic"
Cohesion: 0.29
Nodes (6): Double, EmissaryFailure, ReadingLoadingView, CGFloat, String, Void

### Community 105 - "Atrium"
Cohesion: 0.29
Nodes (7): RootTab, brew, chats, history, LocalizedStringKey, String, TabBar

### Community 106 - "Reading"
Cohesion: 0.19
Nodes (7): App, CoreText, Ignition, Lettering, CGFloat, Font, Scene

### Community 109 - "FlowHeader"
Cohesion: 0.32
Nodes (5): Calendar, FortuneCatalog, Date, Int, String

### Community 111 - "StepDots"
Cohesion: 0.22
Nodes (11): TellerCard, OnboardingBackground, OnboardingBubble, OnboardingHeader, OnboardingPanel, OnboardingTyping, Bool, Content (+3 more)

### Community 114 - "ThumbCard"
Cohesion: 0.43
Nodes (4): AnyEncodable, Encodable, Encoder, Void

### Community 116 - "Bool"
Cohesion: 0.18
Nodes (14): OnboardingBirthPicker, OnboardingContinue, OnboardingInterests, OnboardingOptions, OnboardingTextEntry, OnboardingWheel, Bool, Int (+6 more)

### Community 117 - "Int"
Cohesion: 0.40
Nodes (5): DrinkDTO, HistoryItemDTO, Bool, OracleDTO, TopicDTO

### Community 118 - "PhotoUploadView"
Cohesion: 0.25
Nodes (3): PhotoUploadView, PhotosPickerItem, PhotosUI

### Community 122 - "PagedList"
Cohesion: 0.33
Nodes (5): FlowCard, CGFloat, LocalizedStringKey, String, Void

### Community 123 - "FlowHeader"
Cohesion: 0.08
Nodes (20): Never, FlowHeader, PrimaryButton, SecondaryButton, Bool, Int, LocalizedStringKey, String (+12 more)

### Community 125 - "ScreenPhase"
Cohesion: 0.50
Nodes (3): ChatMessage, ChatBubble, Bool

### Community 128 - "AnyJSON"
Cohesion: 0.50
Nodes (3): Bool, String, TopicChip

### Community 131 - "TokenVault"
Cohesion: 0.29
Nodes (4): SettingsDestination, privacy, terms, SettingsView

### Community 138 - "UIKit"
Cohesion: 0.14
Nodes (13): Bool, Hasher, Int, LocalizedStringKey, TimeHorizon, days, month, year (+5 more)

### Community 139 - "EmptyState"
Cohesion: 0.40
Nodes (4): EmptyState, LocalizedStringKey, String, Void

### Community 144 - "Image"
Cohesion: 0.33
Nodes (4): AttributedString, ChatSummary, String, ChatThreadRow

### Community 145 - "LocalizedStringKey"
Cohesion: 0.40
Nodes (5): LegalCopy, LegalTextView, LocalizedStringKey, String, Void

### Community 146 - "String"
Cohesion: 0.22
Nodes (8): Emissary, HistoryRepository, Date, Int, Reading, String, PagedList, Paginated

### Community 157 - ".section"
Cohesion: 0.33
Nodes (4): Content, LocalizedStringKey, Void, TellerProfileView

### Community 159 - ".page"
Cohesion: 0.22
Nodes (7): ScreenPhase, content, loadFailure, loading, offline, Bool, Content

### Community 160 - "Image"
Cohesion: 0.28
Nodes (7): InterestChip, ProfileChip, ProfileSectionLabel, Bool, LocalizedStringKey, String, Void

### Community 165 - "HistoryItemDTO"
Cohesion: 0.33
Nodes (6): RelationshipStatus, complicated, divorced, inRelationship, married, single

### Community 180 - "Bool"
Cohesion: 0.10
Nodes (16): Binding, Bool, Content, Drink, LocalizedStringKey, BrewReadingFlow, FlowStub, ReadingStep (+8 more)

### Community 181 - "SegmentedSelector"
Cohesion: 0.50
Nodes (3): SegmentedSelector, Item, LocalizedStringKey

### Community 182 - "APIDate"
Cohesion: 0.24
Nodes (6): ISO8601DateFormatter, APIDate, Date, String, RelativeTime, String

### Community 184 - "APIConfig"
Cohesion: 0.50
Nodes (3): APIConfig, String, URL

## Knowledge Gaps
- **251 isolated node(s):** `day`, `month`, `year`, `relationship`, `country` (+246 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **103 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `SwiftUI` connect `Chat Session Store` to `Chat & Catalog DTOs`, `AnyJSON`, `Reading Service & JSON`, `Flow Layout & Bubble Shapes`, `Onboarding Conversation Flow`, `Profile Dropdown Controls`, `Oracle Entity API Contract`, `UIKit`, `EmptyState`, `Intention: Topic & Horizon`, `Settings Row Components`, `Image`, `LocalizedStringKey`, `Typography & Nav Chrome`, `Catalog Repository`, `Splash Video Player`, `Remote Image Cache`, `Onboarding Chrome`, `Zodiac Signs`, `Session Gate & Bootstrap`, `.section`, `PhotoCaptor`, `Image`, `LegalTextView`, `Profile Repository & Store`, `Emissary Core`, `Community 48`, `ReadingStep`, `LayoutDirection`, `SegmentedSelector`, `Bool`, `Community 56`, `FortuneTeller`, `Topic`, `Atrium`, `Reading`, `StepDots`, `Bool`, `PhotoUploadView`, `PagedList`, `FlowHeader`, `ScreenPhase`?**
  _High betweenness centrality (0.293) - this node is a cross-community bridge._
- **Why does `Foundation` connect `Daily Fortune Catalog` to `Chat & Catalog DTOs`, `ReadingStep`, `Chat Wire Models`, `Oracle Chat Screen`, `UserProfile`, `Profile Dropdown Controls`, `Emissary Core`, `FlowHeader`, `Intention: Topic & Horizon`, `Oracle & Review DTOs`, `User Profile Enums`, `Image`, `Reading Result Screen`, `APIDate`, `APIConfig`, `Session Gate & Bootstrap`, `.page`?**
  _High betweenness centrality (0.232) - this node is a cross-community bridge._
- **Why does `EmissaryFailure` connect `Network Send & Retry` to `History & Navigation`, `Country Catalog & API Config`, `Chat Wire Models`, `Onboarding Conversation Flow`, `Daily Fortune Catalog`, `Community 48`, `ThumbCard`, `.page`?**
  _High betweenness centrality (0.060) - this node is a cross-community bridge._
- **What connects `day`, `month`, `year` to the rest of the system?**
  _251 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Chat & Catalog DTOs` be split into smaller, more focused modules?**
  _Cohesion score 0.0907258064516129 - nodes in this community are weakly interconnected._
- **Should `Reading Service & JSON` be split into smaller, more focused modules?**
  _Cohesion score 0.06666666666666667 - nodes in this community are weakly interconnected._
- **Should `Chat Wire Models` be split into smaller, more focused modules?**
  _Cohesion score 0.10917874396135266 - nodes in this community are weakly interconnected._
# Graph Report - OracleBrew  (2026-07-31)

## Corpus Check
- 117 files · ~50,766 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1275 nodes · 1990 edges · 188 communities (92 shown, 96 thin omitted)
- Extraction: 97% EXTRACTED · 3% INFERRED · 0% AMBIGUOUS · INFERRED: 64 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `9440f723`
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
- Item
- Content
- UserProfile
- Topic
- Atrium
- Reading
- OracleContent
- Bool
- ReadingDraft
- Int
- StepDots
- Void
- Void
- Hashable
- LayoutDirection
- Bool
- Int
- LocalizedStringKey
- Set
- String
- Void
- PagedList
- FlowHeader
- Entry
- ScreenPhase
- Country
- Pathfinder
- AnyJSON
- ReadingStep
- PagedList
- TokenVault
- Bool
- Content
- LocalizedStringKey
- String
- Void
- TimeHorizon
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
- SegmentedSelector
- TopicChip
- TopicButton
- T
- URLRequest
- LocalizedStringKey
- CGFloat
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
- Phase
- String
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
- CatalogMapper
- Bool
- ReadingStep
- APIDate
- Country
- APIConfig
- HTTPMethod
- FortuneTellersView
- ShareCard

## God Nodes (most connected - your core abstractions)
1. `SwiftUI` - 77 edges
2. `Foundation` - 28 edges
3. `EmissaryFailure` - 26 edges
4. `CodingKeys` - 23 edges
5. `UserProfile` - 23 edges
6. `HistoryItem` - 22 edges
7. `EmissaryRequest` - 22 edges
8. `CodingKeys` - 22 edges
9. `CodingKeys` - 20 edges
10. `Zodiac` - 20 edges

## Surprising Connections (you probably didn't know these)
- `ProfileView` --calls--> `UserProfile`  [INFERRED]
  OracleBrew/OracleBrew/Screens/Profile/ProfileView.swift → OracleBrew/OracleBrew/Backbone/UserProfile.swift
- `ChatsView` --references--> `ChatSummary`  [EXTRACTED]
  OracleBrew/OracleBrew/Screens/Chats/ChatsView.swift → OracleBrew/OracleBrew/Backbone/ChatSessionStore.swift
- `ChatSessionStore` --references--> `PagedList`  [EXTRACTED]
  OracleBrew/OracleBrew/Backbone/ChatSessionStore.swift → OracleBrew/OracleBrew/Backbone/PagedList.swift
- `ReadingHistoryStore` --references--> `PagedList`  [EXTRACTED]
  OracleBrew/OracleBrew/Backbone/ReadingHistory.swift → OracleBrew/OracleBrew/Backbone/PagedList.swift
- `CatalogRepository` --references--> `Emissary`  [EXTRACTED]
  OracleBrew/OracleBrew/Backbone/Network/CatalogRepository.swift → OracleBrew/OracleBrew/Backbone/Network/Emissary.swift

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **** — docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_brew_reading_flow, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_drink_catalog, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_reading_engine, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_reading_result, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_fortune_teller_provider [INFERRED 0.80]
- **** — docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_mvvm_router, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_pathfinder, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_waypoint, docs_superpowers_specs_2026_07_14_oraclebrew_v1_design_atrium [INFERRED 0.80]

## Communities (188 total, 96 thin omitted)

### Community 0 - "Chat & Catalog DTOs"
Cohesion: 0.19
Nodes (12): Reading, ReadingEngine, ReadingSymbol, SeededGenerator, String, Entry, Bool, String (+4 more)

### Community 1 - "History & Navigation"
Cohesion: 0.20
Nodes (9): JSONDecoder, Emissary, Bool, Double, Error, Int, URLError, URLRequest (+1 more)

### Community 2 - "Country Catalog & API Config"
Cohesion: 0.33
Nodes (7): AIJobDTO, MainActor, ReadingService, Int, ReadingDraft, ReadingDTO, T

### Community 3 - "Reading Service & JSON"
Cohesion: 0.08
Nodes (23): OracleContent, OracleContentCatalog, Bool, Double, Int, String, Cadence, Screen (+15 more)

### Community 4 - "Chat Wire Models"
Cohesion: 0.09
Nodes (39): Decodable, Encodable, ChatDetailDTO, ChatJobDTO, ChatJobResultDTO, ChatListItemDTO, ChatMapper, ChatMessageDTO (+31 more)

### Community 5 - "Flow Layout & Bubble Shapes"
Cohesion: 0.15
Nodes (9): BubbleTail, Bool, CGRect, Path, Sparkle, SparklePair, CGRect, Path (+1 more)

### Community 6 - "Onboarding Conversation Flow"
Cohesion: 0.24
Nodes (4): CatalogStore, String, CatalogRepository, EmissaryRequest

### Community 7 - "App Root & Catalog Store"
Cohesion: 0.14
Nodes (14): Int, Zodiac, aquarius, aries, cancer, capricorn, gemini, leo (+6 more)

### Community 8 - "Cup Camera Capture"
Cohesion: 0.10
Nodes (20): CodingKeys, authorName, bio, createdAt, description, id, illustration, image (+12 more)

### Community 9 - "Profile Dropdown Controls"
Cohesion: 0.06
Nodes (37): Calendar, Label, FortuneCatalog, Date, Int, String, IntBox, ProfileBirthField (+29 more)

### Community 10 - "Oracle Entity API Contract"
Cohesion: 0.13
Nodes (13): OnboardingStep, Atrium, Bool, OnboardingLeavePopup, OnboardingLoadingView, OnboardingReadyView, OnboardingView, OnboardingChoice (+5 more)

### Community 11 - "Daily Fortune Catalog"
Cohesion: 0.15
Nodes (6): Foundation, FeatureGates, Features, RelativeTime, Date, String

### Community 13 - "Oracle & Review DTOs"
Cohesion: 0.15
Nodes (16): CaseIterable, Codable, ChildrenStatus, have, none, planning, Employment, both (+8 more)

### Community 14 - "Intention: Topic & Horizon"
Cohesion: 0.50
Nodes (3): LayoutDirection, CGFloat, UnitPoint

### Community 15 - "Settings Row Components"
Cohesion: 0.15
Nodes (17): SettingsArrow, SettingsCard, SettingsDivider, SettingsIcon, SettingsRow, SettingsSectionLabel, SettingsToggleRow, Bool (+9 more)

### Community 16 - "User Profile Enums"
Cohesion: 0.09
Nodes (24): DrinkDTO, CodingKeys, adviceHeadline, createdAt, cupImage, drink, hasChat, id (+16 more)

### Community 17 - "Chat Session Store"
Cohesion: 0.16
Nodes (7): AVFoundation, SettingsButton, StepDots, Int, ChatBackground, SwiftUI, UserNotifications

### Community 18 - "Emissary Request Building"
Cohesion: 0.21
Nodes (10): FortuneTeller, FortuneTellerRoster, Review, Bool, Double, Hasher, Int, String (+2 more)

### Community 19 - "Typography & Nav Chrome"
Cohesion: 0.29
Nodes (5): BrewModel, LocalizedStringKey, BrewView, CGFloat, LocalizedStringKey

### Community 20 - "Catalog Repository"
Cohesion: 0.13
Nodes (12): Drink, DrinkCatalog, Bool, LocalizedStringKey, String, UIImage, DrinkSelectionView, String (+4 more)

### Community 21 - "Reading Result Screen"
Cohesion: 0.23
Nodes (7): AVCapturePhoto, AVCapturePhotoCaptureDelegate, AVCapturePhotoOutput, NSObject, CupCamera, PhotoCaptor, UIImage

### Community 22 - "Splash Video Player"
Cohesion: 0.09
Nodes (20): HistoryRepository, HistoryItem, ReadingHistoryStore, Bool, Date, FortuneTeller, Hasher, Int (+12 more)

### Community 23 - "Remote Image Cache"
Cohesion: 0.14
Nodes (13): Bool, Hasher, Int, LocalizedStringKey, TimeHorizon, days, month, year (+5 more)

### Community 24 - "Network Send & Retry"
Cohesion: 0.16
Nodes (14): Data, EmissaryFailure, badRequest, decoding, encoding, notFound, notSubscribed, offline (+6 more)

### Community 25 - "Onboarding Chrome"
Cohesion: 0.29
Nodes (7): Kind, failure, offline, ScreenStateView, LocalizedStringKey, String, Void

### Community 26 - "Zodiac Signs"
Cohesion: 0.25
Nodes (3): PhotoUploadView, PhotosPickerItem, PhotosUI

### Community 28 - "Session Gate & Bootstrap"
Cohesion: 0.10
Nodes (25): Duration, Equatable, Line, OnboardingFlow, Stage, asking, ready, saving (+17 more)

### Community 29 - "Interests & Profile Chips"
Cohesion: 0.24
Nodes (7): AnyClass, AVCaptureSession, AVCaptureVideoPreviewLayer, Context, CameraPreview, PreviewView, UIViewRepresentable

### Community 30 - "PhotoCaptor"
Cohesion: 0.22
Nodes (11): ContentMode, NSCache, NSString, DecodedImages, RemoteImage, ShimmerFill, Bool, CGFloat (+3 more)

### Community 31 - "Network Failure Types"
Cohesion: 0.18
Nodes (8): ChatThread, FortuneTeller, OracleChatView, Bool, Void, TellerPeek, TypingBubble, ScrollViewProxy

### Community 32 - "Profile Field Keys"
Cohesion: 0.17
Nodes (12): CodingKeys, children, country, dataConsent, dateOfBirth, employmentStatus, gender, name (+4 more)

### Community 33 - "Profile DTO Mapping"
Cohesion: 0.15
Nodes (12): A. New features (new product value), B. Polish & UX, C. Networking & reliability, Competitive insights (2026 research), D. Content & known tails (from this session), E0. What each new feature needs from the backend, E. Backend asks (from the entity docs), F. Repo hygiene (+4 more)

### Community 34 - "ReadingStep"
Cohesion: 0.22
Nodes (8): Hashable, Identifiable, Interest, InterestCatalog, String, Waypoint, profile, settings

### Community 35 - "Lettering Fonts"
Cohesion: 0.15
Nodes (12): 10. Deferred (NOT in v1.0), 11. Open questions (resolve at build), 1. What it is, 2. Project combo (fixed), 3. Platform & constraints (from base regimen), 4. Screen inventory, 5. Mock / data layer (Backbone), 6. Registration (+4 more)

### Community 36 - "Oracle Chat Screen"
Cohesion: 0.10
Nodes (21): CodingKeys, adviceHeadline, aiJobId, baseDescription, createdAt, cupImage, hasChat, icon (+13 more)

### Community 37 - "Flow Buttons & Header"
Cohesion: 0.20
Nodes (9): Making the API key, Making the certificate and profile, Notes for later, Releasing OracleBrew, Running it, Secrets to create, The SPM signing script, Things it does not do (+1 more)

### Community 38 - "Topic & Teller Chips"
Cohesion: 0.43
Nodes (4): AnyEncodable, Encodable, Encoder, Void

### Community 40 - "LegalTextView"
Cohesion: 0.25
Nodes (7): CardGradient, Spec, Bool, CGFloat, CGSize, Double, UnitPoint

### Community 41 - "Palette & Brew Cards"
Cohesion: 0.11
Nodes (18): CodingKeys, assistantMessageId, createdAt, hasUnreadFromOracle, id, job, lastMessage, messages (+10 more)

### Community 42 - "Profile Repository & Store"
Cohesion: 0.27
Nodes (7): Layout, FlowLayout, CGFloat, CGRect, CGSize, ProposedViewSize, Subviews

### Community 43 - "FlowHeader"
Cohesion: 0.38
Nodes (5): Image, ReadingResultView, Void, Reading, ShareCardImage

### Community 44 - "Emissary Core"
Cohesion: 0.17
Nodes (14): ChatListItemDTO, ChatRepository, ChatMessage, ChatSessionStore, ChatSummary, ChatThread, Bool, Date (+6 more)

### Community 48 - "Community 48"
Cohesion: 0.14
Nodes (10): Int, LocalizedStringKey, Set, String, CGFloat, Image, LocalizedStringKey, String (+2 more)

### Community 49 - "Community 49"
Cohesion: 0.28
Nodes (7): AVPlayer, AVPlayerLayer, PlayerView, AnyClass, Context, VideoLayerView, UIView

### Community 52 - "LayoutDirection"
Cohesion: 0.33
Nodes (6): Pigment, RatingLabel, StarRow, CGFloat, Double, Int

### Community 56 - "Community 56"
Cohesion: 0.33
Nodes (5): CupPhoto, CupPhotoBox, Bool, CGFloat, Content

### Community 57 - "FortuneTeller"
Cohesion: 0.35
Nodes (5): Item, PagedList, Bool, Int, ScreenPhase

### Community 59 - "IntentionView"
Cohesion: 0.29
Nodes (6): Content, Fields, Gaps against the content we are shipping, Language, Oracle — what the iOS client expects, Reading language — resolved

### Community 61 - "CGFloat"
Cohesion: 0.32
Nodes (6): ProfileDTO, ProfileMapper, Bool, Int, String, T

### Community 69 - ".create"
Cohesion: 0.33
Nodes (5): Assets still to add (client-side, not backend), Drinks list — unchanged, Random cup — now client-side, What changed on the client, What the backend no longer needs

### Community 101 - "Item"
Cohesion: 0.33
Nodes (6): CodingKey, AuthResponse, CodingKeys, shareCode, token, String

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

### Community 109 - "ReadingDraft"
Cohesion: 0.40
Nodes (4): Color, Pigment, Double, UInt32

### Community 111 - "StepDots"
Cohesion: 0.25
Nodes (10): OnboardingBackground, OnboardingBubble, OnboardingHeader, OnboardingPanel, OnboardingTyping, Bool, Content, Double (+2 more)

### Community 114 - "Hashable"
Cohesion: 0.28
Nodes (6): ToastCapsule, View, ChatEntryStep, chat, OracleChatEntryFlow, Void

### Community 115 - "LayoutDirection"
Cohesion: 0.17
Nodes (10): Error, Failure, notPermitted, ShareCardError, encodingFailed, ShareCardImage, ShareCardRenderer, Transferable (+2 more)

### Community 116 - "Bool"
Cohesion: 0.18
Nodes (14): OnboardingBirthPicker, OnboardingContinue, OnboardingInterests, OnboardingOptions, OnboardingTextEntry, OnboardingWheel, Bool, Int (+6 more)

### Community 117 - "Int"
Cohesion: 0.18
Nodes (4): View, Pathfinder, SettingsView, Void

### Community 118 - "LocalizedStringKey"
Cohesion: 0.20
Nodes (7): ChatsView, Binding, Bool, CGFloat, Pathfinder, String, Void

### Community 119 - "Set"
Cohesion: 0.33
Nodes (6): RelationshipStatus, complicated, divorced, inRelationship, married, single

### Community 120 - "String"
Cohesion: 0.17
Nodes (9): LocalizedStringKey, Never, Void, Tidings, BrewReadingFlow, FlowStub, SplashView, Task (+1 more)

### Community 121 - "Void"
Cohesion: 0.33
Nodes (5): CGFloat, Drink, DrinkCard, CardOffsetKey, PreferenceKey

### Community 122 - "PagedList"
Cohesion: 0.33
Nodes (5): FlowCard, CGFloat, LocalizedStringKey, String, Void

### Community 123 - "FlowHeader"
Cohesion: 0.13
Nodes (14): FlowHeader, PrimaryButton, SecondaryButton, Bool, Int, LocalizedStringKey, String, Void (+6 more)

### Community 125 - "ScreenPhase"
Cohesion: 0.50
Nodes (3): ChatMessage, ChatBubble, Bool

### Community 126 - "Country"
Cohesion: 0.20
Nodes (7): Date, Int, ReadingDraft, Reading, String, TellerCard, TimeHorizon

### Community 127 - "Pathfinder"
Cohesion: 0.33
Nodes (5): HTTPURLResponse, Error, String, URLRequest, WireLog

### Community 128 - "AnyJSON"
Cohesion: 0.50
Nodes (3): Bool, String, TopicChip

### Community 131 - "TokenVault"
Cohesion: 0.23
Nodes (5): SessionGate, Any, String, TokenVault, Security

### Community 137 - "TimeHorizon"
Cohesion: 0.20
Nodes (7): AnyJSON, int, string, ReadingMapper, Encoder, String, ReadingResultDTO

### Community 138 - "UIKit"
Cohesion: 0.32
Nodes (7): Data, MultipartPart, RequestBody, json, multipart, none, String

### Community 139 - "EmptyState"
Cohesion: 0.40
Nodes (4): EmptyState, LocalizedStringKey, String, Void

### Community 144 - "Image"
Cohesion: 0.17
Nodes (8): AttributedString, ChatSummary, HistoryItem, String, ChatThreadRow, HistoryCard, Void, Topic

### Community 145 - "LocalizedStringKey"
Cohesion: 0.22
Nodes (8): LegalCopy, LegalTextView, LocalizedStringKey, String, Void, SettingsDestination, privacy, terms

### Community 149 - "SegmentedSelector"
Cohesion: 0.50
Nodes (3): SegmentedSelector, Item, LocalizedStringKey

### Community 157 - ".section"
Cohesion: 0.33
Nodes (4): Content, LocalizedStringKey, Void, TellerProfileView

### Community 159 - ".page"
Cohesion: 0.22
Nodes (7): ScreenPhase, content, loadFailure, loading, offline, Bool, Content

### Community 160 - "Image"
Cohesion: 0.28
Nodes (7): InterestChip, ProfileChip, ProfileSectionLabel, Bool, LocalizedStringKey, String, Void

### Community 167 - "Phase"
Cohesion: 0.40
Nodes (5): Phase, denied, idle, running, unavailable

### Community 179 - "CatalogMapper"
Cohesion: 0.32
Nodes (4): CatalogMapper, DailyFortuneDTO, Int, String

### Community 180 - "Bool"
Cohesion: 0.29
Nodes (4): Binding, Bool, Content, IntentionView

### Community 181 - "ReadingStep"
Cohesion: 0.29
Nodes (7): ReadingStep, chat, intention, loading, photo, result, tellers

### Community 182 - "APIDate"
Cohesion: 0.33
Nodes (4): ISO8601DateFormatter, APIDate, Date, String

### Community 183 - "Country"
Cohesion: 0.67
Nodes (3): Country, CountryCatalog, String

### Community 184 - "APIConfig"
Cohesion: 0.50
Nodes (3): APIConfig, String, URL

### Community 185 - "HTTPMethod"
Cohesion: 0.40
Nodes (5): HTTPMethod, delete, get, patch, post

### Community 186 - "FortuneTellersView"
Cohesion: 0.40
Nodes (4): FortuneTellersView, Int, LocalizedStringKey, Void

### Community 187 - "ShareCard"
Cohesion: 0.50
Nodes (3): ShareCard, String, UIImage

## Knowledge Gaps
- **251 isolated node(s):** `FeatureGates`, `UniformTypeIdentifiers`, `encodingFailed`, `id`, `role` (+246 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **96 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `SwiftUI` connect `Chat Session Store` to `AnyJSON`, `Chat & Catalog DTOs`, `Reading Service & JSON`, `Flow Layout & Bubble Shapes`, `Onboarding Conversation Flow`, `Profile Dropdown Controls`, `Oracle Entity API Contract`, `EmptyState`, `Intention: Topic & Horizon`, `Settings Row Components`, `Image`, `LocalizedStringKey`, `Emissary Request Building`, `Typography & Nav Chrome`, `Catalog Repository`, `SegmentedSelector`, `Splash Video Player`, `Remote Image Cache`, `Onboarding Chrome`, `Zodiac Signs`, `Session Gate & Bootstrap`, `.section`, `PhotoCaptor`, `Network Failure Types`, `Image`, `ReadingStep`, `LegalTextView`, `Profile Repository & Store`, `Community 48`, `ReadingStep`, `CatalogMapper`, `LayoutDirection`, `Bool`, `Community 56`, `FortuneTellersView`, `ShareCard`, `Topic`, `Atrium`, `Reading`, `ReadingDraft`, `StepDots`, `Hashable`, `LayoutDirection`, `Bool`, `Int`, `LocalizedStringKey`, `String`, `Void`, `PagedList`, `FlowHeader`, `ScreenPhase`, `Country`?**
  _High betweenness centrality (0.273) - this node is a cross-community bridge._
- **Why does `Foundation` connect `Daily Fortune Catalog` to `Chat & Catalog DTOs`, `ReadingStep`, `TokenVault`, `Chat Wire Models`, `Item`, `UserProfile`, `Profile Dropdown Controls`, `UIKit`, `Emissary Core`, `Oracle & Review DTOs`, `User Profile Enums`, `Image`, `Emissary Request Building`, `APIDate`, `Country`, `APIConfig`, `Session Gate & Bootstrap`, `.page`?**
  _High betweenness centrality (0.208) - this node is a cross-community bridge._
- **Why does `HistoryItem` connect `Splash Video Player` to `User Profile Enums`, `Void`, `ReadingStep`, `Image`?**
  _High betweenness centrality (0.047) - this node is a cross-community bridge._
- **What connects `FeatureGates`, `UniformTypeIdentifiers`, `encodingFailed` to the rest of the system?**
  _251 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Reading Service & JSON` be split into smaller, more focused modules?**
  _Cohesion score 0.08095238095238096 - nodes in this community are weakly interconnected._
- **Should `Chat Wire Models` be split into smaller, more focused modules?**
  _Cohesion score 0.08974358974358974 - nodes in this community are weakly interconnected._
- **Should `App Root & Catalog Store` be split into smaller, more focused modules?**
  _Cohesion score 0.14285714285714285 - nodes in this community are weakly interconnected._
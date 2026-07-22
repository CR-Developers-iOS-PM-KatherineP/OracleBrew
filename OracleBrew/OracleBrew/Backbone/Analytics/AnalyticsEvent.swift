import Foundation

/// Every event the app reports, named once here.
///
/// An enum rather than strings at call sites: a typo in a literal is a silent
/// hole in the funnel that only shows up as missing data weeks later. The
/// wire names are fixed by the team's event spec — rename a case freely, but
/// never a `name`, or the history behind it splits in two.
enum AnalyticsEvent {

    // MARK: Screens seen

    case splashShown
    /// Indexed by the onboarding page that became visible: 1, 2, 3…
    case onboardingStep(Int)
    case mainScreenShown
    case drinkSelectionShown
    case oracleListShown
    case oracleProfileShown
    case intentionShown
    case photoUploadShown
    case randomCupShown
    case readingLoadingShown
    case readingResultShown
    case chatShown
    case chatListShown
    case historyShown
    case profileShown
    case settingsShown
    case shareSheetShown

    // MARK: Onboarding

    case onboardingSkipped
    case onboardingFinished

    // MARK: The reading flow

    case drinkPicked
    case randomCupPicked
    case randomCupReshuffled
    case oraclePicked
    case topicPicked
    case horizonPicked
    case questionEntered
    case cupPhotoTaken
    case cupPhotoPickedFromLibrary
    case readingRequested
    case readingSucceeded
    case readingFailed

    // MARK: The reading result

    case readingSavedToLibrary

    // MARK: Chat

    case chatOpenedFromReading
    case chatOpenedFromList
    case chatStartedWithNewOracle
    case chatMessageSent
    case chatQuickPromptUsed
    case chatPromptsHidden
    case chatReturnedToReading

    // MARK: History

    case historyReadingOpened
    case historyChatOpened

    // MARK: Profile and settings

    case profileSaved
    case legalOpened
    case accountDeleted

    // MARK: Tracking permission

    /// Parameterised with the user's answer — see `Parameter.attStatus`.
    case trackingPromptAnswered

    /// The name that goes on the wire. Fixed by the event spec; do not edit.
    var name: String {
        switch self {
        case .splashShown: "splash_screen_view"
        case .onboardingStep(let index): "onboarding_step_\(index)"
        case .mainScreenShown: "main_screen_view"
        case .drinkSelectionShown: "drink_selection_view"
        case .oracleListShown: "oracle_list_view"
        case .oracleProfileShown: "oracle_profile_view"
        case .intentionShown: "intention_view"
        case .photoUploadShown: "photo_upload_view"
        case .randomCupShown: "random_cup_view"
        case .readingLoadingShown: "reading_loading_view"
        case .readingResultShown: "reading_result_view"
        case .chatShown: "chat_view"
        case .chatListShown: "chat_list_view"
        case .historyShown: "history_view"
        case .profileShown: "profile_view"
        case .settingsShown: "settings_view"
        case .shareSheetShown: "share_sheet_view"

        case .onboardingSkipped: "onboarding_skip"
        case .onboardingFinished: "onboarding_done"

        case .drinkPicked: "drink_select"
        case .randomCupPicked: "random_cup_select"
        case .randomCupReshuffled: "random_cup_reshuffle"
        case .oraclePicked: "oracle_select"
        case .topicPicked: "topic_select"
        case .horizonPicked: "horizon_select"
        case .questionEntered: "question_enter"
        case .cupPhotoTaken: "cup_photo_camera"
        case .cupPhotoPickedFromLibrary: "cup_photo_library"
        case .readingRequested: "reading_request"
        case .readingSucceeded: "reading_success"
        case .readingFailed: "reading_fail"

        case .readingSavedToLibrary: "reading_save"

        case .chatOpenedFromReading: "chat_open_from_reading"
        case .chatOpenedFromList: "chat_open_from_list"
        case .chatStartedWithNewOracle: "chat_start_new_oracle"
        case .chatMessageSent: "chat_message_send"
        case .chatQuickPromptUsed: "chat_prompt_use"
        case .chatPromptsHidden: "chat_prompts_hide"
        case .chatReturnedToReading: "chat_back_to_reading"

        case .historyReadingOpened: "history_reading_open"
        case .historyChatOpened: "history_chat_open"

        case .profileSaved: "profile_save"
        case .legalOpened: "legal_open"
        case .accountDeleted: "account_delete"

        case .trackingPromptAnswered: "att_answered"
        }
    }

    /// Parameter keys, so call sites don't spell them out either.
    enum Parameter {
        static let drink = "drink"
        static let oracle = "oracle"
        static let topic = "topic"
        static let horizon = "horizon"
        static let source = "source"
        static let attStatus = "status"
        static let reason = "reason"
    }
}

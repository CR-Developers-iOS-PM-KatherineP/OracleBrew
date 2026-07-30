import Foundation
import StoreKit
import SwiftyStoreKit

/// UserAcquisition — receipts and attribution, reported to the team's own
/// backend.
///
/// Not an `AnalyticsSink`, and that is deliberate: UA has no event API. It
/// carries purchases, the attribution payload the other SDKs supply, and the
/// refund consent. The facade holds it as this concrete type and never routes
/// `track` here.
///
/// `UserAcquisitionService` and its protocol are vendored sources, kept exactly
/// as the maintainer publishes them — this sink is the only place allowed to
/// know their shape.
final class UserAcquisitionSink {
    private var service: UserAcquisitionService?

    /// Held concretely rather than behind the protocol: `UserAcquisitionProtocol`
    /// isn't class-bound, so mutating `conversionInfo` through an existential
    /// wouldn't compile.
    private var isReady: Bool { service != nil }

    func start() {
        guard AnalyticsConfig.isUserAcquisitionReady else {
            Self.logSkip("api key / server url are still placeholders")
            return
        }
        service = UserAcquisitionService(
            apiKey: AnalyticsConfig.UserAcquisition.apiKey,
            serverUrl: AnalyticsConfig.UserAcquisition.serverUrl,
            sharedSecret: AnalyticsConfig.UserAcquisition.sharedSecret,
            appleReceiptValidator: .production
        )
    }

    // MARK: Attribution

    /// AppsFlyer's install payload. UA derives the acquisition source, campaign
    /// and date from it, so this should land before the first purchase report.
    func apply(appsFlyerData: [String: Any], appsFlyerID: String) {
        guard var info = service?.conversionInfo else { return }
        info.setAppsFlyerData(appsFlyerData)
        info.appsFlyerId = appsFlyerID
        service?.conversionInfo = info
    }

    func apply(appMetricaDeviceID: String) {
        service?.conversionInfo.appmetricaId = appMetricaDeviceID
    }

    func apply(facebookAnonymousID: String) {
        service?.conversionInfo.fbAnonymousId = facebookAnonymousID
    }

    // MARK: Purchases and consent

    /// `name` is ignored — UA ships the receipt itself, so the event name the
    /// other sinks report under has nothing to attach to here.
    func logPurchase(_ product: SKProduct) {
        guard let service else {
            Self.logSkip("purchase not reported — provider is off")
            return
        }
        Task { await service.logPurchase(of: product) }
    }

    /// Whether the user let us share purchase details with Apple for refunds.
    /// Sent either way: a refusal is an answer the backend needs too.
    func refund(consented: Bool) {
        guard let service else {
            Self.logSkip("consent not reported — provider is off")
            return
        }
        Task { await service.refund(consented: consented) }
    }

    private static func logSkip(_ reason: String) {
        #if DEBUG
        print("⚠️ [Tally] UserAcquisition skipped — \(reason)")
        #endif
    }
}

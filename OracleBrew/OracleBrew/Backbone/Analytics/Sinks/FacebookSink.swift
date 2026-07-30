import FBSDKCoreKit
import Foundation
import StoreKit

/// Facebook — events and revenue.
///
/// ATT is handled inside the SDK, so unlike AppsFlyer there is nothing to wait
/// for here.
final class FacebookSink: AnalyticsSink {
    func start() {
        guard AnalyticsConfig.isFacebookReady else {
            Self.logSkip("FacebookAppID is missing or still a placeholder in Info.plist")
            return
        }
        ApplicationDelegate.shared.initializeSDK()
    }

    func track(_ name: String, parameters: [String: String]) {
        // Facebook keys its parameters by its own wrapper type rather than by
        // String, so ours are lifted into it one by one.
        let keyed = Dictionary(
            uniqueKeysWithValues: parameters.map { (AppEvents.ParameterName($0.key), $0.value as Any) }
        )
        AppEvents.shared.logEvent(AppEvents.Name(name), parameters: keyed)
    }

    func logPurchase(_ product: SKProduct, name: String) {
        AppEvents.shared.logPurchase(
            amount: product.price.doubleValue,
            currency: product.priceLocale.currency?.identifier ?? ""
        )
    }

    /// Feeds UA's `conversionInfo.fbAnonymousId`. Read after `start()` — before
    /// the SDK is up it has nothing to give.
    var anonymousID: String { AppEvents.shared.anonymousID }

    private static func logSkip(_ reason: String) {
        #if DEBUG
        print("⚠️ [Tally] Facebook skipped — \(reason)")
        #endif
    }
}

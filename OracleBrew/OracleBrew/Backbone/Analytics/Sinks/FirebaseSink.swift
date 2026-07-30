import FirebaseAnalytics
import FirebaseCore
import Foundation
import StoreKit

/// Firebase Analytics.
final class FirebaseSink: AnalyticsSink {
    func start() {
        // configure() traps outright when the plist is absent, so this guard is
        // the difference between a provider being off and the app not launching.
        guard AnalyticsConfig.isFirebaseReady else {
            Self.logSkip("GoogleService-Info.plist is not in the bundle")
            return
        }
        FirebaseApp.configure()
    }

    func track(_ name: String, parameters: [String: String]) {
        Analytics.logEvent(Self.sanitized(name), parameters: parameters)
    }

    /// A plain event named by the caller rather than Firebase's standard
    /// `purchase`, to match how the rest of the stack reports a sale.
    func logPurchase(_ product: SKProduct, name: String) {
        Analytics.logEvent(Self.sanitized(name), parameters: [
            "price": product.price.stringValue,
            "currency": product.priceLocale.currency?.identifier ?? ""
        ])
    }

    /// Firebase rejects a name that isn't alphanumeric-and-underscore, doesn't
    /// start with a letter, or runs past 40 characters — and product ids are
    /// dotted, so purchase events would be dropped without this.
    private static func sanitized(_ name: String) -> String {
        var cleaned = String(name.map { $0.isLetter || $0.isNumber || $0 == "_" ? $0 : "_" })
        if let first = cleaned.first, !first.isLetter {
            cleaned = "e_" + cleaned
        }
        return String(cleaned.prefix(40))
    }

    private static func logSkip(_ reason: String) {
        #if DEBUG
        print("⚠️ [Tally] Firebase skipped — \(reason)")
        #endif
    }
}

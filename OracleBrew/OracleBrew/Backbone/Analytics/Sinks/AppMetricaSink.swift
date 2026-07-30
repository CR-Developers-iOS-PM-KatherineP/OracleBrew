import AppMetricaCore
import Foundation
import StoreKit

/// AppMetrica (Yandex) — events and revenue.
final class AppMetricaSink: AnalyticsSink {
    func start() {
        guard AnalyticsConfig.isAppMetricaReady else {
            Self.logSkip("api key is still a placeholder")
            return
        }
        guard let configuration = AppMetricaConfiguration(apiKey: AnalyticsConfig.Keys.appMetricaAPIKey) else {
            Self.logSkip("api key is not a valid AppMetrica key")
            return
        }
        AppMetrica.activate(with: configuration)
    }

    func track(_ name: String, parameters: [String: String]) {
        AppMetrica.reportEvent(name: name, parameters: parameters, onFailure: nil)
    }

    /// Revenue goes through the revenue API rather than a plain event, so it
    /// lands in AppMetrica's own money reports instead of just the event stream.
    func logPurchase(_ product: SKProduct, name: String) {
        let revenue = MutableRevenueInfo(
            priceDecimal: product.price,
            currency: product.priceLocale.currency?.identifier ?? ""
        )
        revenue.productID = product.productIdentifier
        revenue.quantity = 1
        AppMetrica.reportRevenue(revenue, onFailure: nil)
    }

    var deviceID: String { AppMetrica.deviceID ?? "" }

    private static func logSkip(_ reason: String) {
        #if DEBUG
        print("⚠️ [Tally] AppMetrica skipped — \(reason)")
        #endif
    }
}

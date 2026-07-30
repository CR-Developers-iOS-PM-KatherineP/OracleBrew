import Foundation
import StoreKit

/// One analytics provider, adapted to the facade.
///
/// Deliberately without default implementations. A default turns a signature
/// drift — a sink still declaring an old method after the protocol moved on —
/// into a silent no-op, and a provider that quietly stops reporting is the
/// worst failure this layer has. Without them the compiler catches it.
///
/// Only the operations every provider supports live here. Anything one SDK alone
/// offers — AppsFlyer's uninstall measurement, UserAcquisition's receipt upload —
/// is a concrete method on that one sink, reached through its concrete type, so
/// the others don't carry empty stubs for a feature they don't have.
protocol AnalyticsSink {
    /// Bring the SDK up. Must check its own config first and skip — never crash —
    /// when credentials are missing. See `AnalyticsConfig`'s readiness flags.
    func start()
    func track(_ name: String, parameters: [String: String])
    /// The event name comes from the call site, so the same purchase can be
    /// reported under whatever name the product spec asks for. Price and
    /// currency are read off the product.
    func logPurchase(_ product: SKProduct, name: String)
}

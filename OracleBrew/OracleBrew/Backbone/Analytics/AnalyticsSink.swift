import Foundation

/// One analytics provider, adapted to the facade.
///
/// Deliberately without default implementations. A default turns a signature
/// drift — a sink still declaring an old method after the protocol moved on —
/// into a silent no-op, and a provider that quietly stops reporting is the
/// worst failure this layer has. Without them the compiler catches it.
protocol AnalyticsSink {
    /// Bring the SDK up. Must check its own config first and skip (never crash)
    /// when keys are missing — see `AnalyticsConfig.isFilled`.
    func start()
    func track(_ name: String, parameters: [String: String])
}

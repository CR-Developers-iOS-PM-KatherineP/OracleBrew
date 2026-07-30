# Analytics

Not part of 1.0. This lives on `feat/analytics` until there is a paywall for it
to report on.

`Tally` is the only thing the app talks to. Screens and services call `track`;
which SDKs are up, and which are off for want of a key, is settled inside it.

```
Backbone/Analytics/
  Tally.swift               the facade — fan-out, purchases, consent
  AnalyticsEvent.swift      every event name, once
  AnalyticsSink.swift       what a provider must implement
  AnalyticsConfig.swift     switches, credentials, readiness
  RefundConsent.swift       the consent question and its one answer
  Sinks/                    AppsFlyer · AppMetrica · Facebook · Firebase · UserAcquisition
  UserAcquisition/          vendored sources — never edit these
```

## Turning a provider on

Every credential in `AnalyticsConfig` is still the placeholder it shipped as, so
**every provider is currently off** and says so once at launch:

```
⚠️ [Tally] AppsFlyer skipped — dev key / app id are still placeholders
⚠️ [Tally] AppMetrica skipped — api key is still a placeholder
⚠️ [Tally] Facebook skipped — FacebookAppID is missing or still a placeholder in Info.plist
⚠️ [Tally] Firebase skipped — GoogleService-Info.plist is not in the bundle
⚠️ [Tally] UserAcquisition skipped — api key / server url are still placeholders
📊 [Tally] start — providers: appsFlyer, appMetrica, facebook, firebase, userAcquisition
```

That is the intended state of the branch, not a fault. Each sink checks itself
before it initialises, so a half-configured build runs normally with that one
provider quiet.

| Provider | What it needs |
| --- | --- |
| AppsFlyer | `Keys.appsFlyerDevKey`, `Keys.appsFlyerAppID` |
| AppMetrica | `Keys.appMetricaAPIKey` |
| Facebook | `Keys.facebookAppID` **and** `FacebookAppID` + `FacebookClientToken` in `OracleBrew/Info.plist`, plus the `fb<appid>` URL scheme |
| Firebase | `GoogleService-Info.plist` added to the app target — no key of ours |
| UserAcquisition | `UserAcquisition.apiKey`, `.serverUrl`, `.sharedSecret` |

`enabledProviders` is empty, which means all of them. Narrow it to run one SDK
in isolation.

### Why the placeholder is passed in

`isFilled(_:placeholder:)` compares a credential against the literal it shipped
as. The obvious shortcut — decide from the value's shape, "a real key wouldn't be
all caps with underscores" — quietly breaks on real credentials: a Facebook App ID
is all digits, equals its own uppercased form, and would be judged a placeholder
forever. That is why `Shipped` exists alongside `Keys`.

## What is not wired, and why

- **Purchases.** `Tally.logPurchase(_:name:)` and `RefundConsent.askAfterPurchase()`
  are written and reachable, and nothing calls them: the app has no purchases
  (`Features.paywall` is off). When a purchase service lands, both are called from
  its **single success path** — never from a screen, or two paywalls will
  double-report. The event name is fixed: `AnalyticsEvent.Purchase.subscriptionDone`
  (`subscription_done`) for every completion, whatever the plan or surface.
- **Uninstall measurement.** `Tally.registerUninstall(deviceToken:)` exists and
  AppsFlyer implements it, but nothing feeds it a token: the app has no
  `AppDelegate` and does not register for remote notifications
  (`Features.notifications` is off). Adding an
  `@UIApplicationDelegateAdaptor` purely to reach a method that can't fire yet
  would be dead weight, so it waits for push to be real.
- **`NSPrivacyTrackingDomains`** is empty deliberately. Apple wants the endpoints
  only for domains reached *before* the user allows tracking, and every sink here
  starts behind the ATT answer. Fill it in if a provider is ever started ahead of
  that.

## Refund consent

Asked once after a purchase succeeds, and reachable from Settings afterwards.
Both entry points drive the one `RefundConsent`, so the alert can never hold two
versions of the truth.

- The alert is applied at the root, in `Atrium`, next to the toast layer — it is
  raised while the paywall that triggered it is dismissing, and an alert owned by
  that screen would go down with it.
- Delayed ~600 ms for the same reason.
- Either answer is reported. A refusal is an answer the backend needs; silence and
  "no" are not the same thing.
- The Settings row appears only once the question has been asked. Before the first
  purchase it would offer to manage consent about something that never happened.
- This is **not** the same thing as the `settings.dataConsent` toggle, which is a
  broader switch hidden behind `Features.dataConsent`. One is about sharing purchase
  details with Apple for refunds; the other is not. Don't merge them.

## Deviations from the ios-kit skill

- **AppsFlyer ATT ordering.** The skill says to call
  `waitForATTUserAuthorization(timeoutInterval:)` before `start()`. AppsFlyer 7.x
  deprecated it — "the SDK no longer manages ATT timing internally" — and its
  header states plainly that ATT is *not* a session-readiness condition. So the
  sink registers a `registerSessionReadyListener` block, collects the ATT answer
  inside it via `Beacon`, and starts the session only then. Keeping the deprecated
  call would have compiled and attributed installs without the IDFA. The skill's
  own rule for a major upgrade — rework the implementation to the new API — is what
  this follows.
- **`start()` location.** The skill puts it in
  `application:didFinishLaunchingWithOptions:`. There is no `AppDelegate` here;
  `Ignition.init()` is the equivalent moment for a SwiftUI app, and that is where
  it already was.

## Event names

Base-event names are drawn one-per-pool from the skill's list and copied verbatim:
`splash_screen_view`, `onboarding_step_<n>`, `main_screen_view`. **Never rename a
wire name** — the history behind it splits in two. Swift cases can be renamed
freely.

Screens report themselves on becoming visible; actions that a service performs
report from the service. `BrewReadingFlow` and `OracleChatEntryFlow` carry no
events of their own — they are step coordinators, and each destination reports
itself. `LegalTextView` is covered by `legal_open` at the tap that opens it,
carrying `source: privacy | terms`, rather than a second event on appear.

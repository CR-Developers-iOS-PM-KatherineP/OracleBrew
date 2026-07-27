# OracleBrew — improvements & roadmap

Master list of everything worth doing, before picking an order. Grouped by kind,
with rough effort (S/M/L) and a note on why. Nothing here is committed as a plan
yet — this is the backlog to prioritize from.

Effort: **S** ≈ hours · **M** ≈ a day or two · **L** ≈ multi-day / needs backend.

---

## Competitive insights (2026 research)

Segments surveyed: coffee-cup readers (CoffeeTells, Fincan, Kaave, Tasseography
AI), AI astrology (Co-Star, The Pattern, Sanctuary, Nebula), tarot apps.
What the market shows, and what it means for us:

- **Multi-modality is the winning shape.** The closest competitor, CoffeeTells,
  starts with a coffee-cup reading and then offers **tarot, astrology and
  numerology** plus **follow-up chat** — exactly the "generalize the reading
  engine, add modalities" direction. This is the strongest strategic
  validation for leading with Tarot.
- **Journal / history is table-stakes-plus.** Fincan ships a Journal (search,
  filter), a **Calendar** of past readings, a **Memory Capsule** (notes,
  photos, location) and **50 badges**. Our History tab is thin by comparison.
- **Follow-up questions are a monetization unit.** Both CoffeeTells and Fincan
  gate chat depth — Fincan gives premium users "3 follow-up questions per
  reading." We already have oracle chat; depth is a natural paywall.
- **Daily ritual + gentle push is the universal retention driver** across
  astrology and tarot apps (streaks, daily card, "quiet, never pushy"
  notifications). Validates the Daily Ritual direction.
- **Compatibility is the top monetized hook.** The Pattern's whole business is
  relationship analysis; Co-Star gates compatibility behind Plus. Validates the
  Compatibility direction as a paywall feature, not just a nice-to-have.
- **Model = free daily limit + subscription + credits.** Fincan: 3 free
  readings/day, subscription for unlimited + follow-ups + ad-free, plus "Bean"
  credits for follow-ups/cosmetics. A blueprint for our monetization later.
- **Three monetization shapes all work in this exact niche** (verified):
  - *Subscription* — CoffeeTells uses a plain auto-renewing iOS subscription,
    no credits, no per-reading purchase.
  - *Pay-per-reading* — Fenjan AI charges **$1.99 one-time per premium
    reading**. Viable without any subscription at all.
  - *Gate by depth, not by count* — Fenjan's free tier gives "a short
    interpretation ... basic analysis"; premium unlocks "deeper AI
    interpretation, longer reading". Cheapest paywall for us to implement: the
    reading already has distinct parts (narrative / symbols / advice), so a
    free tier can ship a short version and premium the full one.
- **Reading history is pitched as the retention hook, not a utility.** Read My
  Cup frames it as a vault: "Every reading is stored in your personal vault.
  Track patterns and insights that emerge over time." Ours is a plain list.

Additional competitors in this niche worth watching: Read My Cup, Fenjan AI,
Falita, Faladdin, Tarotoo. (Leads seen but *not* verified, so treat as
unconfirmed: Kaave reportedly runs named fortune-teller personas with domain
specialisation — the closest thing to our 15 oracles — and a credit model;
Faladdin reportedly runs ad-supported; Nebula reportedly A/B tests paywalls
continuously.)
- **Where we can differentiate:** rich multi-oracle *personas* (most rivals have
  one generic AI voice), chat continuity tied to a specific oracle, a genuinely
  underused profile (zodiac + birth + relationship + employment) to personalize,
  and coffee-reading heritage done well with real localization incl. Arabic.

## A. New features (new product value)

The three chosen directions plus ideas surfaced by the research. Shared idea:
**generalize the "reading" into modalities** so tarot, palm, natal all reuse the
oracle pick, intention, result screen and chat. ✅ = validated by competitors.

| Feature | Effort | Notes |
|---|---|---|
| **Tarot reading** (flagship) ✅ | M–L | 3-card spread (past/present/future), 22 Major Arcana, read by a chosen oracle. Reuses oracle pick + intention + `ReadingResultView` via a `modality` flag. Only new screen: card draw. New: `TarotDeck` catalog (localized), 22 card assets + a back, backend tarot-analyze endpoint. |
| **Daily ritual** ✅ | M | Personalized daily card/horoscope from the profile (zodiac + birth data already collected) + moon phase. Home surface + push. Turns one-off into a habit. Needs a daily-content endpoint. |
| **Relationship / compatibility** ✅ | M–L | Reading about another person / compatibility from two profiles. Proven paywall hook (The Pattern, Co-Star). Needs a second-subject input and a reading variant. |
| **Numerology** ✅ | S–M | Cheapest modality to add: pure compute from birth data we already collect — no photo, no new input. CoffeeTells pairs it with coffee. Good second modality after tarot. |
| **Spiritual Journal** (enrich History) ✅ | M | Calendar of past readings, per-reading notes, search/filter, "patterns over time." Fincan's Journal/Calendar/Memory Capsule is a retention driver; ours is thin. |
| **Symbol Library** | S–M | Browsable dictionary of the reading symbols (we have ~68; Fincan touts 250+). Educational, gives a reason to browse between readings. |
| **Badges / achievements** | M | Gamified retention (Fincan ships 50). Streaks, "first reading", "7-day ritual". |
| Follow-up questions as gated depth ✅ | S | Monetization mechanic on the chat we already have (Fincan: 3/reading premium). |
| **Paywall v1 — gate reading depth** ✅ | M | Verified as the cheapest working paywall in this niche (Fenjan: free = short interpretation, premium = deeper + longer). Our reading already splits into narrative / symbols / advice, so a free tier can ship the short form. Pick one of: subscription (CoffeeTells), $1.99 per premium reading (Fenjan), or both. Needs `ios-kit:setup-subscriptions`. |
| Social feed / add friends / share ✅ | L | Bigger bet — Fincan social feed, Co-Star friend-add virality. Defer. |
| Live human psychics | L | Sanctuary/Nebula per-minute marketplace. Out of scope for now. |
| Future modalities (palm / natal / dream) | L each | Slot into the same generalized engine once tarot proves the pattern. |

**Recommended feature order:** Tarot → Numerology (cheap second modality proving
the engine) → Daily ritual → Spiritual Journal → Compatibility.

---

## B. Polish & UX

| # | Item | Effort | State |
|---|------|--------|-------|
| B1 | **Haptics** on key events (card/cup drawn, reading ready, error) | S | None today — via ios-kit house-kit |
| B2 | **Rate-us** after positive events (first completed reading, onboarding done) | S | No StoreKit yet — `requestReview` |
| B3 | Loader while picking from gallery | S | `loadPicked` shows nothing during decode |
| B4 | Unified error style — toast for non-full-screen errors | M | Partial: full-screen `ScreenStateView` + alerts only |
| B5 | **Accessibility labels** — several images/SF Symbols read as asset names to VoiceOver (`gearshape`, `IconSend`, `Ball`, `arrow.backward`) | S–M | Found during simulator verification |

---

## C. Networking & reliability

| # | Item | Effort | State |
|---|------|--------|-------|
| C1 | Unified request **timeout** (`timeoutIntervalForRequest = 30`) | S | `Emissary` sets none → URLSession default 60s |
| C2 | **Retry with backoff** for transient GETs | S–M | Only a single retry on a dead keep-alive connection today |
| C3 | Logger service instead of `print` | S | Only 3 `print` calls, but no logging service |
| C4 | Global offline toast (optional) | S | Offline already handled inline per-screen (`ScreenStateView`) |

---

## R. Refactoring (from a code audit, 2026-07-27)

Codebase is healthy overall — 98 Swift files, ~9,050 lines, largest file 455
lines, no monster files. These are the real duplication/boundary issues found:

| # | Item | Effort | Evidence |
|---|------|--------|----------|
| R1 | **Extract card chrome into one modifier.** The design's card treatment (rounded fill + `strokeBorder(Color.white.opacity(0.15))`) is hand-written **10 times across 7 files**. A `.cardChrome(radius:)` in `Kit` removes the repetition and makes a design change one edit instead of ten. | S | `FlowChrome`, `DrinkCard`, `ReadingResultView`, `SymbolChip`, `ThumbCard`, `PhotoUploadView`, `RandomCupView` |
| R2 | **Move stray colours into `Pigment`.** **52 hardcoded `Color(hex: 0x…)` across 19 files** outside the palette. Design tokens leaking into views means a palette tweak has to be hunted down by grep. | S–M | e.g. `TellerCard`, `ChatBubble`, `HistoryCard`, `ReviewCard`, `IntentionView` |
| R3 | **One shared cup-photo box.** The two photo screens implement the *same* box two different ways: `RandomCupView` now uses the correct fixed-aspect `Color.clear` container, `PhotoUploadView` still uses the old `minHeight: 220 / maxHeight:` pattern that caused the overflow bug. Extracting a `CupPhotoBox` component fixes **D2** and removes the duplication in one go. | S | `PhotoUploadView:115` vs `RandomCupView:59` |
| R4 | **Share the profile-field components.** `ProfileView` (455 lines, the largest file) and `OnboardingView` (327) both render the same profile enums — Identity, RelationshipStatus, Employment, ChildrenStatus — in their own code. Shared field components shrink the two biggest views and keep them in sync. | M | Both files list the same field kinds |
| R5 | **Unify the store loading pattern.** Four stores (`CatalogStore`, `ChatSessionStore`, `ReadingHistoryStore`, `UserProfileStore`) each hand-roll their own loading/phase state. A small shared "loadable phase" helper would make them consistent — related to G4. | M | 2–8 state/phase declarations each |

R1 and R3 are the best value: both are small, and R3 also closes a known bug.

## D. Content & known tails (from this session)

| # | Item | Effort | State |
|---|------|--------|-------|
| D1 | **3 missing cup-photo sets** — espresso, hot chocolate, herbal brew (fall back to `SampleCup` until added) | S | Waiting on art; drop into `Assets.xcassets/Cups/` + list in `DrinkCatalog` |
| D2 | `PhotoUploadView` photo box has the **same latent aspect/overflow** pattern the random-cup screen had | S | Fixed by **R3** (extract one shared `CupPhotoBox`) rather than patching it twice |
| D3 | 2 missing symbol icons — `SymbolCompass`, `SymbolSpiralPath` (in backend, absent from design) | S | Add assets or accept text-only chip |
| D4 | Analytics wiring (currently on a separate branch) | M | Merge/finish when ready |

---

## E0. What each new feature needs from the backend

Useful starting facts (checked in code): **`/access/`already exists** (200 =
subscribed, 403 = not) so an entitlement check is in place; **`/daily-fortune/`
already exists** as an endpoint (the client currently prefers its bundled copy);
there is **no push infrastructure** — no APNs registration, no device token, only
a local notification-settings read in Settings.

| Feature | Backend needed? | What exactly |
|---|---|---|
| **Numerology** | **No** | Life-path style numbers are deterministic arithmetic on the birth data we already collect; the meanings ship as bundled localized copy, like `FortuneCatalog`/`SymbolCatalog`. Fully client-side. |
| **Symbol Library** | **No** | `SymbolCatalog` (68 entries) is already bundled. Pure browse UI. |
| **Spiritual Journal** | **Mostly no** | Calendar + patterns render from the existing `/history/`. Per-reading notes can live locally (SwiftData/`@AppStorage`). Only *deleting* a reading needs a backend endpoint (G2). |
| **Daily ritual** | **Optional** | `/daily-fortune/` exists; personalizing it by zodiac/profile would need backend work, but a bundled + profile-driven client version ships without it. Reminders can be **local** notifications (no APNs). Remote push *would* need backend + APNs. |
| **Tarot** | **Yes — one endpoint** | Card *drawing* is client-side (honest local shuffle). The *interpretation* must come from AI server-side, like the cup reading: a tarot analyze endpoint mirroring `readings/{id}/analyze/`, taking the 3 drawn cards + positions + oracle + topic/question + language, returning the same shape (narrative / per-card meaning / advice). |
| **Compatibility** | **Yes** | A reading variant that accepts a second subject (partner's birth data or a named person) and returns a compatibility reading. |
| **Paywall (depth gating)** | **Partly** | `/access/` already answers "is this user subscribed". Cleanest is for the backend to return the short vs full reading based on entitlement, so the full text is never shipped to a non-subscriber; client-side truncation is a weaker fallback. Plus StoreKit work on our side. |

**Takeaway:** Numerology, Symbol Library and Journal can ship **without touching
the backend at all** — good candidates while the backend dev is busy. Tarot is
the only flagship that hard-blocks on one new endpoint, so that ask should go out
early.

## E. Backend asks (from the entity docs)

| # | Item | Owner |
|---|------|-------|
| E1 | Create the 15 oracles with our slugs so bundled content/portraits/prompts activate (`docs/oracle-entity.md`) | backend |
| E2 | Serve `reviews_count` / `sessions_count` server-side to match the shipped content | backend |
| E3 | Send the 7 exact drink slugs; retire cup generation / `random_cup_id` / `drinks/random` — random cup is client-side now (`docs/drink-entity.md`) | backend |
| E4 | For tarot: a tarot-analyze endpoint (mirrors reading analyze) | backend, when tarot is scheduled |

---

## F. Repo hygiene

| # | Item | Effort |
|---|------|--------|
| F1 | `.gitignore` the dated graphify snapshots (`graphify-out/2026-07-*`) — they're auto-backups, ~MB each | S |
| F2 | Decide on `loc-work/` — temp translation fragments; delete after merge per convention | S |

---

## G. Marginal / later

- SHA cache of the cup photo (G1) — readings are intentional one-offs; low value.
- Delete a reading from History (G2) — needs a backend delete endpoint.
- Structured-concurrency tidy (G3) — already async/await + @MainActor; minor.
- Unified storage service (G4) — Keychain / @AppStorage / stores coexist; moderate.

---

## Suggested first pass

Two cheap, high-signal batches before the first big feature:

1. **Polish v1** (all S): C1 timeout, B1 haptics, B2 rate-us, B3 gallery loader,
   R1 card-chrome modifier, R3 shared photo box (closes D2), F1/F2 repo hygiene.
   Half a day, visible quality lift plus one bug closed.
2. **Tarot** as the first new-value feature (its own spec → plan).

Everything else slots in after, by the table above.

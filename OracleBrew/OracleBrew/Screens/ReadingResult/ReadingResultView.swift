import SwiftUI

struct ReadingResultView: View {
    @Environment(ReadingDraft.self) private var draft
    /// Pre-computed reading to replay verbatim (History tab resume). When nil,
    /// the one the Loading step fetched from the API (`draft.reading`) is shown.
    var existingReading: Reading? = nil
    let onAskOracle: () -> Void
    let onClose: () -> Void

    @State private var reading: Reading?
    /// Rendered once when the reading lands — ImageRenderer is too heavy to run
    /// on every body pass.
    @State private var shareCard: ShareCardImage?

    var body: some View {
        ZStack(alignment: .top) {
            Pigment.background.ignoresSafeArea()

            VStack(spacing: 0) {
                header
                if let reading {
                    ScrollView(showsIndicators: false) {
                        content(reading)
                            .padding(.top, 20)
                            .padding(.bottom, 12)
                    }
                    // Only the oracle button is pinned, per the design. Share and
                    // Save live at the end of the scroll content, so they come
                    // into view once the reading has been read — see `content`.
                    //
                    // safeAreaInset reserves exactly its own height as extra
                    // scroll-content inset, so nothing ever peeks out below the
                    // button row — no magic-number bottom padding to guess at.
                    .safeAreaInset(edge: .bottom) {
                        askOracleButton
                            .padding(.top, 12)
                            .padding(.bottom, 8)
                            .background(Pigment.background.ignoresSafeArea(edges: .bottom))
                    }
                } else {
                    // No reading to show. Closing is the only way on, since
                    // there is nothing here to retry — the request that failed
                    // was made a screen ago.
                    ScreenStateView(kind: .failure, retry: onClose)
                }
            }
            .padding(.horizontal, 20)
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            guard reading == nil else { return }
            // existingReading = a History replay; draft.reading = the one the
            // Loading step fetched from the API. There is deliberately no third
            // option: a locally invented reading is indistinguishable from a
            // real one, so a failure has to look like a failure.
            guard let result = existingReading ?? draft.reading else { return }
            reading = result
            if let image = ShareCardRenderer.render(photo: draft.photo, advice: result.advice,
                                                    timeframe: result.timeframe) {
                shareCard = ShareCardImage(image: image)
            }
        }
    }

    private var header: some View {
        ZStack {
            Text("result.title")
                .font(Lettering.displayMedium(24))
                .foregroundStyle(Pigment.cream)
            HStack {
                Spacer()
                Button(action: onClose) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Pigment.cream)
                        .frame(width: Cadence.tapTarget, height: Cadence.tapTarget)
                        .background(Circle().fill(Pigment.surface))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 4)
    }

    @ViewBuilder
    private func content(_ reading: Reading) -> some View {
        VStack(spacing: 24) {
            HStack(spacing: 9) {
                ThumbCard(
                    // The cup the oracle actually read — the server's circular
                    // crop, identical here and in a History replay. The picked
                    // photo and the sample art are fallbacks, in that order.
                    imageURL: draft.cupImageURL,
                    imageInset: 14,
                    fallback: cupImage,
                    caption: "result.your_cup",
                    value: draft.drink.map { Text($0.name) } ?? Text("")
                )
                ThumbCard(
                    imageURL: draft.teller?.portraitURL,
                    fallback: draft.teller.map { Image($0.portrait) } ?? Image("SampleCupCard"),
                    caption: "result.your_oracle",
                    value: Text(draft.teller?.name ?? "")
                )
            }
            .frame(height: 172)

            whatISee(reading)
            keySymbols(reading)
            advice(reading)
            shareAndSave
        }
    }

    private var cupImage: Image {
        if let photo = draft.photo { Image(uiImage: photo) } else { Image("SampleCupCard") }
    }

    private func whatISee(_ reading: Reading) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "cup.and.saucer.fill").foregroundStyle(Pigment.cream)
                Text("result.what_i_see")
                    .font(Lettering.displayMedium(18))
                    .foregroundStyle(Pigment.cream)
            }
            Text(reading.whatISee.oracleProse)
                .font(Lettering.body(14))
                .foregroundStyle(Pigment.cream)
                .lineSpacing(4)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardPanel(radius: 24)
    }

    private func keySymbols(_ reading: Reading) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("result.key_symbols")
                .font(Lettering.displayMedium(18))
                .foregroundStyle(Pigment.cream)

            FlowLayout(spacing: 8) {
                ForEach(reading.symbols) { SymbolChip(symbol: $0) }
            }

            VStack(alignment: .leading, spacing: 16) {
                ForEach(reading.symbols) { symbol in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(symbol.name)
                            .font(Lettering.bodyMedium(14))
                            .foregroundStyle(Pigment.cream)
                        Text(symbol.meaning.oracleProse)
                            .font(Lettering.body(14).italic())
                            .foregroundStyle(Pigment.cream.opacity(0.8))
                            .lineSpacing(3)
                    }
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 24).fill(Pigment.symbolPanel))
        }
    }

    private func advice(_ reading: Reading) -> some View {
        VStack(spacing: 12) {
            VStack(spacing: 12) {
                Image("magic-ball")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .accessibilityHidden(true)
                Text(reading.advice.oracleProse)
                    .font(Lettering.displayMedium(24))
                    .foregroundStyle(Pigment.cream)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                Text("result.advice_label")
                    .font(Lettering.body(12))
                    .foregroundStyle(Pigment.cream.opacity(0.4))
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .cardPanel(radius: 24)

            HStack(spacing: 6) {
                Image("clock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                    .opacity(0.6)
                    .accessibilityHidden(true)
                Text("result.timeframe_label")
                    .font(Lettering.body(12))
                    .foregroundStyle(Pigment.cream.opacity(0.6))
                Text(reading.timeframe)
                    .font(Lettering.bodyMedium(12))
                    .foregroundStyle(Pigment.accent)
            }
        }
    }

    /// Scrolls with the reading rather than being pinned: the design puts these
    /// after the advice, so they arrive once there is something worth keeping.
    private var shareAndSave: some View {
        HStack(spacing: 9) {
            if let card = shareCard {
                ShareLink(
                    item: card,
                    // Brand the preview with the app icon rather than the
                    // raw card thumbnail — this is how the share sheet and
                    // the saved item identify OracleBrew.
                    preview: SharePreview("share.preview_title",
                                          image: Image(uiImage: card.image),
                                          icon: Image("ShareIcon"))
                ) {
                    secondaryLabel("result.share", icon: "myshare")
                }
            } else {
                secondaryLabel("result.share", icon: "myshare").opacity(0.4)
            }
            Button(action: saveCard) {
                secondaryLabel("result.save", icon: "mysave")
            }
            .buttonStyle(.plain)
            .disabled(shareCard == nil)
        }
    }

    private var askOracleButton: some View {
        PrimaryButton(title: draft.readingHasChat ? "result.return_to_chat" : "result.ask_oracle",
                      action: onAskOracle)
    }

    /// `icon` is an asset name, not an SF Symbol — the design has its own glyphs
    /// for these two, and `square.and.arrow.up` / `arrow.down.to.line` were
    /// standing in. Template-rendered so they take the label's cream.
    private func secondaryLabel(_ key: LocalizedStringKey, icon: String) -> some View {
        HStack(spacing: 8) {
            Image(icon)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            Text(key).font(Lettering.displayMedium(18))
        }
        .foregroundStyle(Pigment.cream)
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .pillPanel()
    }

    private func saveCard() {
        // Saves the branded Share card, not the raw cup photo — the reading
        // itself is already kept server-side regardless.
        guard let card = shareCard else { return }
        Task {
            do {
                try await PhotoLibrary.save(card.image)
                Resonance.success()
                Tidings.shared.say("result.saved.title")
            } catch {
                // Said only now that we know. The confirmation used to fire the
                // moment the call returned, so a refused permission still
                // reported success and left nothing in the library.
                Resonance.failure()
                Tidings.shared.say("result.save_failed.title")
            }
        }
    }
}

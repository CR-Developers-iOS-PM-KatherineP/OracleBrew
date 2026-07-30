import SwiftUI
import PhotosUI

struct PhotoUploadView: View {
    @Environment(ReadingDraft.self) private var draft
    let onContinue: () -> Void
    let onBack: () -> Void
    let onClose: () -> Void

    @State private var pickerItem: PhotosPickerItem?
    @State private var showCamera = false
    @State private var camera = CupCamera()
    @State private var capturing = false
    /// A picked photo has to be read out of the library before it can be shown,
    /// which on an iCloud photo is a visible wait — the zone says so meanwhile.
    @State private var importingPhoto = false
    /// Which source the current photo came from — decides what "another" offers.
    @State private var photoFromCamera = false

    /// Raised when the shutter is tapped with camera access off.
    @State private var cameraDenied = false

    @Environment(\.scenePhase) private var scenePhase

    private var hasPhoto: Bool { draft.photo != nil }

    var body: some View {
        ZStack(alignment: .top) {
            Pigment.background.ignoresSafeArea()

            VStack(spacing: 0) {
                if hasPhoto {
                    previewHeader
                } else {
                    FlowHeader(title: "photo.title", subtitle: "photo.subtitle",
                               step: 4, onBack: onBack, onClose: onClose)
                    .padding(.top, 4)
                }

                zone
                    .padding(.top, hasPhoto ? 16 : 24)

                Spacer(minLength: 12)

                if !hasPhoto {
                    instructionCard
                        .padding(.bottom, 16)
                }
                buttons
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear(perform: prefillRandomIfNeeded)
        .task {
            // Access is asked for here, before the feed is needed — the Random
            // Cup path never shows a camera, so it's never prompted.
            guard !hasPhoto, !draft.isRandomPath else { return }
            await camera.prepare()
        }
        .onDisappear { camera.stop() }
        // Permission can be changed in Settings while we're backgrounded, so the
        // answer is re-read on the way back rather than trusted from launch.
        .onChange(of: scenePhase) { _, phase in
            guard phase == .active, !hasPhoto, !draft.isRandomPath else { return }
            Task { await camera.revalidate() }
        }
        .onChange(of: pickerItem) { _, item in loadPicked(item) }
        .alert("photo.denied.title", isPresented: $cameraDenied) {
            Button("photo.zone.open_settings", action: openSystemSettings)
            Button("common.cancel", role: .cancel) {}
        } message: {
            Text("photo.denied.message")
        }
        .fullScreenCover(isPresented: $showCamera) {
            CameraPicker { draft.photo = $0 }.ignoresSafeArea()
        }
    }

    // MARK: Header (preview state)

    /// Back and close, like every other step in the flow. With close alone the
    /// only control on the screen dropped the user out to the home tab, which is
    /// not a step back from anywhere.
    ///
    /// Back returns to the capture screen rather than popping to the intention
    /// step: the preview is a state of *this* step — the photo was just picked
    /// here — so one step back is un-picking it, not skipping the screen it was
    /// picked on. Close still leaves the flow.
    private var previewHeader: some View {
        ZStack {
            Text("photo.preview.title")
                .font(Lettering.displayMedium(24))
                .foregroundStyle(Pigment.cream)
            HStack {
                Button(action: retake) {
                    Image(systemName: "arrow.backward")
                        .accessibilityLabel("a11y.back")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Pigment.cream)
                        .frame(width: Cadence.tapTarget, height: Cadence.tapTarget)
                        .background(Circle().fill(Pigment.surface))
                }
                .buttonStyle(.plain)
                Spacer()
                Button(action: onClose) {
                    Image(systemName: "xmark")
                        .accessibilityLabel("a11y.close")
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

    // MARK: Photo zone

    @ViewBuilder
    private var zone: some View {
        // Same box as the random-cup step, but whether it clips depends on what's
        // inside — which is why this is two boxes and not one.
        if let photo = draft.photo {
            // Clipped by the box, not by the image. `scaledToFill` reports a frame
            // *larger* than the proposal, so a clipShape on the image clips to that
            // already-oversized frame and changes nothing — the tall camera shot
            // still rode up over the title and the close button. The box clips
            // against its own Color.clear size, which is the design's 353×395.
            CupPhotoBox(clipsContent: true) {
                Image(uiImage: photo)
                    .resizable()
                    .scaledToFill()
                    // Decoration: keep it out of the hit test and the
                    // accessibility tree, where the overflowing size otherwise
                    // reads as an element wider than the screen.
                    .allowsHitTesting(false)
                    .accessibilityHidden(true)
            }
            .overlay { importProgress }
        } else {
            // Unclipped: both of these draw their own dashed border, and it sits
            // exactly on the boundary — clipping would shave half its stroke off.
            CupPhotoBox(clipsContent: false) {
                if camera.phase == .running {
                    // Live feed — the user frames the cup right in the drop zone.
                    CameraPreview(session: camera.session)
                        .clipShape(RoundedRectangle(cornerRadius: CupPhoto.radius))
                        .overlay(
                            RoundedRectangle(cornerRadius: CupPhoto.radius)
                                .strokeBorder(Pigment.accent.opacity(0.5),
                                              style: StrokeStyle(lineWidth: 2, dash: [6, 5]))
                        )
                        .overlay { if capturing { Color.white.opacity(0.7) } }
                        .animation(.easeOut(duration: 0.15), value: capturing)
                } else {
                    dropZonePlaceholder
                }
            }
            .overlay { importProgress }
        }
    }

    @ViewBuilder
    private var importProgress: some View {
        if importingPhoto {
            ZStack {
                RoundedRectangle(cornerRadius: CupPhoto.radius)
                    .fill(Pigment.background.opacity(0.6))
                ProgressView().tint(Pigment.accent)
            }
        }
    }

    /// Shown until the feed is up, and for good where it can't run at all
    /// (no camera, access denied).
    private var dropZonePlaceholder: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle().fill(Pigment.accent.opacity(0.15)).frame(width: 72, height: 72)
                Image(systemName: camera.phase == .denied ? "camera.badge.ellipsis" : "camera.fill")
                    .font(.system(size: 26))
                    .foregroundStyle(Pigment.accent)
            }
            // Denied is a problem the user can fix, so it reads at full strength
            // and comes with the way to fix it. At 40% it looked like the same
            // passive hint as "take a photo of your cup", and there was nothing
            // to act on — the camera just showed black.
            Text(camera.phase == .denied ? "photo.zone.denied" : "photo.zone.hint")
                .font(Lettering.body(14))
                .foregroundStyle(Pigment.cream.opacity(camera.phase == .denied ? 0.9 : 0.4))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            if camera.phase == .denied {
                Button(action: openSystemSettings) {
                    Text("photo.zone.open_settings")
                        .font(Lettering.bodySemibold(13))
                        .foregroundStyle(Pigment.accent)
                        .padding(.horizontal, 18)
                        .frame(height: 36)
                        .background(Capsule().fill(Pigment.accent.opacity(0.15)))
                }
                .buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(RoundedRectangle(cornerRadius: CupPhoto.radius).fill(Pigment.card).opacity(0.8))
        .overlay(
            RoundedRectangle(cornerRadius: CupPhoto.radius)
                .strokeBorder(Pigment.accent.opacity(0.5),
                              style: StrokeStyle(lineWidth: 2, dash: [6, 5]))
        )
    }

    private var instructionCard: some View {
        HStack(spacing: 12) {
            Image(systemName: "info.circle")
                .font(.system(size: 18))
                .foregroundStyle(Pigment.accent)
            Text("photo.instruction")
                .font(Lettering.body(12))
                .foregroundStyle(Pigment.cream.opacity(0.9))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardPanel(radius: 20)
    }

    // MARK: Buttons

    @ViewBuilder
    private var buttons: some View {
        VStack(spacing: 12) {
            if hasPhoto {
                // "Another" has to mean the same source the photo came from —
                // offering the gallery after a camera shot (or the reverse)
                // isn't what the label promises.
                if photoFromCamera {
                    Button(action: retake) { secondaryLabel("photo.take_another") }
                        .buttonStyle(.plain)
                } else {
                    PhotosPicker(selection: $pickerItem, matching: .images) {
                        secondaryLabel("photo.select_another")
                    }
                    .buttonStyle(.plain)
                }
                PrimaryButton(title: "photo.continue", action: onContinue)
            } else {
                PhotosPicker(selection: $pickerItem, matching: .images) {
                    secondaryLabel("photo.upload_gallery")
                }
                .buttonStyle(.plain)
                PrimaryButton(title: "photo.take", action: take)
                    .disabled(capturing)
            }
        }
    }

    private func secondaryLabel(_ key: LocalizedStringKey) -> some View {
        Text(key)
            .font(Lettering.displayMedium(20))
            .foregroundStyle(Pigment.cream)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .pillPanel()
            .contentShape(Capsule())
    }

    // MARK: Actions

    /// Snaps the live feed, or explains why it can't.
    private func take() {
        // Denied gets the notice, never the system modal. The modal is a
        // UIImagePickerController on the camera source, and without permission it
        // presents a black screen — which is exactly what this looked like from
        // the outside: "the camera just opens, black". Only a missing session for
        // some other reason (no hardware, simulator) is worth falling back for.
        if camera.phase == .denied {
            cameraDenied = true
            return
        }
        guard camera.phase == .running else {
            if CameraPicker.isAvailable { showCamera = true }
            return
        }
        capturing = true
        Task {
            defer { capturing = false }
            guard let image = await camera.capture() else { return }
            draft.photo = image
            photoFromCamera = true
            camera.stop()
        }
    }

    /// Drops the shot and brings the live feed back for another go.
    private func retake() {
        draft.photo = nil
        photoFromCamera = false
        Task { await camera.prepare() }
    }

    /// Same jump as the permissions rows in Settings use — straight to this app's
    /// own page, where the camera switch is.
    private func openSystemSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }

    private func prefillRandomIfNeeded() {
        guard draft.isRandomPath, draft.photo == nil,
              let sample = UIImage(named: "SampleCup") else { return }
        draft.photo = sample
    }

    private func loadPicked(_ item: PhotosPickerItem?) {
        guard let item else { return }
        importingPhoto = true
        Task {
            let data = try? await item.loadTransferable(type: Data.self)
            await MainActor.run {
                importingPhoto = false
                guard let data, let image = UIImage(data: data) else {
                    Resonance.failure()
                    Tidings.shared.say("photo.import_failed")
                    return
                }
                draft.photo = image
                photoFromCamera = false
                camera.stop()
            }
        }
    }
}

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
        .onChange(of: pickerItem) { _, item in loadPicked(item) }
        .fullScreenCover(isPresented: $showCamera) {
            CameraPicker { draft.photo = $0 }.ignoresSafeArea()
        }
    }

    // MARK: Header (preview state — title + close only)

    private var previewHeader: some View {
        ZStack {
            Text("photo.preview.title")
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

    // MARK: Photo zone

    private var zone: some View {
        // Same box as the random-cup step. Each state draws its own shape — the
        // dashed border sits on the boundary — so the box doesn't clip.
        CupPhotoBox(clipsContent: false) {
            if let photo = draft.photo {
                Image(uiImage: photo)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: CupPhoto.radius))
                    // clipShape hides the overflow but still lets it take taps,
                    // and a camera frame is tall enough to spill over the header
                    // and swallow the close button. It's decoration — opt it out.
                    .allowsHitTesting(false)
            } else if camera.phase == .running {
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
        .overlay {
            if importingPhoto {
                ZStack {
                    RoundedRectangle(cornerRadius: CupPhoto.radius)
                        .fill(Pigment.background.opacity(0.6))
                    ProgressView().tint(Pigment.accent)
                }
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
            Text(camera.phase == .denied ? "photo.zone.denied" : "photo.zone.hint")
                .font(Lettering.body(14))
                .foregroundStyle(Pigment.cream.opacity(0.4))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
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

    /// Snaps the live feed. Where no session could start (simulator, denied)
    /// falls back to the system camera modal.
    private func take() {
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
                    return
                }
                draft.photo = image
                photoFromCamera = false
                camera.stop()
            }
        }
    }
}

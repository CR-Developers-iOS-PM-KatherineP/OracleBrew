//
//  CupCamera.swift
//  OracleBrew
//
//  Live capture session behind the Photo Upload drop zone: the user frames the
//  cup in-place instead of being pushed out to a modal camera. Falls back to
//  CameraPicker where a session can't run (no camera, access denied).
//

import AVFoundation
import SwiftUI
import UIKit

@MainActor
@Observable
final class CupCamera {
    enum Phase {
        case idle
        case denied
        /// No camera hardware — the simulator, mostly.
        case unavailable
        case running
    }

    private(set) var phase: Phase = .idle

    /// Handed to the preview layer; nil until the session is configured.
    @ObservationIgnored private(set) var session: AVCaptureSession?
    @ObservationIgnored private let output = AVCapturePhotoOutput()
    @ObservationIgnored private let queue = DispatchQueue(label: "cup-camera")
    @ObservationIgnored private var captor: PhotoCaptor?

    /// Asks for access (first call shows the system prompt) and starts the
    /// session. Safe to call again — a running session is left alone.
    func prepare() async {
        guard phase != .running else { return }

        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            break
        case .notDetermined:
            guard await AVCaptureDevice.requestAccess(for: .video) else {
                phase = .denied
                return
            }
        default:
            phase = .denied
            return
        }

        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let input = try? AVCaptureDeviceInput(device: device) else {
            phase = .unavailable
            return
        }

        let session = AVCaptureSession()
        session.sessionPreset = .photo
        session.beginConfiguration()
        guard session.canAddInput(input), session.canAddOutput(output) else {
            session.commitConfiguration()
            phase = .unavailable
            return
        }
        session.addInput(input)
        session.addOutput(output)
        session.commitConfiguration()

        self.session = session
        phase = .running
        queue.async { session.startRunning() }
    }

    func stop() {
        guard let session else { return }
        queue.async { session.stopRunning() }
        phase = .idle
        self.session = nil
    }

    /// Takes a still. Returns nil if the session isn't running or capture failed.
    func capture() async -> UIImage? {
        guard phase == .running else { return nil }
        let settings = AVCapturePhotoSettings()
        return await withCheckedContinuation { continuation in
            let captor = PhotoCaptor { image in
                continuation.resume(returning: image)
                Task { @MainActor in self.captor = nil }
            }
            // The output only holds the delegate weakly — keep it alive here.
            self.captor = captor
            output.capturePhoto(with: settings, delegate: captor)
        }
    }
}

/// One-shot AVCapturePhotoOutput delegate.
private final class PhotoCaptor: NSObject, AVCapturePhotoCaptureDelegate {
    private let onFinish: (UIImage?) -> Void
    private var finished = false

    init(onFinish: @escaping (UIImage?) -> Void) {
        self.onFinish = onFinish
    }

    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        guard !finished else { return }
        finished = true
        onFinish(photo.fileDataRepresentation().flatMap(UIImage.init(data:)))
    }
}

/// Hosts the session's preview layer. Sized by the SwiftUI parent.
struct CameraPreview: UIViewRepresentable {
    let session: AVCaptureSession

    func makeUIView(context: Context) -> PreviewView {
        let view = PreviewView()
        view.backgroundColor = .black
        view.previewLayer.session = session
        view.previewLayer.videoGravity = .resizeAspectFill
        return view
    }

    func updateUIView(_ view: PreviewView, context: Context) {
        if view.previewLayer.session !== session { view.previewLayer.session = session }
    }

    final class PreviewView: UIView {
        override class var layerClass: AnyClass { AVCaptureVideoPreviewLayer.self }
        var previewLayer: AVCaptureVideoPreviewLayer { layer as! AVCaptureVideoPreviewLayer }

        override func layoutSubviews() {
            super.layoutSubviews()
            // The flow is portrait-locked; pin the feed so it never lands sideways.
            previewLayer.connection?.videoRotationAngle = 90
        }
    }
}

//
//  PreviewView.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-05.
//

import AppKit
import AVFoundation

class PreviewView: NSView {
    private var previewLayer: AVCaptureVideoPreviewLayer

    init(captureSession: AVCaptureSession) {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)

        super.init(frame: .zero)

        setupLayer()
    }

    func setupLayer() {
        previewLayer.frame = frame
        previewLayer.connection?.automaticallyAdjustsVideoMirroring = false
        layer = previewLayer
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

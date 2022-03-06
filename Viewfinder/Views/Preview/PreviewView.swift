//
//  PreviewView.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-05.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import AppKit
import AVFoundation

class PreviewView: NSView {
    private var previewLayer = AVCaptureVideoPreviewLayer()

    init(captureSession: AVCaptureSession) {
        previewLayer.session = captureSession
        previewLayer.connection?.automaticallyAdjustsVideoMirroring = false

        super.init(frame: .zero)

        layer = previewLayer
    }

    func setCaptureSession(to captureSession: AVCaptureSession) {
        previewLayer.session = captureSession
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

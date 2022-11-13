//
//  PreviewContainer.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-05.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import AVFoundation
import SwiftUI

struct PreviewContainer: NSViewRepresentable {
    private let captureSession: AVCaptureSession

    init(captureSession: AVCaptureSession) {
        self.captureSession = captureSession
    }

    func makeNSView(context: Context) -> PreviewView {
        return PreviewView(captureSession: captureSession)
    }

    func updateNSView(_ previewView: PreviewView, context: Context) {
        previewView.setCaptureSession(to: captureSession)
    }
}

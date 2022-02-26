//
//  PreviewContainer.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-05.
//

import AVFoundation
import SwiftUI

final class PreviewContainer: NSViewRepresentable {
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

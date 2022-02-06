//
//  PreviewContainer.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-05.
//

import AVFoundation
import SwiftUI

final class PreviewContainer: NSViewRepresentable {
    typealias NSViewType = PreviewView

    private let captureSession: AVCaptureSession

    init(captureSession: AVCaptureSession) {
        self.captureSession = captureSession
    }

    func makeNSView(context: Context) -> NSViewType {
        return PreviewView(captureSession: captureSession)
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {}
}
//
//  PreviewPanelViewModel.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-05.
//

import AVFoundation
import Combine
import SwiftUI

class PreviewPanelViewModel: ObservableObject {
    let captureSession = AVCaptureSession()
    @Published var running = false

    func startSession() {
        withAnimation {
            running = true
        }

        guard !captureSession.isRunning else {
            return
        }

        addInput()
        captureSession.startRunning()
    }

    func stopSession() {
        running = false

        guard captureSession.isRunning else {
            return
        }

        captureSession.stopRunning()
    }

    private func addInput() {
        guard
            let device = AVCaptureDevice.default(for: .video),
            let input = try? AVCaptureDeviceInput(device: device),
            captureSession.canAddInput(input)
        else {
            return
        }

        captureSession.addInput(input)
    }
}

//
//  DeviceManager.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-10.
//

import AVFoundation
import SwiftUI
import UVCKit

class DeviceManager: ObservableObject {
    static let shared = DeviceManager()

    @Published private(set) var primaryDevice: Device?
    let captureSession = AVCaptureSession()

    init() {
        let discoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.externalUnknown, .builtInWideAngleCamera],
            mediaType: nil,
            position: .unspecified
        )

        guard
            let firstSessionDevice = discoverySession.devices.first,
            let device = Device(device: firstSessionDevice)
        else {
            return
        }

        self.primaryDevice = device
    }

    func startCaptureSession() {
        guard let input = primaryDevice?.input else {
            return
        }

        Task {
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }

            captureSession.startRunning()
        }
    }

    func stopCaptureSession() {
        Task {
            captureSession.stopRunning()
        }
    }
}

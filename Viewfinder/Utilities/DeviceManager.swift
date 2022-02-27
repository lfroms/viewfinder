//
//  DeviceManager.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-10.
//

import AVFoundation
import Combine
import SwiftUI

class DeviceManager: ObservableObject {
    static let shared = DeviceManager()

    @Published private(set) var devices: [Device] = []
    let captureSession = AVCaptureSession()

    private var cancellables = Set<AnyCancellable>()

    var currentDevice: Device? {
        devices.first
    }

    init() {
        subscribeToDeviceNotifications()
        refreshDevices()
    }

    private func refreshDevices() {
        let discoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.externalUnknown, .builtInWideAngleCamera],
            mediaType: nil,
            position: .unspecified
        )

        discoverySession.devices
            .publisher
            .compactMap { Device(device: $0) }
            .collect()
            .assign(to: &$devices)
    }

    func startCaptureSession() {
        Task {
            guard
                let device = currentDevice,
                let input = try? AVCaptureDeviceInput(device: device.avCaptureDevice)
            else {
                return
            }

            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }

            captureSession.startRunning()
        }
    }

    func stopCaptureSession() {
        Task {
            captureSession.stopRunning()

            captureSession.inputs.forEach { input in
                captureSession.removeInput(input)
            }
        }
    }

    private func restartCaptureSession() {
        Task {
            captureSession.stopRunning()

            captureSession.inputs.forEach { input in
                captureSession.removeInput(input)
            }

            startCaptureSession()
        }
    }

    func subscribeToDeviceNotifications() {
        NotificationCenter.default
            .publisher(for: .AVCaptureDeviceWasConnected)
            .sink { [self] notification in
                guard
                    let avCaptureDevice = notification.object as? AVCaptureDevice,
                    !devices.contains(where: { $0.id == avCaptureDevice.uniqueID }),
                    let device = Device(device: avCaptureDevice)
                else {
                    return
                }

                self.devices.append(device)

                restartCaptureSession()
            }
            .store(in: &cancellables)

        NotificationCenter.default
            .publisher(for: .AVCaptureDeviceWasDisconnected)
            .sink { [self] notification in
                guard
                    let avCaptureDevice = notification.object as? AVCaptureDevice,
                    devices.contains(where: { $0.id == avCaptureDevice.uniqueID })
                else {
                    return
                }

                self.devices.removeAll { $0.id == avCaptureDevice.uniqueID }
            }
            .store(in: &cancellables)
    }
}

//
//  DeviceManager.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-10.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import AVFoundation
import Combine
import SwiftUI

class DeviceManager: ObservableObject {
    static let shared = DeviceManager()

    @AppStorage("selectedDeviceId") private var selectedDeviceId: String?

    let captureSession = AVCaptureSession()
    var appIsInForeground = false

    private var cancellables = Set<AnyCancellable>()

    @Published private(set) var devices: [Device] = []

    @Published var currentDevice: Device? {
        didSet {
            if oldValue?.id != currentDevice?.id {
                selectedDeviceId = currentDevice?.id
                restartCaptureSession()
            }
        }
    }

    init() {
        subscribeToDeviceNotifications()
    }

    func refreshDevices() {
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

        selectDevice()
    }

    func startCaptureSession() {
        guard appIsInForeground else {
            return
        }

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

    private func selectDevice() {
        currentDevice = devices.first { device in
            device.id == selectedDeviceId
        } ?? devices.first
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
                    !devices.contains(where: { $0.id == avCaptureDevice.uniqueID })
                else {
                    return
                }

                devices.append(.init(device: avCaptureDevice))

                if devices.count == 1 {
                    selectDevice()
                }
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

                if !devices.contains(where: { $0.id == selectedDeviceId }) {
                    selectDevice()
                }
            }
            .store(in: &cancellables)
    }
}

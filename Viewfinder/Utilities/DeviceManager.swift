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
    private var cancellables = Set<AnyCancellable>()

    @AppStorage("selectedDeviceId") private var userSelectedDeviceId: String?

    let captureSession = AVCaptureSession()
    var menuIsOpen: Bool = false

    @Published private(set) var connectedDevices: [Device] = []
    @Published private(set) var currentDevice: Device? {
        didSet {
            guard menuIsOpen, oldValue?.id != currentDevice?.id else {
                return
            }

            Task {
                restartCaptureSession()
            }
        }
    }

    private init() {
        subscribeToDeviceNotifications()
    }

    /// Finds all connected devices then selects and starts the capture session if an appropriate device was found.
    func discoverConnectedDevices() {
        let deviceTypes: [AVCaptureDevice.DeviceType] = if #available(macOS 14, *) {
            [.external, .builtInWideAngleCamera, .continuityCamera, .deskViewCamera]
        } else {
            [.externalUnknown, .builtInWideAngleCamera]
        }

        let discoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: deviceTypes,
            mediaType: .video,
            position: .unspecified
        )

        discoverySession.devices
            .publisher
            .compactMap { Device(device: $0) }
            .collect()
            .assign(to: &$connectedDevices)

        selectAvailableDevice()
    }

    /// Switches to and activates the capture session for the provided `Device`.
    /// - Parameter device: The `Device` to switch to.
    func switchCurrentDevice(to device: Device) {
        userSelectedDeviceId = device.id
        currentDevice = device
    }

    func startCaptureSession() {
        guard
            menuIsOpen,
            let device = currentDevice,
            let input = try? AVCaptureDeviceInput(device: device.avCaptureDevice)
        else {
            return
        }

        if captureSession.canAddInput(input) {
            captureSession.addInput(input)
            captureSession.startRunning()
        }
    }

    func stopCaptureSession() {
        captureSession.stopRunning()

        captureSession.inputs.forEach { input in
            captureSession.removeInput(input)
        }
    }

    private func restartCaptureSession() {
        stopCaptureSession()
        startCaptureSession()
    }

    /// Switches to the user-selected device, if available, otherwise the next available device, if any.
    private func selectAvailableDevice() {
        let userSelectedDevice = connectedDevices.first { $0.id == userSelectedDeviceId }
        let firstExternalDevice = connectedDevices.first { $0.avCaptureDevice.deviceType == .externalUnknown }
        let firstAvailableDevice = connectedDevices.first

        let deviceToSwitchTo = userSelectedDevice ?? firstExternalDevice ?? firstAvailableDevice

        guard deviceToSwitchTo?.id != currentDevice?.id else {
            return
        }

        currentDevice = deviceToSwitchTo

        if userSelectedDeviceId == nil, let deviceToSwitchTo = deviceToSwitchTo {
            // If the user hasn't set anything, pre-select the camera for them so it's consistent between launches.
            userSelectedDeviceId = deviceToSwitchTo.id
        }
    }

    private func subscribeToDeviceNotifications() {
        NotificationCenter.default
            .publisher(for: .AVCaptureDeviceWasConnected)
            .sink { [self] notification in
                guard
                    let avCaptureDevice = avCaptureDevice(in: notification),
                    !isConnected(device: avCaptureDevice)
                else {
                    return
                }

                connectedDevices.append(Device(device: avCaptureDevice))
                selectAvailableDevice()
            }
            .store(in: &cancellables)

        NotificationCenter.default
            .publisher(for: .AVCaptureDeviceWasDisconnected)
            .sink { [self] notification in
                guard
                    let avCaptureDevice = avCaptureDevice(in: notification),
                    isConnected(device: avCaptureDevice)
                else {
                    return
                }

                self.connectedDevices.removeAll { $0.id == avCaptureDevice.uniqueID }
                selectAvailableDevice()
            }
            .store(in: &cancellables)
    }

    private func isConnected(device avCaptureDevice: AVCaptureDevice) -> Bool {
        connectedDevices.contains { connectedDevice in
            connectedDevice.id == avCaptureDevice.uniqueID
        }
    }

    private func avCaptureDevice(in notification: NotificationCenter.Publisher.Output) -> AVCaptureDevice? {
        notification.object as? AVCaptureDevice
    }
}

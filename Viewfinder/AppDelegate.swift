//
//  AppDelegate.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-05.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import AppKit
import AVFoundation
import Sparkle

final class AppDelegate: NSObject, NSApplicationDelegate {
    private let deviceManager = DeviceManager.shared
    private let dataRefreshNotifier = DataRefreshNotifier()

    private var statusBarApplication: StatusBarApplication?

    private let updaterController = SPUStandardUpdaterController(
        startingUpdater: true,
        updaterDelegate: nil,
        userDriverDelegate: nil
    )

    func applicationDidFinishLaunching(_ notification: Notification) {
        var opensAtLogin = false

        if #available(macOS 13.0, *) {
            let controller = LaunchAtLoginController()
            controller.performInitialSetupIfNeeded()

            opensAtLogin = controller.launchesAtLogin
        }

        Task {
            deviceManager.discoverConnectedDevices()
        }

        self.statusBarApplication = StatusBarApplication(opensAtLogin: opensAtLogin)
        self.statusBarApplication?.delegate = self

        if AVCaptureDevice.authorizationStatus(for: .video) != .authorized {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { _ in })
        }
    }
}

// MARK: - StatusBarApplicationDelegate

extension AppDelegate: StatusBarApplicationDelegate {
    func menuWillOpen() {
        self.deviceManager.menuIsOpen = true

        Task {
            deviceManager.startCaptureSession()
        }

        self.dataRefreshNotifier.refreshPeriodically()
    }

    func menuDidClose() {
        self.dataRefreshNotifier.pauseRefreshingPeriodically()

        Task {
            deviceManager.stopCaptureSession()
        }

        self.deviceManager.menuIsOpen = false
    }

    func didPressAboutItem(_ sender: Any?) {
        NSApp.activate(ignoringOtherApps: true)
        NSApp.orderFrontStandardAboutPanel(sender)
    }

    func didPressCheckForUpdatesItem(_ sender: Any?) {
        self.updaterController.checkForUpdates(sender)
    }

    @available(macOS 13.0, *)
    func didPressOpenAtLoginItem(_ sender: NSMenuItem) {
        let controller = LaunchAtLoginController()
        controller.toggleRegistration()

        sender.state = controller.launchesAtLogin ? .on : .off
    }

    func didPressQuitItem(_ sender: Any?) {
        NSApplication.shared.terminate(sender)
    }
}

//
//  AppDelegate.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-05.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import AppKit
import Sparkle

final class AppDelegate: NSObject, NSApplicationDelegate {
    private let deviceManager = DeviceManager.shared
    private let dataRefreshNotifier = DataRefreshNotifier()

    private var statusBarApplication: StatusBarApplication?

    private let updaterController = SPUStandardUpdaterController(
        startingUpdater: true,
        updaterDelegate: UpdaterDelegate(),
        userDriverDelegate: nil
    )

    func applicationDidFinishLaunching(_ notification: Notification) {
        Task {
            deviceManager.discoverConnectedDevices()
        }

        self.statusBarApplication = StatusBarApplication()
        self.statusBarApplication?.delegate = self
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

    func didPressQuitItem(_ sender: Any?) {
        NSApplication.shared.terminate(sender)
    }
}

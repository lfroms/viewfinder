//
//  AppDelegate.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-05.
//

import Foundation
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {
    private var statusBarItem: NSStatusItem?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let contentView = HostingView(
            rootView: ContentView()
                .environmentObject(DeviceManager.shared)
                .padding(.top, -4) // Compensate for internal margins.
        )

        contentView.frame = NSRect(x: 0, y: 0, width: 380, height: 640)

        let menuItem = NSMenuItem()
        menuItem.view = contentView

        let menu = NSMenu()
        menu.delegate = self
        menu.addItem(menuItem)

        self.statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        self.statusBarItem?.menu = menu
        self.statusBarItem?.button?.image = NSImage(systemSymbolName: "camera.fill", accessibilityDescription: nil)
    }

    // MARK: - NSMenuDelegate

    func menuWillOpen(_ menu: NSMenu) {
        DeviceManager.shared.startCaptureSession()
    }

    func menuDidClose(_ menu: NSMenu) {
        DeviceManager.shared.stopCaptureSession()
    }
}

class HostingView<Content: View>: NSHostingView<Content> {
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        // Ensure that the menu receives and propagates clicks.
        window?.becomeKey()
    }
}

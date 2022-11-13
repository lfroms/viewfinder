//
//  LaunchAtLoginController.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-11-12.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import ServiceManagement
import SwiftUI

@available(macOS 13.0, *)
final class LaunchAtLoginController {
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false

    var launchesAtLogin: Bool {
        SMAppService.mainApp.status == .enabled
    }

    func performInitialSetupIfNeeded() {
        if !hasLaunchedBefore {
            registerIfNeeded()
            hasLaunchedBefore = true
        }
    }

    func toggleRegistration() {
        launchesAtLogin ? unregisterIfNeeded() : registerIfNeeded()
    }

    private func registerIfNeeded() {
        if !launchesAtLogin {
            try? SMAppService.mainApp.register()
        }
    }

    private func unregisterIfNeeded() {
        if launchesAtLogin {
            try? SMAppService.mainApp.unregister()
        }
    }
}

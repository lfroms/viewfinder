//
//  PreviewPanel.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-05.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct PreviewPanel: View {
    @EnvironmentObject var deviceManager: DeviceManager

    var body: some View {
        Panel {
            ZStack {
                PreviewStateEmptyState(state: previewState)

                PreviewContainer(captureSession: deviceManager.captureSession)
                    .aspectRatio(16 / 9, contentMode: .fit)
            }
        }
    }

    private var previewState: PreviewState {
        guard let currentDevice = deviceManager.currentDevice else {
            return .noDevice
        }

        if currentDevice.avCaptureDevice.isSuspended {
            return .suspended(deviceName: currentDevice.avCaptureDevice.localizedName)
        }

        return .initializing
    }
}

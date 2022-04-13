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
    @StateObject private var viewModel = PreviewPanelViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .center) {
                PreviewStateEmptyState(state: previewState)

                Panel {
                    PreviewContainer(captureSession: deviceManager.captureSession)
                        .aspectRatio(16 / 9, contentMode: .fit)
                }
                .scaleEffect(CGSize(width: viewModel.mirrorVideoPreview ? -1 : 1, height: 1))
            }

            if previewState == .initializing {
                FlipButton(activated: viewModel.mirrorVideoPreview, action: viewModel.didPressMirrorVideoButton)
                    .opacity(viewModel.hovering ? 1 : 0)
            }
        }
        .onBackgroundHover(perform: viewModel.didChangeHoverState(hovering:))
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

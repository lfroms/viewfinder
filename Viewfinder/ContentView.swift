//
//  ContentView.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-03.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var deviceManager: DeviceManager

    var body: some View {
        VStack(spacing: 0) {
            if deviceManager.currentDevice != nil {
                PreviewPanel()
                    .padding(12)
            }

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    if deviceManager.connectedDevices.count > 1 {
                        CameraPicker()
                    }

                    if let uvc = deviceManager.currentDevice?.uvc {
                        VStack(spacing: 12) {
                            if uvc.cameraTerminalCapabilities.exposureTimeAbsolute {
                                ExposurePanel()
                            }

                            if uvc.processingUnitCapabilities.whiteBalanceTemperature {
                                WhiteBalancePanel()
                            }

                            if uvc.processingUnitCapabilities.brightness {
                                BrightnessPanel()
                            }

                            if uvc.processingUnitCapabilities.contrast {
                                ContrastPanel()
                            }

                            if uvc.processingUnitCapabilities.saturation {
                                SaturationPanel()
                            }

                            if uvc.processingUnitCapabilities.saturation {
                                SharpnessPanel()
                            }

                            if uvc.cameraTerminalCapabilities.focusAbsolute {
                                FocusPanel()
                            }

                            if uvc.cameraTerminalCapabilities.zoomAbsolute {
                                ZoomPanel()
                            }

                            if uvc.processingUnitCapabilities.backlightCompensation {
                                HDRPanel()
                            }
                        }
                        .padding(12)
                    }
                }
            }
            .fixedSize(horizontal: false, vertical: deviceManager.currentDevice?.uvc == nil)

            if deviceManager.currentDevice == nil {
                NoWebcamEmptyState()
            }

            if deviceManager.currentDevice != nil, deviceManager.currentDevice?.uvc == nil {
                UnsupportedWebcamEmptyState()
            }
        }
    }
}

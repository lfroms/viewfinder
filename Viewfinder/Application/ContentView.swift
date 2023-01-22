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
                    .padding(Metrics.panelInset)
            }

            if deviceManager.connectedDevices.count > 1 {
                CameraPicker()
                    .padding([.horizontal, .bottom], Metrics.menuMargin)
            }

            Divider()
                .padding(.horizontal, Metrics.dividerWidth)

            if let uvc = deviceManager.currentDevice?.uvc {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: Metrics.panelInset) {
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
                    .padding(Metrics.panelInset)
                }
            }

            if deviceManager.currentDevice == nil {
                NoWebcamEmptyState()
            }

            if deviceManager.currentDevice != nil, deviceManager.currentDevice?.uvc == nil {
                UnsupportedWebcamEmptyState()
            }

            Divider()
                .padding(.horizontal, Metrics.dividerWidth)
                .padding(.bottom, Metrics.menuMargin)
        }
    }
}

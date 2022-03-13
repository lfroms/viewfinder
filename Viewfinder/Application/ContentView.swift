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
                    .padding(Dimension.Menu.inset)
            }

            if deviceManager.connectedDevices.count > 1 {
                CameraPicker()
                    .padding([.horizontal, .bottom], Dimension.Menu.margin)
            }

            Divider()
                .padding(.horizontal, Dimension.Divider.width)

            if let uvc = deviceManager.currentDevice?.uvc {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: Dimension.Menu.inset) {
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
                    .padding(Dimension.Menu.inset)
                }
            }

            if deviceManager.currentDevice == nil {
                NoWebcamEmptyState()
            }

            if deviceManager.currentDevice != nil, deviceManager.currentDevice?.uvc == nil {
                UnsupportedWebcamEmptyState()
            }

            Divider()
                .padding(.horizontal, Dimension.Divider.width)
                .padding(.bottom, Dimension.Menu.margin - Dimension.Divider.width)
        }
    }
}

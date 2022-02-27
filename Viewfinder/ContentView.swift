//
//  ContentView.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-03.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var deviceManager: DeviceManager

    var body: some View {
        VStack(spacing: 0) {
            PreviewPanel()
                .padding(12)

            ScrollView(.vertical, showsIndicators: false) {
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
    }
}

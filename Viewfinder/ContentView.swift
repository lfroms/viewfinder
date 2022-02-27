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
            if deviceManager.currentDevice != nil {
                PreviewPanel()
                    .padding(12)
            }
            
            if let uvc = deviceManager.currentDevice?.uvc {
                ScrollView(.vertical, showsIndicators: false) {
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
            } else {
                VStack(spacing: 3) {
                    Spacer()
                        
                    Text("No UVC Webcam Found")
                        .font(.title2.bold())
                        .opacity(0.6)
                        
                    Text("Connect a UVC-compliant webcam to control its settings.")
                        .font(.caption.bold())
                        .opacity(0.6)
                        
                    Spacer()
                }
            }
        }
    }
}

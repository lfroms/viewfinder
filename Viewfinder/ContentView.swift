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
                if deviceManager.devices.first != nil {
                    VStack(spacing: 12) {
                        ExposurePanel()
                        WhiteBalancePanel()
                        BrightnessPanel()
                        ContrastPanel()
                        SaturationPanel()
                        SharpnessPanel()
                        FocusPanel()
                        ZoomPanel()
                        HDRPanel()
                    }
                    .padding(12)
                }
            }
        }
    }
}

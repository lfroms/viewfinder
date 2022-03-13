//
//  ExposurePanel.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-16.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct ExposurePanel: View {
    @CameraControl(\.gain) var gain: DeviceControl
    @CameraControl(\.exposureMode) var exposureMode: DeviceControl
    @CameraControl(\.exposureTime) var exposureTime: DeviceControl

    var body: some View {
        Panel {
            VStack(spacing: 20) {
                SliderPanelLayout(
                    title: Text("control.shutter_speed"),
                    systemImage: "clock.fill",
                    valueLabel: shutterSpeedLabel,
                    auto: auto,
                    value: $exposureTime.value,
                    range: exposureTime.range
                )

                if !auto.wrappedValue {
                    HStack(spacing: 8) {
                        // Dummy toggle to offset layout.
                        PlainToggle(isOn: .constant(false))
                            .hidden()

                        ControlLayout(
                            title: PanelLabel(title: Text("control.sensor_gain"), systemImage: "bolt.fill"),
                            accessories: {
                                Text(verbatim: "+ \(gain.value)")
                                    .font(.caption.bold().monospacedDigit())
                                    .opacity(0.8)
                            }
                        ) {
                            MenuSlider(value: $gain.value, in: gain.range)
                                .disabled(auto.wrappedValue)
                        }
                    }
                }
            }
            .padding(12)
        }
        .onChange(of: auto.wrappedValue) { _ in
            gain.value = 0
        }
    }

    var auto: Binding<Bool> {
        Binding {
            exposureMode.value == .aperturePriority

        } set: { auto in
            withAnimation {
                exposureMode.value = auto ? .aperturePriority : .manual
            }
        }
    }

    var shutterSpeedLabel: String {
        let microseconds = exposureTime.value * 100

        guard microseconds > 0 else {
            return ""
        }

        let denominator = 1_000_000 / microseconds

        return denominator <= 1
            ? "\(microseconds / 1_000_000)"
            : "1 / \(denominator)"
    }
}

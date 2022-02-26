//
//  BrightnessPanel.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-24.
//

import SwiftUI

struct BrightnessPanel: View {
    @CameraControl(\.brightness) var brightness: DeviceControl
    @State var auto: Bool = true

    var body: some View {
        Panel {
            SliderPanelLayout(
                title: "Brightness",
                systemImage: "sun.max.fill",
                valueLabel: valueLabel,
                auto: $auto,
                value: $brightness.value,
                range: brightness.range
            )
            .padding(12)
        }
        .onChange(of: brightness.value) { newValue in
            if newValue != brightness.defaultValue {
                auto = false
            }
        }
        .onChange(of: auto) { autoEnabled in
            guard autoEnabled else {
                return
            }

            brightness.value = brightness.defaultValue
        }
    }

    var valueLabel: String {
        let percentage = brightness.value.percentage(in: brightness.range) * 100

        return "\(percentage.round(to: 0).stringRemovingTrailingZeros)%"
    }
}

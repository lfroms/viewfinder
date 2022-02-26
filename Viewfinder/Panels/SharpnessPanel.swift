//
//  SharpnessPanel.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-24.
//

import SwiftUI

struct SharpnessPanel: View {
    @CameraControl(\.sharpness) var sharpness: DeviceControl
    @State var auto: Bool = true

    var body: some View {
        Panel {
            SliderPanelLayout(
                title: "Sharpness",
                systemImage: "triangle.fill",
                valueLabel: valueLabel,
                auto: $auto,
                value: $sharpness.value,
                range: sharpness.range
            )
            .padding(12)
        }
        .onChange(of: sharpness.value) { newValue in
            if newValue != sharpness.defaultValue {
                auto = false
            }
        }
        .onChange(of: auto) { autoEnabled in
            guard autoEnabled else {
                return
            }

            sharpness.value = sharpness.defaultValue
        }
    }

    var valueLabel: String {
        let percentage = sharpness.value.percentage(in: sharpness.range) * 100

        return "\(percentage.round(to: 0).stringRemovingTrailingZeros)%"
    }
}

//
//  SaturationPanel.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-24.
//

import SwiftUI

struct SaturationPanel: View {
    @CameraControl(\.saturation) var saturation: DeviceControl
    @State var auto: Bool = true

    var body: some View {
        SliderPanelLayout(
            title: "Saturation",
            systemImage: "drop.fill",
            valueLabel: valueLabel,
            auto: $auto,
            value: $saturation.value,
            range: saturation.range
        )
        .onChange(of: saturation.value) { newValue in
            if newValue != saturation.defaultValue {
                auto = false
            }
        }
        .onChange(of: auto) { autoEnabled in
            guard autoEnabled else {
                return
            }

            saturation.value = saturation.defaultValue
        }
    }

    var valueLabel: String {
        let percentage = saturation.value.percentage(in: saturation.range) * 100

        return "\(percentage.round(to: 0).stringRemovingTrailingZeros)%"
    }
}

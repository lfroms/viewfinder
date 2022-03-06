//
//  ContrastPanel.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-24.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct ContrastPanel: View {
    @CameraControl(\.contrast) var contrast: DeviceControl
    @State var auto: Bool = true

    var body: some View {
        Panel {
            SliderPanelLayout(
                title: "Contrast",
                systemImage: "circle.lefthalf.filled",
                valueLabel: valueLabel,
                auto: $auto,
                value: $contrast.value,
                range: contrast.range
            )
            .padding(12)
        }
        .task {
            if contrast.value != contrast.defaultValue {
                auto = false
            }
        }
        .onChange(of: contrast.value) { newValue in
            if newValue != contrast.defaultValue {
                auto = false
            }
        }
        .onChange(of: auto) { autoEnabled in
            guard autoEnabled else {
                return
            }

            contrast.value = contrast.defaultValue
        }
    }

    var valueLabel: String {
        let percentage = contrast.value.percentage(in: contrast.range) * 100

        return "\(percentage.round(to: 0).stringRemovingTrailingZeros)%"
    }
}

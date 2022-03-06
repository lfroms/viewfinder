//
//  FocusPanel.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-24.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct FocusPanel: View {
    @CameraControl(\.focus) var focus: DeviceControl
    @CameraControl(\.focusAuto) var focusAuto: DeviceControl

    var body: some View {
        Panel {
            SliderPanelLayout(
                title: "Focus",
                systemImage: "cube.transparent",
                valueLabel: "",
                auto: $focusAuto.value,
                value: $focus.value,
                range: focus.range
            )
            .padding(12)
        }
    }
}

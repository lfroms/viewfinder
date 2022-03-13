//
//  WhiteBalancePanel.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-16.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct WhiteBalancePanel: View {
    @CameraControl(\.whiteBalance) var whiteBalance: DeviceControl
    @CameraControl(\.whiteBalanceAuto) var whiteBalanceAuto: DeviceControl

    var body: some View {
        Panel {
            SliderPanelLayout(
                title: "White Balance",
                systemImage: "lightbulb.fill",
                valueLabel: "\(whiteBalance.value)K",
                auto: $whiteBalanceAuto.value,
                value: $whiteBalance.value,
                range: whiteBalance.range
            )
            .padding(12)
        }
    }
}

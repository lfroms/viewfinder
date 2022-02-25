//
//  WhiteBalancePanel.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-16.
//

import SwiftUI

struct WhiteBalancePanel: View {
    @CameraControl(\.whiteBalance) var whiteBalance: DeviceControl
    @CameraControl(\.whiteBalanceAuto) var whiteBalanceAuto: DeviceControl

    var body: some View {
        SliderPanelLayout(
            title: "White Balance",
            systemImage: "slider.horizontal.3",
            valueLabel: "\(whiteBalance.value)K",
            auto: $whiteBalanceAuto.value,
            value: $whiteBalance.value,
            range: whiteBalance.range
        )
    }
}

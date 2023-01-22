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
            ControlLayout(
                title: PanelLabel(title: Text("control.white_balance"), systemImage: "lightbulb.fill"),
                accessories: {
                    Text(verbatim: "\(whiteBalance.value)K")
                        .font(.caption.bold().monospacedDigit())
                        .foregroundStyle(.secondary)

                    if whiteBalanceAuto.value {
                        AutoBadge()
                            .transition(.opacity)
                    }
                }
            ) {
                HStack(spacing: 8) {
                    PlainToggle(isOn: $whiteBalanceAuto.value.animation())
                    MenuSlider(value: $whiteBalance.value, in: whiteBalance.range, trackStyle: .gradient(gradient))
                        .disabled(whiteBalanceAuto.value)
                }
            }
            .padding(12)
        }
    }

    private var gradient: LinearGradient {
        LinearGradient(
            stops: [.init(color: .blue, location: 0), .init(color: .yellow, location: 0.5), .init(color: .orange, location: 1)],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}

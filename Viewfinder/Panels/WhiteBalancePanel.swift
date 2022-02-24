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
        Panel {
            VStack(alignment: .center, spacing: 8) {
                HStack(alignment: .firstTextBaseline) {
                    Label("White Balance", systemImage: "slider.horizontal.3")
                        .font(.body.bold())

                    Spacer()

                    Text(verbatim: "\(whiteBalance.value)K")
                        .font(.caption.bold().monospacedDigit())
                        .opacity(0.8)

                    if whiteBalanceAuto.value {
                        AutoBadge()
                            .transition(.opacity)
                    }
                }

                HStack(spacing: 8) {
                    PlainToggle(isOn: $whiteBalanceAuto.value.animation())
                    MenuSlider(value: $whiteBalance.value, in: whiteBalance.range)
                        .disabled(whiteBalanceAuto.value)
                }
            }
            .padding(12)
        }
        .task {
            NotificationCenter.default.post(name: .readCameraValues, object: nil)
        }
    }
}

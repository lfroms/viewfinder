//
//  SliderPanelLayout.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-24.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct SliderPanelLayout: View {
    var title: Text
    var systemImage: String
    var valueLabel: String
    @Binding var auto: Bool
    @Binding var value: Int
    var range: ClosedRange<Int>

    var body: some View {
        ControlLayout(
            title: PanelLabel(title: title, systemImage: systemImage),
            accessories: {
                Text(verbatim: valueLabel)
                    .font(.caption.bold().monospacedDigit())
                    .opacity(0.8)

                if auto {
                    AutoBadge()
                        .transition(.opacity)
                }
            }
        ) {
            HStack(spacing: 8) {
                PlainToggle(isOn: $auto.animation())
                MenuSlider(value: $value, in: range)
                    .disabled(auto)
            }
        }
    }
}

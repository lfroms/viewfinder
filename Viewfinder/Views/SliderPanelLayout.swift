//
//  SliderPanelLayout.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-24.
//

import SwiftUI

struct SliderPanelLayout: View {
    var title: String
    var systemImage: String
    var valueLabel: String
    @Binding var auto: Bool
    @Binding var value: Int
    var range: ClosedRange<Int>

    var body: some View {
        Panel {
            VStack(alignment: .center, spacing: 8) {
                HStack(alignment: .firstTextBaseline) {
                    Label(title, systemImage: systemImage)
                        .font(.body.bold())

                    Spacer()

                    Text(verbatim: valueLabel)
                        .font(.caption.bold().monospacedDigit())
                        .opacity(0.8)

                    if auto {
                        AutoBadge()
                            .transition(.opacity)
                    }
                }

                HStack(spacing: 8) {
                    PlainToggle(isOn: $auto.animation())
                    MenuSlider(value: $value, in: range)
                        .disabled(auto)
                }
            }
            .padding(12)
        }
    }
}

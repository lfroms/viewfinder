//
//  ZoomPanel.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-16.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct ZoomPanel: View {
    @CameraControl(\.zoom) var zoom: DeviceControl

    @State var useDefault: Bool = true

    var body: some View {
        Panel {
            ControlLayout(
                title: PanelLabel(title: Text("control.zoom"), systemImage: "plus.magnifyingglass"),
                accessories: {
                    Text(verbatim: "\(zoom.value)")
                        .font(.caption.bold().monospacedDigit())
                        .foregroundStyle(.secondary)
                }
            ) {
                HStack(spacing: 8) {
                    PlainToggle(isOn: $useDefault.animation())
                    MenuSlider(value: $zoom.value, in: zoom.range)
                        .disabled(useDefault)
                }
            }
            .padding(12)
        }
        .task {
            if zoom.value != zoom.defaultValue {
                useDefault = false
            }
        }
        .onChange(of: zoom.value) { newValue in
            if newValue != zoom.defaultValue {
                useDefault = false
            }
        }
        .onChange(of: useDefault) { useDefaultEnabled in
            guard useDefaultEnabled else {
                return
            }

            zoom.value = zoom.defaultValue
        }
    }
}

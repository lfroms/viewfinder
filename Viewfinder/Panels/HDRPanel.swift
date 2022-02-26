//
//  HDRPanel.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-16.
//

import SwiftUI

struct HDRPanel: View {
    @CameraControl(\.hdr) var hdr: DeviceControl

    var body: some View {
        Panel {
            HStack(spacing: 8) {
                PanelTitle(text: "HDR", systemImage: "square.stack.3d.up.fill")
                Spacer()
                PlainToggle(isOn: enabled)
            }
            .padding(12)
        }
    }

    var enabled: Binding<Bool> {
        Binding {
            hdr.value > 0
        } set: {
            hdr.value = $0 ? hdr.range.upperBound : 0
        }
    }
}

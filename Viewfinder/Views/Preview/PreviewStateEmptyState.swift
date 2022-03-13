//
//  PreviewStateEmptyState.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-09.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct PreviewStateEmptyState: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    let state: PreviewState

    var body: some View {
        VStack(spacing: 8) {
            if case .initializing = state {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(colorScheme == .dark ? .white : .black)
                    .scaleEffect(0.7)
            }

            if let iconName = state.iconName {
                Image(systemName: iconName)
                    .font(.system(size: 28))
                    .opacity(0.6)
            }

            Group {
                if case .suspended(let deviceName) = state {
                    Text("\(deviceName) empty_state.camera_unavailable")
                }

                if case .noDevice = state {
                    Text("empty_state.no_camera_selected")
                }
            }
            .font(.callout.weight(.medium))
            .opacity(0.6)
        }
    }
}

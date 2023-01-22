//
//  PreviewStateEmptyState.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-09.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct PreviewStateEmptyState: View {
    let state: PreviewState

    var body: some View {
        VStack(spacing: 8) {
            if case .initializing = state {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(0.7)
            }

            if let iconName = state.iconName {
                Image(systemName: iconName)
                    .font(.system(size: 28))
                    .foregroundStyle(.tertiary)
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
            .foregroundStyle(.tertiary)
        }
    }
}

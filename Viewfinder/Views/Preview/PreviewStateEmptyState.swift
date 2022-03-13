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

            if let text = state.text {
                Text(text)
                    .font(.callout.weight(.medium))
                    .opacity(0.6)
            }
        }
    }
}

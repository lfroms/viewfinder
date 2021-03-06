//
//  ToggleableRowIcon.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-05.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct ToggleableRowIcon: View {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @Environment(\.buttonPressed) private var buttonPressed: Bool

    let systemName: String
    let selected: Bool

    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .foregroundColor(selected ? .blue : .primary.opacity(0.2))

            Image(systemName: systemName)
                .font(.callout)
                .foregroundColor(iconColor)
                .padding(.bottom, 1)
                .opacity(selected ? 1 : 0.7)

            if buttonPressed {
                Circle()
                    .foregroundColor(.primary.opacity(0.15))
            }
        }
        .frame(width: 27, height: 27)
    }

    private var iconColor: Color {
        if selected {
            return .white
        }

        return colorScheme == .dark ? .white : .black
    }
}

//
//  MenuItemButtonStyle.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-05.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct MenuItemButtonStyle: ButtonStyle {
    @State private var hovering = false

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.vertical, 4)
            .padding(.horizontal, 7)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                Color.primary
                    .opacity(hovering ? 0.15 : 0)
                    .cornerRadius(4)
                    .onBackgroundHover { hovering in
                        self.hovering = hovering
                    }
            )
            .environment(\.buttonPressed, configuration.isPressed)
    }
}

private struct ButtonPressedKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    var buttonPressed: Bool {
        get { self[ButtonPressedKey.self] }
        set { self[ButtonPressedKey.self] = newValue }
    }
}

//
//  MenuItemButtonStyle.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-05.
//

import SwiftUI

struct MenuItemButtonStyle: ButtonStyle {
    @State private var hovering = false

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 7)
            .padding(.vertical, 4)
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

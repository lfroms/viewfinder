//
//  CollapsibleSection.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-08.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct CollapsibleSection<Label: View, Content: View>: View {
    private let label: Label
    @Binding private var expanded: Bool
    private let content: () -> Content

    init(label: Label, expanded: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self.label = label
        self._expanded = expanded.animation(.interactiveSpring(response: 0.4, dampingFraction: 0.8, blendDuration: 0))
        self.content = content
    }

    var body: some View {
        VStack(spacing: 0) {
            Button(action: { expanded.toggle() }) {
                HStack {
                    label
                        .sectionHeaderTextStyle()
                        .padding(.vertical, 0.5)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.callout)
                        .rotationEffect(expanded ? .degrees(90) : .zero)
                }
            }
            .buttonStyle(MenuItemButtonStyle())

            content()
                .frame(height: expanded ? nil : 0, alignment: .bottom)
                .opacity(expanded ? 1 : 0)
                .clipped()
        }
    }
}

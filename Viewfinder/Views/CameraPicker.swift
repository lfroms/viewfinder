//
//  CameraPicker.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-05.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct CameraPicker: View {
    @State private var expanded = false

    var body: some View {
        VStack(spacing: 0) {
            Button(action: toggleExpanded) {
                HStack {
                    Text("Other Cameras")
                        .sectionHeaderTextStyle()

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.callout)
                        .rotationEffect(expanded ? .degrees(90) : .zero)
                        .padding(.trailing, 4)
                }
            }
            .buttonStyle(MenuItemButtonStyle())

            CameraList()
                .frame(height: expanded ? .none : 0, alignment: .bottom)
                .opacity(expanded ? 1 : 0)
                .clipped()
        }
        .padding(.horizontal, 5)
        .onAppear {
            if expanded {
                expanded = false
            }
        }
    }

    private func toggleExpanded() {
        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.8, blendDuration: 0)) {
            expanded.toggle()
        }
    }
}

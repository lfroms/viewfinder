//
//  MenuSliderControls.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-14.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct MenuSliderControls: View {
    @Environment(\.colorScheme) var colorScheme

    let offset: CGFloat
    let handleOpacity: CGFloat

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 11)
                .fill(Color.primary.opacity(0.2))

            if colorScheme == .light {
                RoundedRectangle(cornerRadius: 11)
                    .strokeBorder(Color.black.opacity(0.1), lineWidth: 1)
            }

            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .frame(width: offset + 20, height: 20, alignment: .leading)
                .padding(.leading, 1)

            Circle()
                .strokeBorder(Color.black.opacity(0.13), lineWidth: 1)
                .frame(width: 22, height: 22)
                .background(
                    Circle()
                        .fill(.white)
                        .frame(width: 20, height: 20, alignment: .center)
                        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 0)
                )
                .padding(.leading, offset)
                .opacity(handleOpacity)
        }
        .frame(height: 22)
    }
}

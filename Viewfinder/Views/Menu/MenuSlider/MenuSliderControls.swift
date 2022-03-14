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
    let isTracking: Bool
    var trackStyle: TrackStyle = .standard

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 11)
                .fill(Color.primary.opacity(0.2))

            if colorScheme == .light {
                RoundedRectangle(cornerRadius: 11)
                    .strokeBorder(Color.black.opacity(0.1), lineWidth: 1)
            }

            Group {
                switch trackStyle {
                case .standard:
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(width: offset + 20, height: 20, alignment: .leading)

                case .gradient(let gradient):
                    RoundedRectangle(cornerRadius: 10)
                        .fill(gradient)
                        .frame(height: 20, alignment: .leading)
                }
            }
            .padding(.horizontal, 1)

            Circle()
                .strokeBorder(Color.black.opacity(0.13), lineWidth: 1)
                .frame(width: 22, height: 22)
                .background(
                    Circle()
                        .fill(isTracking ? Color(white: 0.94) : .white)
                        .frame(width: 20, height: 20, alignment: .center)
                        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 0)
                )
                .padding(.leading, offset)
                .opacity(handleOpacity)
        }
        .frame(height: 22)
    }

    private var handleOpacity: CGFloat {
        if case .gradient = trackStyle {
            return 1
        }

        switch offset {
        case 0 ... 16:
            return offset / 16
        default:
            return 1
        }
    }
}

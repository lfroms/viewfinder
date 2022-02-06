//
//  StyledSlider.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-05.
//

import SwiftUI

struct StyledSlider: View {
    @Environment(\.colorScheme) private var colorScheme

    var imageName: String
    @Binding var value: Double

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 11)
                    .fill(Color.primary.opacity(0.2))

                if colorScheme == .light {
                    RoundedRectangle(cornerRadius: 11)
                        .strokeBorder(Color.black.opacity(0.1), lineWidth: 1)
                }

                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(width: leftOffset(totalWidth: proxy.size.width) + 20, height: 20, alignment: .leading)
                    .padding(.leading, 1)

                Circle()
                    .strokeBorder(Color.black.opacity(0.13), lineWidth: 1)
                    .frame(width: 22, height: 22)
                    .background(
                        Circle()
                            .fill(.white)
                            .frame(width: 20, height: 20, alignment: .center)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
                    )
                    .padding(.leading, leftOffset(totalWidth: proxy.size.width))
                    .opacity(handleOutlineOpacity(totalWidth: proxy.size.width))

                Image(systemName: imageName)
                    .foregroundColor(.black.opacity(0.65))
                    .font(.system(size: 10))
                    .frame(width: 22, height: 22, alignment: .center)
            }
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged { drag in
                    value = calculatePercentage(dragX: drag.location.x, totalWidth: proxy.size.width)
                })
            .frame(height: 22)
        }
    }

    private func handleOutlineOpacity(totalWidth: CGFloat) -> CGFloat {
        let leftOffset = leftOffset(totalWidth: totalWidth)

        switch leftOffset {
        case 0...16:
            return 0
        case 16...25:
            return (leftOffset - 16) / (25 - 16)
        default:
            return 1
        }
    }

    private func leftOffset(totalWidth: CGFloat) -> CGFloat {
        return value * (totalWidth - 22)
    }

    private func calculatePercentage(dragX: CGFloat, totalWidth: CGFloat) -> Double {
        return min(max((dragX - 11) / (totalWidth - 22), 0), 1)
    }
}

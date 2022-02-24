//
//  MenuSlider.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-05.
//

import SwiftUI

struct MenuSlider: View {
    @Environment(\.isEnabled) var isEnabled: Bool

    @State var percentage: Double = 0
    @Binding var value: Int
    var bounds: ClosedRange<Int>

    init(value: Binding<Int>, in bounds: ClosedRange<Int>) {
        self._value = value
        self.bounds = bounds

        self.percentage = convertToPercentage(absolute: value.wrappedValue)
    }

    var body: some View {
        GeometryReader { proxy in
            MenuSliderControls(
                offset: leftOffset(totalWidth: proxy.size.width),
                handleOpacity: handleOutlineOpacity(totalWidth: proxy.size.width)
            )
            .opacity(isEnabled ? 1 : 0.35)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged { drag in
                        guard isEnabled else {
                            return
                        }

                        percentage = calculatePercentage(dragX: drag.location.x, totalWidth: proxy.size.width)
                    }
            )
        }
        .onChange(of: value) { newValue in
            withAnimation {
                self.percentage = convertToPercentage(absolute: newValue)
            }
        }
        .onChange(of: percentage) { newValue in
            self.value = convertToAbsolute(percentage: newValue)
        }
    }

    private func convertToPercentage(absolute absoluteValue: Int) -> Double {
        Double(absoluteValue - bounds.lowerBound) / Double(bounds.upperBound - bounds.lowerBound)
    }

    private func convertToAbsolute(percentage: Double) -> Int {
        Int(Float(bounds.lowerBound) + (Float(bounds.upperBound - bounds.lowerBound) * Float(percentage)))
    }

    private func handleOutlineOpacity(totalWidth: CGFloat) -> CGFloat {
        let leftOffset = leftOffset(totalWidth: totalWidth)

        switch leftOffset {
        case 0 ... 16:
            return leftOffset / 16
        default:
            return 1
        }
    }

    private func leftOffset(totalWidth: CGFloat) -> CGFloat {
        return CGFloat(percentage) * (totalWidth - 22)
    }

    private func calculatePercentage(dragX: CGFloat, totalWidth: CGFloat) -> Double {
        return min(max((dragX - 11) / (totalWidth - 22), 0), 1)
    }
}

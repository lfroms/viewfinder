//
//  MenuSlider.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-05.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct MenuSlider: View {
    @Environment(\.isEnabled) var isEnabled: Bool

    @State private var percentage: Double
    @Binding private var value: Int
    private var bounds: ClosedRange<Int>
    private var trackStyle: TrackStyle = .standard

    @GestureState private var isDragging: Bool = false

    init(value: Binding<Int>, in bounds: ClosedRange<Int>, trackStyle: TrackStyle = .standard) {
        self._value = value
        self.bounds = bounds
        self.percentage = value.wrappedValue.percentage(in: bounds)
        self.trackStyle = trackStyle
    }

    var body: some View {
        GeometryReader { proxy in
            MenuSliderControls(
                offset: leftOffset(totalWidth: proxy.size.width),
                isTracking: isDragging,
                trackStyle: trackStyle
            )
            .opacity(isEnabled ? 1 : 0.35)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .updating($isDragging) { _, state, _ in
                        state = true
                    }
                    .onChanged { drag in
                        guard isEnabled else {
                            return
                        }

                        percentage = calculatePercentage(dragX: drag.location.x, totalWidth: proxy.size.width)
                    }
            )
        }
        .frame(height: 22) // Value defined in MenuSliderControls
        .onChange(of: value) { newValue in
            guard !isDragging else {
                return
            }

            withAnimation {
                self.percentage = newValue.percentage(in: bounds)
            }
        }
        .onChange(of: percentage) { newValue in
            self.value = newValue.percentageToAbsolute(in: bounds)
        }
    }

    private func leftOffset(totalWidth: CGFloat) -> CGFloat {
        return CGFloat(percentage) * (totalWidth - 22)
    }

    private func calculatePercentage(dragX: CGFloat, totalWidth: CGFloat) -> Double {
        return min(max((dragX - 11) / (totalWidth - 22), 0), 1)
    }
}

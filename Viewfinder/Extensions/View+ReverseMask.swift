//
//  View+ReverseMask.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-05.
//

import SwiftUI

public extension View {
    @inlinable
    func reverseMask<Mask: View>(
        alignment: Alignment = .center,
        @ViewBuilder _ mask: () -> Mask
    ) -> some View {
        self.mask {
            Rectangle()
                .overlay(alignment: alignment) {
                    mask()
                        .blendMode(.destinationOut)
                }
        }
    }
}

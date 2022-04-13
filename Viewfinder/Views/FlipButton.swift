//
//  FlipButton.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-04-12.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct FlipButton: View {
    let activated: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "arrow.left.and.right.righttriangle.left.righttriangle.right.fill")
                .font(.caption)
                .foregroundColor(activated ? .black : .white)
                .padding(Dimension.Menu.padding)
                .background(
                    Circle()
                        .foregroundColor(activated ? .white : .init(white: 0.3, opacity: 0.8))
                )
        }
        .buttonStyle(.plain)
        .padding(Dimension.Menu.inset)
        .transaction { transaction in
            transaction.animation = nil
        }
    }
}

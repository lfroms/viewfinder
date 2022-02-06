//
//  Panel.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-05.
//

import SwiftUI

struct Panel<Content>: View where Content: View {
    let content: () -> Content
    let cornerRadius: CGFloat = 10
    let shadowPadding: CGFloat = 12

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        content()
            .background(.white.opacity(0.03))
            .cornerRadius(cornerRadius)
            .clipped()
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(.white.opacity(0.15), lineWidth: 0.5)
            )
            .padding(shadowPadding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(.black)
                    .padding(shadowPadding)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 0)
                    .reverseMask {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .padding(shadowPadding)

                    })
            .padding(-shadowPadding)
    }
}

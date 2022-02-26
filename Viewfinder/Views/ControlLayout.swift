//
//  ControlLayout.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-26.
//

import SwiftUI

struct ControlLayout<TitleContent: View, AccessoriesContent: View, Content: View>: View {
    let title: TitleContent
    let accessories: () -> AccessoriesContent
    let content: () -> Content

    init(
        title: TitleContent,
        @ViewBuilder accessories: @escaping () -> AccessoriesContent,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.accessories = accessories
        self.content = content
    }

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            HStack(alignment: .firstTextBaseline) {
                title

                Spacer()

                accessories()
            }

            content()
        }
    }
}

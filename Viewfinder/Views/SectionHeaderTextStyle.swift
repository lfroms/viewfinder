//
//  SectionHeaderTextStyle.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-05.
//

import SwiftUI

struct SectionHeaderTextStyle: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    func body(content: Content) -> some View {
        content
            .font(.callout.weight(.semibold))
            .foregroundColor(.primary.opacity(colorScheme == .dark ? 0.6 : 0.8))
    }
}

extension View {
    func sectionHeaderTextStyle() -> some View {
        modifier(SectionHeaderTextStyle())
    }
}

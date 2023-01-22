//
//  SectionHeaderTextStyle.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-05.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct SectionHeaderTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.callout.weight(.semibold))
            .foregroundColor(.secondary)
    }
}

extension View {
    func sectionHeaderTextStyle() -> some View {
        modifier(SectionHeaderTextStyle())
    }
}

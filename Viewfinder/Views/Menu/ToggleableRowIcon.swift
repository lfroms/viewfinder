//
//  ToggleableRowIcon.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-05.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct ToggleableRowIcon: View {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @Environment(\.buttonPressed) private var buttonPressed: Bool

    let systemName: String
    let selected: Bool

    var body: some View {
        Image(systemName: systemName)
            .font(.callout)
            .padding(.bottom, 1)
            .foregroundColor(selected ? .white : .secondary)
            .frame(width: 26, height: 26, alignment: .center)
            .background(.quaternary.opacity(selected ? 0 : 1))
            .background(.blue.opacity(selected ? 1 : 0))
            .overlay(.primary.opacity(buttonPressed ? 0.15 : 0))
            .cornerRadius(.infinity)
    }
}

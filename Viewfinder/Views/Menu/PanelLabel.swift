//
//  PanelLabel.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-26.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct PanelLabel: View {
    let title: Text
    let systemImage: String

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 6) {
            Image(systemName: systemImage)
                .frame(width: 20)

            title
        }
        .font(.body.bold())
    }
}

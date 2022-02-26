//
//  PanelTitle.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-26.
//

import SwiftUI

struct PanelTitle: View {
    let text: String
    let systemImage: String

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 6) {
            Image(systemName: systemImage)
                .frame(width: 20)

            Text(text)
        }
        .font(.body.bold())
    }
}

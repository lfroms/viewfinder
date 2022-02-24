//
//  AutoBadge.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-24.
//

import SwiftUI

struct AutoBadge: View {
    var body: some View {
        Text("Auto")
            .font(.caption.bold())
            .foregroundColor(.orange)
            .padding(.horizontal, 5)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .strokeBorder(.orange)
                    .padding(.vertical, -2)
            )
    }
}

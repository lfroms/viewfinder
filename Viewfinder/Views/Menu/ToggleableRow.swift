//
//  ToggleableRow.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-04.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct ToggleableRow: View {
    let title: Text
    let icon: ToggleableRowIcon
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(alignment: .center) {
                icon
                title
                Spacer()
            }
        }
        .buttonStyle(MenuItemButtonStyle())
    }
}

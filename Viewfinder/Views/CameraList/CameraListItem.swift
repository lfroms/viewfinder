//
//  CameraListItem.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-04.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct CameraListItem: View {
    let name: String
    let selected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(alignment: .center) {
                CameraListItemIcon(selected: selected)

                Text(name)

                Spacer()
            }
        }
        .buttonStyle(MenuItemButtonStyle())
    }
}

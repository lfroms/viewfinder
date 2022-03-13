//
//  CameraPicker.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-05.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct CameraPicker: View {
    @State private var expanded = false

    var body: some View {
        CollapsibleSection(label: Text("All Cameras"), expanded: $expanded) {
            CameraList()
        }
        .onAppear {
            if expanded {
                expanded = false
            }
        }
    }
}

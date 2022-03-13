//
//  UnsupportedWebcamEmptyState.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-05.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct UnsupportedWebcamEmptyState: View {
    var body: some View {
        VStack(spacing: 3) {
            Spacer()

            Text("empty_state.no_uvc.title")
                .font(.title2.bold())
                .opacity(0.6)

            Text("empty_state.no_camera.description")
                .font(.caption.bold())
                .opacity(0.6)

            Spacer()
        }
    }
}

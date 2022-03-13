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

            Text("Unsupported Webcam")
                .font(.title2.bold())
                .opacity(0.6)

            Text("Connect a UVC-compliant webcam to control its settings.")
                .font(.caption.bold())
                .opacity(0.6)

            Spacer()
        }
    }
}

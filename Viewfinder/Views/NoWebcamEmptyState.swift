//
//  NoWebcamEmptyState.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-03.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct NoWebcamEmptyState: View {
    var body: some View {
        VStack(spacing: 3) {
            Spacer()

            Text("No UVC Webcam Found")
                .font(.title2.bold())
                .opacity(0.6)

            Text("Connect a UVC-compliant webcam to control its settings.")
                .font(.caption.bold())
                .opacity(0.6)

            Spacer()
        }
    }
}

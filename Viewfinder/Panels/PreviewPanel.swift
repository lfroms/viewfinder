//
//  PreviewPanel.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-05.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct PreviewPanel: View {
    @EnvironmentObject var deviceManager: DeviceManager

    var body: some View {
        Panel {
            ZStack {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.white)
                    .transition(.opacity)

                PreviewContainer(captureSession: deviceManager.captureSession)
                    .aspectRatio(16 / 9, contentMode: .fit)
            }
        }
    }
}

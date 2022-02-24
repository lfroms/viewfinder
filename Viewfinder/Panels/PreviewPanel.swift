//
//  PreviewPanel.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-05.
//

import SwiftUI

struct PreviewPanel: View {
    @EnvironmentObject var deviceService: DeviceManager

    var body: some View {
        Panel {
            ZStack {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.white)
                    .transition(.opacity)

                if let captureSession = deviceService.captureSession {
                    PreviewContainer(captureSession: captureSession)
                        .aspectRatio(16 / 9, contentMode: .fit)
                }
            }
        }
    }
}

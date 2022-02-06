//
//  PreviewPanel.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-05.
//

import SwiftUI

struct PreviewPanel: View {
    @ObservedObject private var viewModel = PreviewPanelViewModel()

    var body: some View {
        Panel {
            ZStack {
                if !viewModel.running {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                        .transition(.opacity)
                }

                PreviewContainer(captureSession: viewModel.captureSession)
                    .aspectRatio(16 / 9, contentMode: .fit)
                    .onAppear {
                        Task {
                            viewModel.startSession()
                        }
                    }
                    .onDisappear {
                        Task {
                            viewModel.stopSession()
                        }
                    }
            }
        }
    }
}

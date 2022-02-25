//
//  ContentView.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-03.
//

import SwiftUI

struct ContentView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 0) {
            PreviewPanel()
                .padding(12)

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 12) {
                    WhiteBalancePanel()
                }
                .padding(12)
            }
        }
        .onReceive(timer) { _ in
            Task {
                NotificationCenter.default.post(name: .readCameraValues, object: nil)
            }
        }
    }
}

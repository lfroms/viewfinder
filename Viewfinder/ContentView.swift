//
//  ContentView.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-03.
//

import SwiftUI

struct ContentView: View {
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
    }
}

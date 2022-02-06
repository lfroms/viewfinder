//
//  ContentView.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-03.
//

import SwiftUI

struct ContentView: View {
    @State var value: Double = 0

    var body: some View {
        VStack {
            PreviewPanel()

            StyledSlider(imageName: "timer", value: $value)

            Spacer()
        }
        .padding(14)
    }
}

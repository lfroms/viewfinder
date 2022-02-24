//
//  PlainToggle.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-24.
//

import SwiftUI

struct PlainToggle: View {
    @Binding var isOn: Bool

    var body: some View {
        Toggle("", isOn: $isOn)
            .toggleStyle(.switch)
            .labelsHidden()
            .fixedSize()
    }
}

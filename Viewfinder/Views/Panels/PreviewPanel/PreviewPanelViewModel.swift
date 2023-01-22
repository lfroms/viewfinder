//
//  PreviewPanelViewModel.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-04-12.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import Combine
import SwiftUI

class PreviewPanelViewModel: ObservableObject {
    @AppStorage("mirrorVideoPreview") var mirrorVideoPreview: Bool = false
    @Published var hovering: Bool = false
    @Published var previewActive: Bool = false

    func didChangeHoverState(hovering: Bool) {
        withAnimation(.easeInOut(duration: 0.2)) {
            self.hovering = hovering
        }
    }

    func didPressMirrorVideoButton() {
        withAnimation(.easeInOut) {
            mirrorVideoPreview.toggle()
        }
    }
}

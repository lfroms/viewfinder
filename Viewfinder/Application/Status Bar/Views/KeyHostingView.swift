//
//  KeyHostingView.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-13.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

class KeyHostingView<Content: View>: NSHostingView<Content> {
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        // Ensure that the menu receives and propagates clicks.
        window?.becomeKey()
    }
}

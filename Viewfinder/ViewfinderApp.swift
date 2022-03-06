//
//  ViewfinderApp.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-03.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

@main
struct ViewfinderApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

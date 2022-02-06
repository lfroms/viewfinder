//
//  ViewfinderApp.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-03.
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

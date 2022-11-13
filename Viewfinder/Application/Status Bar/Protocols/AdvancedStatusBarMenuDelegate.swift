//
//  AdvancedStatusBarMenuDelegate.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-13.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import AppKit
import Foundation

@objc
protocol AdvancedStatusBarMenuDelegate {
    func didPressAboutItem(_ sender: Any?)
    func didPressCheckForUpdatesItem(_ sender: Any?)

    @available(macOS 13.0, *)
    func didPressOpenAtLoginItem(_ sender: NSMenuItem)

    func didPressQuitItem(_ sender: Any?)
}

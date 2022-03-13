//
//  AdvancedStatusBarMenu.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-13.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import AppKit

final class AdvancedStatusBarMenu: StatusBarMenu {
    var delegate: AdvancedStatusBarMenuDelegate?

    let menu: NSMenu

    init() {
        self.menu = NSMenu()

        setupAboutItem()
        setupCheckForUpdatesItem()
        menu.addItem(.separator())
        setupQuitItem()
    }

    private func setupAboutItem() {
        menu.addItem(withTitle: "About Viewfinder", action: #selector(delegate?.didPressAboutItem(_:)), keyEquivalent: "")
    }

    private func setupCheckForUpdatesItem() {
        menu.addItem(withTitle: "Check for Updates…", action: #selector(delegate?.didPressCheckForUpdatesItem(_:)), keyEquivalent: "")
    }

    private func setupQuitItem() {
        menu.addItem(withTitle: "Quit Viewfinder", action: #selector(delegate?.didPressQuitItem(_:)), keyEquivalent: "")
    }
}

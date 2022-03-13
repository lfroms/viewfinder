//
//  StatusBarApplication.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-13.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import AppKit

final class StatusBarApplication {
    private let statusBarItem = NSStatusBar.system.statusItem(
        withLength: NSStatusItem.variableLength
    )

    private let mainMenu = MainStatusBarMenu()
    private let advancedMenu = AdvancedStatusBarMenu()

    var delegate: StatusBarApplicationDelegate? {
        didSet {
            mainMenu.delegate = delegate
            advancedMenu.delegate = delegate
        }
    }

    init() {
        setupSubmenuItems()
        setupStatusBarItem()
    }

    private func setupSubmenuItems() {
        mainMenu.addSubmenu(
            withTitle: NSLocalizedString("menu.advanced", comment: "Advanced menu title."),
            menu: advancedMenu
        )
    }

    private func setupStatusBarItem() {
        statusBarItem.menu = mainMenu.menu
        statusBarItem.button?.image = NSImage(systemSymbolName: "camera.fill", accessibilityDescription: nil)
    }
}

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
        let localizedString = NSLocalizedString("menu.advanced.about", comment: "About item in the Advanced menu.")
        let title = String(format: localizedString, "Viewfinder")

        menu.addItem(withTitle: title, action: #selector(delegate?.didPressAboutItem(_:)), keyEquivalent: "")
    }

    private func setupCheckForUpdatesItem() {
        let title = NSLocalizedString(
            "menu.advanced.check_for_updates",
            comment: "Check for updates item in the Advanced menu."
        )

        menu.addItem(withTitle: title, action: #selector(delegate?.didPressCheckForUpdatesItem(_:)), keyEquivalent: "")
    }

    private func setupQuitItem() {
        let localizedString = NSLocalizedString("menu.advanced.quit", comment: "Quit item in the Advanced menu.")
        let title = String(format: localizedString, "Viewfinder")

        menu.addItem(withTitle: title, action: #selector(delegate?.didPressQuitItem(_:)), keyEquivalent: "")
    }
}

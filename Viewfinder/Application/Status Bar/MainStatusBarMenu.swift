//
//  MainStatusBarMenu.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-13.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import AppKit

final class MainStatusBarMenu: NSObject, StatusBarMenu {
    var delegate: MainStatusBarMenuDelegate?

    let menu: NSMenu

    override init() {
        self.menu = NSMenu()
        super.init()

        menu.delegate = self

        setupContentView()
    }

    func addSubmenu<TMenu: StatusBarMenu>(withTitle title: String, menu submenu: TMenu) {
        let item = NSMenuItem(title: title, action: nil, keyEquivalent: "")
        item.submenu = submenu.menu
        menu.addItem(item)
    }

    private func setupContentView() {
        let contentView = KeyHostingView(
            rootView: ContentView()
                .environmentObject(DeviceManager.shared)
                .padding(.top, -4) // Compensate for internal margins.
        )

        contentView.frame = NSRect(x: 0, y: 0, width: 380, height: 650)

        let item = NSMenuItem()
        item.view = contentView

        menu.addItem(item)
    }
}

extension MainStatusBarMenu: NSMenuDelegate {
    func menuWillOpen(_ menu: NSMenu) {
        delegate?.menuWillOpen()
    }

    func menuDidClose(_ menu: NSMenu) {
        delegate?.menuDidClose()
    }
}

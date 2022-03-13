//
//  AdvancedStatusBarMenuDelegate.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-13.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import Foundation

@objc
protocol AdvancedStatusBarMenuDelegate {
    func didPressAboutItem(_ sender: Any?)
    func didPressCheckForUpdatesItem(_ sender: Any?)
    func didPressQuitItem(_ sender: Any?)
}

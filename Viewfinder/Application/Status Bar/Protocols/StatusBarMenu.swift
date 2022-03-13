//
//  StatusBarMenu.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-13.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import AppKit

protocol StatusBarMenu {
    associatedtype DelegateType

    var delegate: DelegateType? { get set }
    var menu: NSMenu { get }
}

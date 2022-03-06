//
//  UVCRangeControllable.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-23.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

public protocol UVCRangeControllable: UVCControllable {
    var maximum: ValueType { get }
    var minimum: ValueType { get }
}

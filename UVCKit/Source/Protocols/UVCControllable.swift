//
//  UVCControllable.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-23.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

public protocol UVCControllable {
    associatedtype ValueType: Equatable

    var value: ValueType { get set }
    var defaultValue: ValueType { get }
}

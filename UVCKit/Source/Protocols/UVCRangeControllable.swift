//
//  UVCRangeControllable.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-23.
//

public protocol UVCRangeControllable: UVCControllable {
    var maximum: ValueType { get }
    var minimum: ValueType { get }
}

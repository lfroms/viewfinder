//
//  UVCControllable.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-23.
//

public protocol UVCControllable {
    associatedtype ValueType: Equatable

    var value: ValueType { get set }
    var defaultValue: ValueType { get }
}

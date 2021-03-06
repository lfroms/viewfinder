//
//  UVCControl.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-09.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

public class UVCControl {
    internal let length: Int

    private let interface: USBInterface
    private let selector: UVCSelector

    init(
        interface: USBInterface,
        length: Int,
        selector: UVCSelector
    ) {
        self.interface = interface
        self.length = length
        self.selector = selector
    }

    internal func read(requestType: UVCRequestCode, length: Int) throws -> Int {
        let value = try UVCRequest.read(
            interface: interface,
            request: requestType,
            selector: selector,
            length: length
        )

        return value
    }

    internal func write(value: Int, length: Int) throws -> Int {
        let value = try UVCRequest.write(
            interface: interface,
            request: .setCurrent,
            selector: selector,
            value: value,
            length: length
        )

        return value
    }
}

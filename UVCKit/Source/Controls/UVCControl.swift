//
//  UVCControl.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-09.
//

public class UVCControl {
    internal let length: Int

    private let interface: USBInterface
    private let selector: UVCSelector

    public lazy var available: Bool = {
        let value = try? read(requestType: .getInfo, length: 1) != 0
        return value ?? false
    }()

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

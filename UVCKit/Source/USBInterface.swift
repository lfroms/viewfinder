//
//  USBInterface.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-08.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

typealias USBInterfacePointer = UnsafeMutablePointer<UnsafeMutablePointer<IOUSBInterfaceInterface190>>

class USBInterface: Identifiable {
    let pointer: USBInterfacePointer

    lazy var id: UInt8 = {
        var value: UInt8 = 0
        _ = pointer.pointee.pointee.GetInterfaceNumber(pointer, &value)
        return value
    }()

    init(pointer: USBInterfacePointer) {
        self.pointer = pointer
    }

    deinit {
        _ = pointer.pointee.pointee.Release(pointer)
    }
}

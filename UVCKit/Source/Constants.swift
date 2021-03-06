//
//  Constants.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-08.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

let kIOUSBDeviceUserClientTypeID: CFUUID = CFUUIDGetConstantUUIDWithBytes(
    kCFAllocatorDefault,
    0x9d, 0xc7, 0xb7, 0x80,
    0x9e, 0xc0, 0x11, 0xd4,
    0xa5, 0x4f, 0x00, 0x0a,
    0x27, 0x05, 0x28, 0x61
)

let kIOUSBDeviceInterfaceID: CFUUID = CFUUIDGetConstantUUIDWithBytes(
    kCFAllocatorDefault,
    0x5c, 0x81, 0x87, 0xd0,
    0x9e, 0xf3, 0x11, 0xd4,
    0x8b, 0x45, 0x00, 0x0a,
    0x27, 0x05, 0x28, 0x61
)

let kIOUSBInterfaceInterfaceID: CFUUID = CFUUIDGetConstantUUIDWithBytes(
    kCFAllocatorDefault,
    0x73, 0xc9, 0x7a, 0xe8,
    0x9e, 0xf3, 0x11, 0xd4,
    0xb1, 0xd0, 0x00, 0x0a,
    0x27, 0x05, 0x28, 0x61
)

let kIOUSBInterfaceUserClientTypeID: CFUUID = CFUUIDGetConstantUUIDWithBytes(
    kCFAllocatorDefault,
    0x2d, 0x97, 0x86, 0xc6,
    0x9e, 0xf3, 0x11, 0xd4,
    0xad, 0x51, 0x00, 0x0a,
    0x27, 0x05, 0x28, 0x61
)

let kIOCFPlugInInterfaceID: CFUUID = CFUUIDGetConstantUUIDWithBytes(
    kCFAllocatorDefault,
    0xc2, 0x44, 0xe8, 0x58,
    0x10, 0x9c, 0x11, 0xd4,
    0x91, 0xd4, 0x00, 0x50,
    0xe4, 0xc6, 0x42, 0x6f
)

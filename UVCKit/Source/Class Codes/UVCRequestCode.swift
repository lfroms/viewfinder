//
//  UVCRequestCode.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-07.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//
//  UVC Video Class-Specific Request Codes
//  https://www.usb.org/document-library/video-class-v15-document-set
//

enum UVCRequestCode: UInt8 {
    case setCurrent = 0x01
    case getCurrent = 0x81
    case getMinimum = 0x82
    case getMaximum = 0x83
    case getResolution = 0x84
    case getLength = 0x85
    case getInfo = 0x86
    case getDefault = 0x87
}

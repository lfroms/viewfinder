//
//  UVCVideoClassDescriptorType.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-07.
//
//  UVC Video Class-Specific Descriptor Types
//  https://www.usb.org/document-library/video-class-v15-document-set
//

enum UVCVideoClassDescriptorType: Int {
    case device = 0x21
    case configuration = 0x22
    case string = 0x23
    case interface = 0x24
    case endpoint = 0x25
}

//
//  UVCDescriptorSubtype.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-07.
//
//  UVC Video Class-Specific VC Interface Descriptor Subtypes
//  https://www.usb.org/document-library/video-class-v15-document-set
//

enum UVCDescriptorSubtype: UInt8 {
    case inputTerminal = 0x02
    case selectorUnit = 0x04
    case processingUnit = 0x05
    case extensionUnit = 0x06
}

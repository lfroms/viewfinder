//
//  UVCVideoInterfaceSubclassCode.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-07.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//
//  UVC Video Interface Subclass Codes
//  https://www.usb.org/document-library/video-class-v15-document-set
//

enum UVCVideoInterfaceSubclassCode: UInt16 {
    case videoControl = 0x01
    case videoStreaming = 0x02
    case videoInterfaceCollection = 0x03
}

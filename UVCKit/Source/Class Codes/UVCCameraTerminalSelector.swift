//
//  UVCCameraTerminalSelector.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-07.
//
//  UVC Camera Terminal Control Selectors
//  https://www.usb.org/document-library/video-class-v15-document-set
//

enum UVCCameraTerminalSelector: Int {
    case scanningMode = 0x01
    case aeMode = 0x02
    case aePriority = 0x03
    case exposureTimeAbsolute = 0x04
    case exposureTimeRelative = 0x05
    case focusAbsolute = 0x06
    case focusRelative = 0x07
    case focusAuto = 0x08
    case irisAbsolute = 0x09
    case irisRelative = 0x0a
    case zoomAbsolute = 0x0b
    case zoomRelative = 0x0c
    case panTiltAbsolute = 0x0d
    case panTiltRelative = 0x0e
    case rollAbsolute = 0x0f
    case rollRelative = 0x10
    case privacy = 0x11
    case focusSimple = 0x12
    case digitalWindow = 0x13
    case regionOfInterest = 0x14
}

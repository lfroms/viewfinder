//
//  UVCProcessingUnitSelector.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-07.
//
//  UVC Processing Unit Control Selectors
//  https://www.usb.org/document-library/video-class-v15-document-set
//

enum UVCProcessingUnitSelector: Int {
    case backlightCompensation = 0x01
    case brightness = 0x02
    case contrast = 0x03
    case gain = 0x04
    case powerlineFrequency = 0x05
    case hue = 0x06
    case saturation = 0x07
    case sharpness = 0x08
    case gamma = 0x09
    case whiteBalanceTemperature = 0x0a
    case whiteBalanceTemperatureAuto = 0x0b
    case whiteBalanceComponent = 0x0c
    case whiteBalanceComponentAuto = 0x0d
    case digitalMultiplier = 0x0e
    case digitalMultiplierLimit = 0x0f
    case hueAuto = 0x10
    case analogVideoStandard = 0x11
    case analogLockStatus = 0x12
    case contrastAuto = 0x13
}

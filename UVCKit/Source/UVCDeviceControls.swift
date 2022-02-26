//
//  UVCDeviceControls.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-06.
//

public class UVCDeviceControls {
    public let scanningMode: UVCBoolControl
    public let exposureMode: UVCBitmapControl<UVCAutoExposureMode>
    public let exposurePriority: UVCIntControl
    public let exposureTime: UVCIntControl
    public let focusAbsolute: UVCIntControl
    public let focusAuto: UVCBoolControl
    public let irisAbsolute: UVCIntControl
    public let zoomAbsolute: UVCIntControl
    public let rollAbsolute: UVCIntControl

    public let backlightCompensation: UVCIntControl
    public let brightness: UVCIntControl
    public let contrast: UVCIntControl
    public let contrastAuto: UVCBoolControl
    public let gain: UVCIntControl
    public let powerLineFrequency: UVCIntControl
    public let hue: UVCIntControl
    public let hueAuto: UVCBoolControl
    public let saturation: UVCIntControl
    public let sharpness: UVCIntControl
    public let gamma: UVCIntControl
    public let whiteBalance: UVCIntControl
    public let whiteBalanceAuto: UVCBoolControl

    init(interface: USBInterface, descriptor: UVCDeviceDescriptor) {
        let cameraTerminal: (UVCCameraTerminalSelector) -> UVCSelector = { selector in
            .cameraTerminal(selector, unitId: descriptor.cameraTerminalId)
        }

        let processingUnit: (UVCProcessingUnitSelector) -> UVCSelector = { selector in
            .processingUnit(selector, unitId: descriptor.processingUnitId)
        }

        // MARK: Camera Terminal

        scanningMode = UVCBoolControl(
            interface: interface,
            length: 1,
            selector: cameraTerminal(.scanningMode)
        )
        exposureMode = UVCBitmapControl(
            interface: interface,
            length: 1,
            selector: cameraTerminal(.aeMode)
        )
        exposurePriority = UVCIntControl(
            interface: interface,
            length: 1,
            selector: cameraTerminal(.aePriority)
        )
        exposureTime = UVCIntControl(
            interface: interface,
            length: 4,
            selector: cameraTerminal(.exposureTimeAbsolute)
        )
        focusAbsolute = UVCIntControl(
            interface: interface,
            length: 2,
            selector: cameraTerminal(.focusAbsolute)
        )
        focusAuto = UVCBoolControl(
            interface: interface,
            length: 1,
            selector: cameraTerminal(.focusAuto)
        )
        irisAbsolute = UVCIntControl(
            interface: interface,
            length: 2,
            selector: cameraTerminal(.irisAbsolute)
        )
        zoomAbsolute = UVCIntControl(
            interface: interface,
            length: 2,
            selector: cameraTerminal(.zoomAbsolute)
        )
        rollAbsolute = UVCIntControl(
            interface: interface,
            length: 2,
            selector: cameraTerminal(.rollAbsolute)
        )

        // MARK: Processing Unit

        backlightCompensation = UVCIntControl(
            interface: interface,
            length: 2,
            selector: processingUnit(.backlightCompensation)
        )
        brightness = UVCIntControl(
            interface: interface,
            length: 2,
            selector: processingUnit(.brightness)
        )
        contrast = UVCIntControl(
            interface: interface,
            length: 2,
            selector: processingUnit(.contrast)
        )
        contrastAuto = UVCBoolControl(
            interface: interface,
            length: 1,
            selector: processingUnit(.contrastAuto)
        )
        gain = UVCIntControl(
            interface: interface,
            length: 2,
            selector: processingUnit(.gain)
        )
        powerLineFrequency = UVCIntControl(
            interface: interface,
            length: 2,
            selector: processingUnit(.powerlineFrequency)
        )
        hue = UVCIntControl(
            interface: interface,
            length: 2,
            selector: processingUnit(.hue)
        )
        hueAuto = UVCBoolControl(
            interface: interface,
            length: 1,
            selector: processingUnit(.hueAuto)
        )
        saturation = UVCIntControl(
            interface: interface,
            length: 2,
            selector: processingUnit(.saturation)
        )
        sharpness = UVCIntControl(
            interface: interface,
            length: 2,
            selector: processingUnit(.sharpness)
        )
        gamma = UVCIntControl(
            interface: interface,
            length: 2,
            selector: processingUnit(.gamma)
        )
        whiteBalance = UVCIntControl(
            interface: interface,
            length: 2,
            selector: processingUnit(.whiteBalanceTemperature)
        )
        whiteBalanceAuto = UVCBoolControl(
            interface: interface,
            length: 1,
            selector: processingUnit(.whiteBalanceTemperatureAuto)
        )
    }
}

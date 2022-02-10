//
//  UVCDeviceControls.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-06.
//

public class UVCDeviceControls {
    public var scanningMode: UVCBoolControl
    public var exposureMode: UVCBitmapControl<UVCAutoExposureMode>
    public var exposurePriority: UVCIntControl
    public var exposureTime: UVCIntControl
    public var focusAbsolute: UVCIntControl
    public var focusAuto: UVCBoolControl
    public var irisAbsolute: UVCIntControl
    public var zoomAbsolute: UVCIntControl
    public var panTiltAbsolute: UVCCoordinateControl
    public var rollAbsolute: UVCIntControl

    public var backlightCompensation: UVCIntControl
    public var brightness: UVCIntControl
    public var contrast: UVCIntControl
    public var contrastAuto: UVCBoolControl
    public var gain: UVCIntControl
    public var powerLineFrequency: UVCIntControl
    public var hue: UVCIntControl
    public var hueAuto: UVCBoolControl
    public var saturation: UVCIntControl
    public var sharpness: UVCIntControl
    public var gamma: UVCIntControl
    public var whiteBalance: UVCIntControl
    public var whiteBalanceAuto: UVCBoolControl

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
        panTiltAbsolute = UVCCoordinateControl(
            interface: interface,
            length: 8,
            selector: cameraTerminal(.panTiltAbsolute)
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

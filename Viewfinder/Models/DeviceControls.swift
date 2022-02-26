//
//  DeviceControls.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-23.
//

import Foundation
import UVCKit

final class DeviceControls: ObservableObject {
    private let controls: UVCDeviceControls

    lazy var whiteBalance = DeviceControl(control: controls.whiteBalance)
    lazy var whiteBalanceAuto = DeviceControl(control: controls.whiteBalanceAuto)
    lazy var brightness = DeviceControl(control: controls.brightness)
    lazy var contrast = DeviceControl(control: controls.contrast)
    lazy var saturation = DeviceControl(control: controls.saturation)
    lazy var sharpness = DeviceControl(control: controls.sharpness)
    lazy var focus = DeviceControl(control: controls.focusAbsolute)
    lazy var focusAuto = DeviceControl(control: controls.focusAuto)
    lazy var gain = DeviceControl(control: controls.gain)
    lazy var zoom = DeviceControl(control: controls.zoomAbsolute)
    lazy var exposureMode = DeviceControl(control: controls.exposureMode)
    lazy var exposureTime = DeviceControl(control: controls.exposureTime)
    lazy var hdr = DeviceControl(control: controls.backlightCompensation)

    init(controls: UVCDeviceControls) {
        self.controls = controls
    }
}

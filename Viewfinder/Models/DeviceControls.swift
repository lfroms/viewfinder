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
    lazy var contrastAuto = DeviceControl(control: controls.contrastAuto)
    lazy var saturation = DeviceControl(control: controls.saturation)
    lazy var sharpness = DeviceControl(control: controls.sharpness)
    lazy var focus = DeviceControl(control: controls.focusAbsolute)
    lazy var focusAuto = DeviceControl(control: controls.focusAuto)

    init(controls: UVCDeviceControls) {
        self.controls = controls
    }
}

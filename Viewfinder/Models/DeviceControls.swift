//
//  DeviceControls.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-23.
//

import Foundation
import UVCKit

final class DeviceControls: ObservableObject {
    let whiteBalance: DeviceControl<UVCIntControl>
    let whiteBalanceAuto: DeviceControl<UVCBoolControl>

    init(device: Device) {
        let controls = device.uvc.controls

        self.whiteBalance = DeviceControl(control: controls.whiteBalance)
        self.whiteBalanceAuto = DeviceControl(control: controls.whiteBalanceAuto)
    }
}

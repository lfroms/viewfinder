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

    init(controls: UVCDeviceControls) {
        self.whiteBalance = DeviceControl(control: controls.whiteBalance)
        self.whiteBalanceAuto = DeviceControl(control: controls.whiteBalanceAuto)
    }
}

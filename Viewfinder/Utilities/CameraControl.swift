//
//  CameraControl.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-22.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI
import UVCKit

@propertyWrapper
struct CameraControl<T: UVCControllable>: DynamicProperty {
    @ObservedObject private var deviceControl: DeviceControl<T>

    init(_ keyPath: KeyPath<DeviceControls, DeviceControl<T>>) {
        guard let primaryDeviceControls = DeviceManager.shared.currentDevice?.controls else {
            // Controls that use these values should not be rendered anyways.
            fatalError("No primary device found, or, primary device does not support UVC.")
        }

        self.deviceControl = primaryDeviceControls[keyPath: keyPath]
    }

    var wrappedValue: DeviceControl<T> {
        get {
            deviceControl
        }
        mutating set {
            deviceControl = newValue
        }
    }

    var projectedValue: ObservedObject<DeviceControl<T>>.Wrapper {
        return $deviceControl
    }
}

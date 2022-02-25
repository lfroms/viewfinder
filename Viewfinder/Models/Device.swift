//
//  Device.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-10.
//

import AVFoundation
import UVCKit

struct Device {
    private let uvc: UVCDevice
    let input: AVCaptureDeviceInput
    let controls: DeviceControls

    init?(device: AVCaptureDevice) {
        guard
            let input = try? AVCaptureDeviceInput(device: device),
            let uvcDevice = UVCDevice(captureDevice: device)
        else {
            return nil
        }

        self.input = input
        self.uvc = uvcDevice
        self.controls = DeviceControls(controls: uvc.controls)
    }
}

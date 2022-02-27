//
//  Device.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-10.
//

import AVFoundation
import UVCKit

struct Device {
    let uvc: UVCDevice?
    let id: String
    let controls: DeviceControls?
    let avCaptureDevice: AVCaptureDevice

    init(device: AVCaptureDevice) {
        self.id = device.uniqueID
        self.uvc = UVCDevice(captureDevice: device)

        if let uvc = uvc {
            self.controls = DeviceControls(controls: uvc.controls)
        } else {
            self.controls = nil
        }

        self.avCaptureDevice = device
    }
}

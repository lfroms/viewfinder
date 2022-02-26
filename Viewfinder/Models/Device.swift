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
    let id: String
    let controls: DeviceControls
    let avCaptureDevice: AVCaptureDevice

    init?(device: AVCaptureDevice) {
        guard let uvcDevice = UVCDevice(captureDevice: device) else {
            return nil
        }

        self.id = device.uniqueID
        self.uvc = uvcDevice
        self.controls = DeviceControls(controls: uvc.controls)
        self.avCaptureDevice = device
    }
}

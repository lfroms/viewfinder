//
//  CameraList.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-05.
//

import SwiftUI

struct CameraList: View {
    @EnvironmentObject private var deviceManager: DeviceManager

    var body: some View {
        VStack(spacing: 0) {
            ForEach(deviceManager.devices, id: \.id) { device in
                CameraListItem(
                    name: device.avCaptureDevice.localizedName,
                    selected: deviceManager.currentDevice?.id == device.id,
                    action: {
                        deviceManager.currentDevice = device
                    }
                )
                .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

//
//  CameraList.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-05.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

struct CameraList: View {
    @EnvironmentObject private var deviceManager: DeviceManager

    var body: some View {
        VStack(spacing: 0) {
            ForEach(deviceManager.connectedDevices, id: \.id) { device in
                ToggleableRow(
                    title: Text(device.avCaptureDevice.localizedName),
                    icon: ToggleableRowIcon(systemName: "camera.fill", selected: isSelected(device: device)),
                    action: {
                        deviceManager.switchCurrentDevice(to: device)
                    }
                )
                .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private func isSelected(device: Device) -> Bool {
        deviceManager.currentDevice?.id == device.id
    }
}

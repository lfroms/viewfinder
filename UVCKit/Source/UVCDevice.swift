//
//  UVCDevice.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-06.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import AVFoundation
import Foundation
import IOKit.usb

public class UVCDevice {
    private let interface: USBInterface
    public let controls: UVCDeviceControls
    public let cameraTerminalCapabilities: UVCCameraTerminal.Capabilities
    public let processingUnitCapabilities: UVCProcessingUnit.Capabilities

    public init?(captureDevice: AVCaptureDevice) {
        guard let cameraInformation = UVCDeviceInformation(modelId: captureDevice.modelID) else {
            return nil
        }

        let serviceInformation = IOServiceMatching("IOUSBDevice") as NSMutableDictionary
        serviceInformation["idVendor"] = cameraInformation.vendorId
        serviceInformation["idProduct"] = cameraInformation.productId

        var usbInterface: USBInterfacePointer?
        let camera: io_service_t = IOServiceGetMatchingService(kIOMainPortDefault, serviceInformation)

        defer {
            let code = IOObjectRetain(camera)
            assert(code == kIOReturnSuccess)
        }

        var configurationDescriptor: IOUSBConfigurationDescriptorPtr?

        try? camera.ioCreatePublicInterface(for: kIOUSBDeviceUserClientTypeID) { pluginInterface in
            let deviceInterface: UnsafeMutablePointer<UnsafeMutablePointer<IOUSBDeviceInterface>> =
                try pluginInterface.getInterface(uuid: kIOUSBDeviceInterfaceID)

            defer {
                _ = deviceInterface.pointee.pointee.Release(deviceInterface)
            }

            let interfaceRequest = IOUSBFindInterfaceRequest(
                bInterfaceClass: UVCVideoInterfaceClassCode.video.rawValue,
                bInterfaceSubClass: UVCVideoInterfaceSubclassCode.videoControl.rawValue,
                bInterfaceProtocol: UInt16(kIOUSBFindInterfaceDontCare),
                bAlternateSetting: UInt16(kIOUSBFindInterfaceDontCare)
            )

            try deviceInterface.iterate(interfaceRequest: interfaceRequest) { interfaceOfDeviceInterface in
                usbInterface = try interfaceOfDeviceInterface.getInterface(uuid: kIOUSBInterfaceInterfaceID)
            }

            var numConfig: UInt8 = 0
            let numberOfConfigurationsResult
                = deviceInterface.pointee.pointee.GetNumberOfConfigurations(deviceInterface, &numConfig)

            if numberOfConfigurationsResult != kIOReturnSuccess {
                return
            }

            let configurationDescriptorResult
                = deviceInterface.pointee.pointee.GetConfigurationDescriptorPtr(deviceInterface, 0, &configurationDescriptor)

            if configurationDescriptorResult != kIOReturnSuccess {
                return
            }
        }

        guard
            let descriptor = configurationDescriptor?.descriptor,
            let usbInterface = usbInterface
        else {
            return nil
        }

        self.interface = USBInterface(pointer: usbInterface)
        self.controls = UVCDeviceControls(interface: interface, descriptor: descriptor)
        self.cameraTerminalCapabilities = descriptor.cameraTerminal.capabilities
        self.processingUnitCapabilities = descriptor.processingUnit.capabilities
    }
}

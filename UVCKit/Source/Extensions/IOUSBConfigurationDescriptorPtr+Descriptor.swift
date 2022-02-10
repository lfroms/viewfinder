//
//  IOUSBConfigurationDescriptorPtr+Descriptor.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-06.
//
//  Originally written by Itay Brenner on 2020-07-20. Code has been lightly refactord. Adapted from:
//  https://github.com/Itaybre/CameraController/blob/50747fb07880a15e175cd4d98adfa028df7ebe42/CameraController/UVC/Extensions/IOUSBConfigurationDescriptorPtr+UVC.swift
//

import IOKit

typealias InterfaceDescriptorPointer = UnsafeMutablePointer<UVC_InterfaceDescriptorHdr>
typealias ProcessingUnitDescriptorPointer = UnsafeMutablePointer<UVC_ProcessingUnitDescriptor>
typealias CameraTerminalDescriptorPointer = UnsafeMutablePointer<UVC_CameraTerminalDescriptor>

extension IOUSBConfigurationDescriptorPtr {
    var descriptor: UVCDeviceDescriptor {
        var processingUnitID = -1
        var cameraTerminalID = -1

        let remaining = self.pointee.wTotalLength - UInt16(self.pointee.bLength)
        var pointer = UnsafeMutablePointer<UInt8>(OpaquePointer(self))
        pointer = pointer.advanced(by: Int(self.pointee.bLength))

        self.browseDescriptor(remaining, pointer, &processingUnitID, &cameraTerminalID)

        return UVCDeviceDescriptor(
            cameraTerminalId: cameraTerminalID,
            processingUnitId: processingUnitID
        )
    }

    private func browseDescriptor(
        _ memory: UInt16,
        _ pointer: UnsafeMutablePointer<UInt8>,
        _ processingUnitID: inout Int,
        _ cameraTerminalID: inout Int
    ) {
        var remaining = memory
        var currentPointer = pointer

        while remaining > 0 {
            var descriptorPointer = InterfaceDescriptorPointer(OpaquePointer(currentPointer))

            if descriptorPointer.pointee.bDescriptorType == kUSBInterfaceDesc {
                let intDesc = UnsafeMutablePointer<IOUSBInterfaceDescriptor>(OpaquePointer(descriptorPointer))
                if !(
                    intDesc.pointee.bInterfaceClass == UVCVideoInterfaceClassCode.video.rawValue
                        && intDesc.pointee.bInterfaceSubClass == UVCVideoInterfaceSubclassCode.videoControl.rawValue
                ) {
                    currentPointer = currentPointer.advanced(by: Int(intDesc.pointee.bLength))
                    continue
                }

                currentPointer = currentPointer.advanced(by: Int(intDesc.pointee.bLength))
                descriptorPointer = InterfaceDescriptorPointer(OpaquePointer(currentPointer))

                if descriptorPointer.pointee.bDescriptorType != UVCVideoClassDescriptorType.interface.rawValue {
                    break
                }

                let internalDescriptor = UnsafeMutablePointer<UVC_VCHeaderDescriptor>(OpaquePointer(descriptorPointer))

                if internalDescriptor.pointee.bDescriptorSubType == UVCVideoInterfaceSubclassCode.videoControl.rawValue {
                    let littleEndian = Int(internalDescriptor.pointee.wTotalLength).littleEndian
                    internalDescriptor.pointee.wTotalLength = UInt16(littleEndian)

                    remaining -= internalDescriptor.pointee.wTotalLength
                    currentPointer = currentPointer.advanced(by: Int(internalDescriptor.pointee.bLength))
                    var remainingMemory = internalDescriptor.pointee.wTotalLength
                        - UInt16(internalDescriptor.pointee.bLength)

                    while remainingMemory > 0 {
                        descriptorPointer = InterfaceDescriptorPointer(OpaquePointer(currentPointer))

                        if descriptorPointer.pointee.bDescriptorType != UVCVideoClassDescriptorType.interface.rawValue {
                            break
                        }

                        self.getDeviceId(descriptorPointer, currentPointer, &processingUnitID, &cameraTerminalID)

                        if processingUnitID != -1, cameraTerminalID != -1 {
                            // Found all necessary data, exit
                            // Fix for WB7022 Camera
                            return
                        }

                        remainingMemory -= UInt16(descriptorPointer.pointee.bLength)
                        currentPointer = currentPointer.advanced(by: Int(descriptorPointer.pointee.bLength))
                    }
                } else {
                    remaining -= UInt16(descriptorPointer.pointee.bLength)
                    currentPointer = currentPointer.advanced(by: Int(descriptorPointer.pointee.bLength))
                }

                break
            } else {
                remaining -= UInt16(descriptorPointer.pointee.bLength)
                currentPointer = currentPointer.advanced(by: Int(descriptorPointer.pointee.bLength))
            }
        }
    }

    private func getDeviceId(
        _ descriptorPointer: InterfaceDescriptorPointer,
        _ currentPointer: UnsafeMutablePointer<UInt8>,
        _ processingUnitID: inout Int,
        _ cameraTerminalID: inout Int
    ) {
        let unitType = UVCDescriptorSubtype(rawValue: descriptorPointer.pointee.bDescriptorSubType)

        switch unitType {
        case .processingUnit:
            let puPointer = ProcessingUnitDescriptorPointer(OpaquePointer(currentPointer))
            processingUnitID = Int(puPointer.pointee.bUnitID)
        case .inputTerminal:
            let ctPointer = CameraTerminalDescriptorPointer(OpaquePointer(currentPointer))
            cameraTerminalID = Int(ctPointer.pointee.bTerminalID)
        case .none:
            break
        case .selectorUnit:
            break
        case .extensionUnit:
            break
        }
    }
}

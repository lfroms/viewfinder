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
    var descriptor: UVCVideoControlInterfaceDescriptors {
        var processingUnitId = -1
        var cameraTerminalId = -1
        var processingUnitBmControls = -1
        var cameraTerminalBmControls = -1

        let remaining = self.pointee.wTotalLength - UInt16(self.pointee.bLength)
        var pointer = UnsafeMutablePointer<UInt8>(OpaquePointer(self))
        pointer = pointer.advanced(by: Int(self.pointee.bLength))

        self.browseDescriptor(remaining, pointer, &processingUnitId, &cameraTerminalId, &processingUnitBmControls, &cameraTerminalBmControls)

        return UVCVideoControlInterfaceDescriptors(
            cameraTerminal: UVCCameraTerminal(id: cameraTerminalId, bmControls: cameraTerminalBmControls),
            processingUnit: UVCProcessingUnit(id: processingUnitId, bmControls: processingUnitBmControls)
        )
    }

    private func browseDescriptor(
        _ memory: UInt16,
        _ pointer: UnsafeMutablePointer<UInt8>,
        _ processingUnitId: inout Int,
        _ cameraTerminalId: inout Int,
        _ processingUnitBmControls: inout Int,
        _ cameraTerminalBmControls: inout Int
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

                        self.parseDescriptor(
                            descriptorPointer,
                            currentPointer,
                            &processingUnitId,
                            &cameraTerminalId,
                            &processingUnitBmControls,
                            &cameraTerminalBmControls
                        )

                        if processingUnitId != -1, cameraTerminalId != -1, processingUnitBmControls != -1, cameraTerminalBmControls != -1 {
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

    private func parseDescriptor(
        _ descriptorPointer: InterfaceDescriptorPointer,
        _ currentPointer: UnsafeMutablePointer<UInt8>,
        _ processingUnitId: inout Int,
        _ cameraTerminalId: inout Int,
        _ processingUnitBmControls: inout Int,
        _ cameraTerminalBmControls: inout Int
    ) {
        let unitType = UVCDescriptorSubtype(rawValue: descriptorPointer.pointee.bDescriptorSubType)

        switch unitType {
        case .processingUnit:
            let puPointer = ProcessingUnitDescriptorPointer(OpaquePointer(currentPointer))
            processingUnitId = Int(puPointer.pointee.bUnitID)
            processingUnitBmControls = Int((puPointer.pointee.bmControls << 8) >> 8)

        case .inputTerminal:
            let ctPointer = CameraTerminalDescriptorPointer(OpaquePointer(currentPointer))
            cameraTerminalId = Int(ctPointer.pointee.bTerminalID)
            cameraTerminalBmControls = Int((ctPointer.pointee.bmControls << 8) >> 8)

        case .none:
            break
        case .selectorUnit:
            break
        case .extensionUnit:
            break
        }
    }
}

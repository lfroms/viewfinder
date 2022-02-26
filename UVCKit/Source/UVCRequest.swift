//
//  UVCRequest.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-08.
//

enum UVCRequest {
    static func read(
        interface: USBInterface,
        request: UVCRequestCode,
        selector: UVCSelector,
        length: Int
    ) throws -> Int {
        let requestType = createRequestType(direction: kUSBIn, type: kUSBClass, recipient: kUSBInterface)

        let value = try UVCRequest.perform(
            interface: interface,
            requestType: requestType,
            requestCode: request.rawValue,
            value: UInt16(selector.value<<8),
            index: UInt16(selector.unitId<<8) | UInt16(interface.id),
            length: UInt16(length)
        )

        return value
    }

    static func write(
        interface: USBInterface,
        request: UVCRequestCode,
        selector: UVCSelector,
        value: Int,
        length: Int
    ) throws -> Int {
        let requestType = createRequestType(direction: kUSBOut, type: kUSBClass, recipient: kUSBInterface)

        let value = try UVCRequest.perform(
            interface: interface,
            requestType: requestType,
            requestCode: request.rawValue,
            value: UInt16(selector.value<<8),
            index: UInt16(selector.unitId<<8) | UInt16(interface.id),
            length: UInt16(length),
            data: value
        )

        return Int(value)
    }

    private static func perform(
        interface: USBInterface,
        requestType: UInt8,
        requestCode: UInt8,
        value: UInt16,
        index: UInt16,
        length: UInt16,
        data: Int = 0
    ) throws -> Int {
        var data = data

        try withUnsafeMutablePointer(to: &data) { data in
            var request = IOUSBDevRequest(
                bmRequestType: requestType,
                bRequest: requestCode,
                wValue: value,
                wIndex: index,
                wLength: length,
                pData: data,
                wLenDone: 0
            )

            let controlRequestResult = interface.pointer.pointee.pointee.ControlRequest(interface.pointer, 0, &request)

            guard controlRequestResult == kIOReturnSuccess else {
                throw NSError(domain: #file, code: #line, userInfo: nil)
            }
        }

        return data
    }

    private static func createRequestType(direction: Int, type: Int, recipient: Int) -> UInt8 {
        return UInt8((direction & kUSBRqDirnMask)<<kUSBRqDirnShift) |
            UInt8((type & kUSBRqTypeMask)<<kUSBRqTypeShift) | UInt8(recipient & kUSBRqRecipientMask)
    }
}

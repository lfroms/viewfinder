//
//  UnsafeMutablePointer+Iterate.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-07.
//
//  Originally written by Itay Brenner on 2020-07-20. Code has been lightly refactord. Adapted from:
//  https://github.com/Itaybre/CameraController/blob/50747fb07880a15e175cd4d98adfa028df7ebe42/CameraController/UVC/Extensions/UnsafeMutablePointer+interface.swift
//

extension UnsafeMutablePointer where Pointee == UnsafeMutablePointer<IOUSBDeviceInterface> {
    func iterate(
        interfaceRequest: IOUSBFindInterfaceRequest,
        handle: (UnsafeMutablePointer<UnsafeMutablePointer<IOCFPlugInInterface>>) throws -> Void
    ) rethrows {
        var iterator: io_iterator_t = 0

        var interfaceRequest = interfaceRequest

        try withUnsafeMutablePointer(to: &interfaceRequest) { mutatingPointer in
            guard pointee.pointee.CreateInterfaceIterator(self, mutatingPointer, &iterator) == kIOReturnSuccess else {
                return
            }

            defer {
                let code: kern_return_t = IOObjectRelease(iterator)
                assert(code == kIOReturnSuccess)
            }

            while true {
                let object: io_service_t = IOIteratorNext(iterator)

                defer {
                    let code: kern_return_t = IOObjectRelease(object)
                    assert(code == kIOReturnSuccess)
                }

                guard object > 0 else {
                    break
                }

                try object.ioCreatePublicInterface(
                    for: kIOUSBInterfaceUserClientTypeID,
                    handle: handle
                )
            }
        }
    }
}

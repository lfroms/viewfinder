//
//  io_service_t+IOCreatePublicInterface.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-06.
//  Copyright © 2020 Itaysoft. All rights reserved.
//  Copyright © 2022 Lukas Romsicki.
//
//  Originally written by Itay Brenner on 2020-07-20. Code has been modified from its original form. Adapted from:
//  https://github.com/Itaybre/CameraController/blob/50747fb07880a15e175cd4d98adfa028df7ebe42/CameraController/UVC/Extensions/io_service_t+Interface.swift
//  Licensed under GPL-3.0.
//

typealias PluginInterfacePointer = UnsafeMutablePointer<UnsafeMutablePointer<IOCFPlugInInterface>>

extension io_service_t {
    func ioCreatePublicInterface(for service: CFUUID, handle: (PluginInterfacePointer) throws -> Void) rethrows {
        var ref: UnsafeMutablePointer<UnsafeMutablePointer<IOCFPlugInInterface>?>?
        var score: Int32 = 0

        let createPluginInterfaceResult = IOCreatePlugInInterfaceForService(
            self,
            service,
            kIOCFPlugInInterfaceID,
            &ref,
            &score
        )

        guard createPluginInterfaceResult == kIOReturnSuccess, score == 0 else {
            return
        }

        defer {
            _ = ref?.pointee?.pointee.Release(ref)
        }

        try ref?.withMemoryRebound(to: UnsafeMutablePointer<IOCFPlugInInterface>.self, capacity: 1, handle)
    }
}

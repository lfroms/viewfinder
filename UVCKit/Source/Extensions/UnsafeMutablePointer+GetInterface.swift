//
//  UnsafeMutablePointer+GetInterface.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-06.
//
//  Originally written by Itay Brenner on 2020-07-20. Code has been lightly refactord. Adapted from:
//  https://github.com/Itaybre/CameraController/blob/50747fb07880a15e175cd4d98adfa028df7ebe42/CameraController/UVC/Extensions/UnsafeMutablePointer+interface.swift
//

extension UnsafeMutablePointer where Pointee == UnsafeMutablePointer<IOCFPlugInInterface> {
    func getInterface<T>(uuid: CFUUID) throws -> UnsafeMutablePointer<T> {
        var ref: LPVOID?

        guard
            pointee.pointee.QueryInterface(self, CFUUIDGetUUIDBytes(uuid), &ref) == kIOReturnSuccess,
            let result: UnsafeMutablePointer<T> = ref?.assumingMemoryBound(to: T.self)
        else {
            throw NSError(domain: #function, code: #line, userInfo: nil)
        }

        return result
    }
}

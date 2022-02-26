//
//  SignedInteger+ByteArray.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-08.
//

extension SignedInteger {
    var byteArray: [UInt8] {
        var length = [UInt8](repeating: 0, count: 8)

        for index in 0 ... 7 {
            length[index] = UInt8(0x0000FF & self >> Int((7 - index) * 8))
        }

        return length
    }
}

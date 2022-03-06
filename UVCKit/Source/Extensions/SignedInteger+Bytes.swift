//
//  SignedInteger+Bytes.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-08.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

extension SignedInteger {
    init(_ bytes: [UInt8]) {
        precondition(bytes.count <= MemoryLayout<Self>.size)

        var value: Int32 = 0

        for byte in bytes {
            value <<= 8
            value |= Int32(byte)
        }

        self.init(value)
    }
}

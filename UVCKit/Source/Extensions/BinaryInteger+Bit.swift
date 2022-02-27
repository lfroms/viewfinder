//
//  BinaryInteger+Bit.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-26.
//

extension BinaryInteger {
    func bit(at index: Int) -> Bool {
        return (self >> index) & 1 == 1
    }
}

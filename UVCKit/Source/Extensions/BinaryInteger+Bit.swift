//
//  BinaryInteger+Bit.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-26.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

extension BinaryInteger {
    func bit(at index: Int) -> Bool {
        return (self >> index) & 1 == 1
    }
}

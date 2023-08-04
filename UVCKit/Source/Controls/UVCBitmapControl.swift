//
//  UVCBitmapControl.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-09.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

public class UVCBitmapControl<BitmapValue: UVCBitmapValue>: UVCControl, UVCControllable {
    private let fallbackValue: BitmapValue

    init(interface: USBInterface, length: Int, selector: UVCSelector, fallbackValue: BitmapValue) {
        self.fallbackValue = fallbackValue
        super.init(interface: interface, length: length, selector: selector)
    }

    public lazy var defaultValue: BitmapValue = {
        guard
            let value = try? read(requestType: .getDefault, length: length),
            let bitmapValue = BitmapValue(rawValue: value)
        else {
            return fallbackValue
        }

        return bitmapValue
    }()

    public var value: BitmapValue {
        get {
            guard
                let value = try? read(requestType: .getCurrent, length: length),
                let bitmapValue = BitmapValue(rawValue: value)
            else {
                return defaultValue
            }

            return bitmapValue
        }

        set {
            _ = try? write(value: newValue.rawValue, length: length)
        }
    }
}

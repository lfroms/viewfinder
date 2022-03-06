//
//  UVCBitmapControl.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-09.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

public class UVCBitmapControl<BitmapValue: UVCBitmapValue>: UVCControl, UVCControllable {
    public lazy var defaultValue: BitmapValue = {
        guard
            let value = try? read(requestType: .getDefault, length: length),
            let bitmapValue = BitmapValue(rawValue: value)
        else {
            return BitmapValue(rawValue: 0)!
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

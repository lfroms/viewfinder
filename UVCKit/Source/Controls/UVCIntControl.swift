//
//  UVCIntControl.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-09.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

public class UVCIntControl: UVCControl, UVCControllable, UVCRangeControllable {
    public lazy var defaultValue: Int = {
        let value = try? read(requestType: .getDefault, length: length)
        return value ?? 0
    }()

    public lazy var resolution: Int = {
        let value = try? read(requestType: .getResolution, length: length)
        return value ?? 0
    }()

    public lazy var minimum: Int = {
        let value = try? read(requestType: .getMinimum, length: length)
        return value ?? 0
    }()

    public lazy var maximum: Int = {
        let value = try? read(requestType: .getMaximum, length: length)
        return value ?? 0
    }()

    public var value: Int {
        get {
            let value = try? read(requestType: .getCurrent, length: length)
            return value ?? 0
        }

        set {
            _ = try? write(value: newValue, length: length)
        }
    }
}

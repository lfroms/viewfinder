//
//  UVCBoolControl.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-09.
//

public class UVCBoolControl: UVCControl {
    public lazy var defaultValue: Bool = {
        let value = try? read(requestType: .getDefault, length: length) != 0
        return value ?? false
    }()

    public var value: Bool {
        get {
            let value = try? read(requestType: .getCurrent, length: length) != 0
            return value ?? false
        }

        set {
            _ = try? write(value: newValue ? 1 : 0, length: length)
        }
    }
}

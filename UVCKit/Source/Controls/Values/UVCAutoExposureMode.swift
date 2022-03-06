//
//  UVCAutoExposureMode.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-09.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

public enum UVCAutoExposureMode: Int, UVCBitmapValue {
    case manual = 0b00000001
    case auto = 0b00000010
    case shutterPriority = 0b00000100
    case aperturePriority = 0b00001000
}

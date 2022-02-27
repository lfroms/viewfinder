//
//  UVCProcessingUnit.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-26.
//

public struct UVCProcessingUnit {
    let id: Int
    let capabilities: Capabilities

    init(id: Int, bmControls: Int) {
        self.id = id
        capabilities = Capabilities(integerBitmap: bmControls)
    }

    public struct Capabilities {
        public let brightness: Bool
        public let contrast: Bool
        public let hue: Bool
        public let saturation: Bool
        public let sharpness: Bool
        public let gamma: Bool
        public let whiteBalanceTemperature: Bool
        public let whiteBalanceComponent: Bool
        public let backlightCompensation: Bool
        public let gain: Bool
        public let powerLineFrequency: Bool
        public let hueAuto: Bool
        public let whiteBalanceTemperatureAuto: Bool
        public let whiteBalanceComponentAuto: Bool
        public let digitalMultiplier: Bool
        public let digitalMultiplierLimit: Bool
        public let analogVideoStandard: Bool
        public let analogVideoLockStatus: Bool
        public let contrastAuto: Bool

        init(integerBitmap: Int) {
            brightness = integerBitmap.bit(at: 0)
            contrast = integerBitmap.bit(at: 1)
            hue = integerBitmap.bit(at: 2)
            saturation = integerBitmap.bit(at: 3)
            sharpness = integerBitmap.bit(at: 4)
            gamma = integerBitmap.bit(at: 5)
            whiteBalanceTemperature = integerBitmap.bit(at: 6)
            whiteBalanceComponent = integerBitmap.bit(at: 7)
            backlightCompensation = integerBitmap.bit(at: 8)
            gain = integerBitmap.bit(at: 9)
            powerLineFrequency = integerBitmap.bit(at: 10)
            hueAuto = integerBitmap.bit(at: 11)
            whiteBalanceTemperatureAuto = integerBitmap.bit(at: 12)
            whiteBalanceComponentAuto = integerBitmap.bit(at: 13)
            digitalMultiplier = integerBitmap.bit(at: 14)
            digitalMultiplierLimit = integerBitmap.bit(at: 15)
            analogVideoStandard = integerBitmap.bit(at: 16)
            analogVideoLockStatus = integerBitmap.bit(at: 17)
            contrastAuto = integerBitmap.bit(at: 18)
        }
    }
}

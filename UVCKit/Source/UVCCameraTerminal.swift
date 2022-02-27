//
//  UVCCameraTerminal.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-26.
//

public struct UVCCameraTerminal {
    let id: Int
    let capabilities: Capabilities

    init(id: Int, bmControls: Int) {
        self.id = id
        capabilities = Capabilities(integerBitmap: bmControls)
    }

    public struct Capabilities {
        public let scanningMode: Bool
        public let autoExposureMode: Bool
        public let autoExposurePriority: Bool
        public let exposureTimeAbsolute: Bool
        public let exposureTimeRelative: Bool
        public let focusAbsolute: Bool
        public let focusRelative: Bool
        public let irisAbsolute: Bool
        public let irisRelative: Bool
        public let zoomAbsolute: Bool
        public let zoomRelative: Bool
        public let panTiltAbsolute: Bool
        public let panTiltRelative: Bool
        public let rollAbsolute: Bool
        public let rollRelative: Bool
        public let focusAuto: Bool
        public let privacy: Bool
        public let focusSimple: Bool
        public let window: Bool
        public let regionOfInterest: Bool

        init(integerBitmap: Int) {
            scanningMode = integerBitmap.bit(at: 0)
            autoExposureMode = integerBitmap.bit(at: 1)
            autoExposurePriority = integerBitmap.bit(at: 2)
            exposureTimeAbsolute = integerBitmap.bit(at: 3)
            exposureTimeRelative = integerBitmap.bit(at: 4)
            focusAbsolute = integerBitmap.bit(at: 5)
            focusRelative = integerBitmap.bit(at: 6)
            irisAbsolute = integerBitmap.bit(at: 7)
            irisRelative = integerBitmap.bit(at: 8)
            zoomAbsolute = integerBitmap.bit(at: 9)
            zoomRelative = integerBitmap.bit(at: 10)
            panTiltAbsolute = integerBitmap.bit(at: 11)
            panTiltRelative = integerBitmap.bit(at: 12)
            rollAbsolute = integerBitmap.bit(at: 13)
            rollRelative = integerBitmap.bit(at: 14)
            focusAuto = integerBitmap.bit(at: 17)
            privacy = integerBitmap.bit(at: 18)
            focusSimple = integerBitmap.bit(at: 29)
            window = integerBitmap.bit(at: 20)
            regionOfInterest = integerBitmap.bit(at: 21)
        }
    }
}

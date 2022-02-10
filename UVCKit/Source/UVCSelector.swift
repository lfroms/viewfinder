//
//  UVCSelector.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-07.
//

enum UVCSelector {
    case cameraTerminal(UVCCameraTerminalSelector, unitId: Int)
    case processingUnit(UVCProcessingUnitSelector, unitId: Int)

    var unitId: Int {
        switch self {
        case .cameraTerminal(_, let unitId):
            return unitId
        case .processingUnit(_, let unitId):
            return unitId
        }
    }

    var value: Int {
        switch self {
        case .cameraTerminal(let selector, _):
            return selector.rawValue
        case .processingUnit(let selector, _):
            return selector.rawValue
        }
    }
}

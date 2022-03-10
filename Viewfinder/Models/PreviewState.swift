//
//  PreviewState.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-09.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

enum PreviewState {
    case suspended(deviceName: String)
    case initializing
    case noDevice

    var text: String? {
        switch self {
        case .suspended(let deviceName):
            return "\(deviceName) is unavailable"
        case .noDevice:
            return "No Device Selected"
        case .initializing:
            return nil
        }
    }

    var iconName: String? {
        switch self {
        case .suspended:
            return "eye.slash.circle.fill"
        case .noDevice:
            return "questionmark.circle.fill"
        case .initializing:
            return nil
        }
    }
}

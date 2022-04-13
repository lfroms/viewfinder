//
//  PreviewState.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-09.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

enum PreviewState: Equatable {
    case suspended(deviceName: String)
    case initializing
    case noDevice

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

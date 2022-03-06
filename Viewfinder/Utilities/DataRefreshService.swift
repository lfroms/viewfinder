//
//  DataRefreshService.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-24.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import Combine
import Foundation

final class DataRefreshService {
    private var timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common)
    private var cancellable: AnyCancellable?

    func refreshPeriodically() {
        cancellable = timer
            .autoconnect()
            .sink { [self] _ in
                notifyReadCameraValues()
            }
    }

    func pauseRefreshingPeriodically() {
        cancellable?.cancel()
        cancellable = nil
    }

    private func notifyReadCameraValues() {
        NotificationCenter.default.post(name: .readCameraValues, object: nil)
    }
}

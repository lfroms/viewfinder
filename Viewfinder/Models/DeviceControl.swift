//
//  DeviceControl.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-17.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import Combine
import Foundation
import UVCKit

final class DeviceControl<ControlType: UVCControllable>: ObservableObject {
    typealias ValueType = ControlType.ValueType

    private var control: ControlType
    private var cancellables = Set<AnyCancellable>()

    @Published private var displayValue: ValueType
    @Published private var rangeInternal: ClosedRange<Int> = 0 ... 0

    @Published private(set) var defaultValue: ValueType

    var value: ValueType {
        get {
            displayValue
        }
        set {
            guard newValue != displayValue else {
                return
            }

            displayValue = newValue

            Task {
                control.value = newValue
            }
        }
    }

    init(control: ControlType) {
        self.control = control

        let defaultValue = control.defaultValue
        self.displayValue = defaultValue
        self.defaultValue = defaultValue

        subscribeToNotifications()
    }

    // TODO: Currently only supports integer ranges, make it support any kind of control with a range.
    init(control: ControlType) where ControlType: UVCRangeControllable, ValueType == Int {
        self.control = control

        let defaultValue = control.defaultValue
        self.displayValue = defaultValue
        self.defaultValue = defaultValue

        if control.minimum <= control.maximum {
            self.rangeInternal = control.minimum ... control.maximum
        }

        subscribeToNotifications()
    }

    private func subscribeToNotifications() {
        // Forcibly overwrite the current display value with the one from the device.
        NotificationCenter.default
            .publisher(for: .readCameraValues, object: nil)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.global(qos: .background))
            .map { _ in
                self.control.value
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.displayValue = value
            }
            .store(in: &cancellables)

        // Forcibly update the device to match what is displayed in the UI.
        NotificationCenter.default
            .publisher(for: .writeCameraValues, object: nil)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.global(qos: .background))
            .sink { [self] _ in
                control.value = value
            }
            .store(in: &cancellables)
    }
}

extension DeviceControl where ValueType == Int {
    var range: ClosedRange<ValueType> {
        rangeInternal
    }
}

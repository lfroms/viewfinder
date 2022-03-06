//
//  Double+PercentageToAbsolute.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-26.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

extension Double {
    func percentageToAbsolute(in bounds: ClosedRange<Int>) -> Int {
        Int(Double(bounds.lowerBound) + (Double(bounds.upperBound - bounds.lowerBound) * self))
    }
}

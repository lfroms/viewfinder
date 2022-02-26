//
//  Double+PercentageToAbsolute.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-26.
//

extension Double {
    func percentageToAbsolute(in bounds: ClosedRange<Int>) -> Int {
        Int(Double(bounds.lowerBound) + (Double(bounds.upperBound - bounds.lowerBound) * self))
    }
}

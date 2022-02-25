//
//  Int+Percentage.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-24.
//

extension Int {
    func percentage(in range: ClosedRange<Self>) -> Double {
        return Double(self - range.lowerBound) / Double(range.upperBound - range.lowerBound)
    }
}

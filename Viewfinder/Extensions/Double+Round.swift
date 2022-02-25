//
//  Double+Round.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-24.
//

import Foundation

extension Double {
    func round(to places: Int = 0) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

    var stringRemovingTrailingZeros: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

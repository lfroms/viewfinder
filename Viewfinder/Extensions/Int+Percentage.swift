//
//  Int+Percentage.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-24.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

extension Int {
    func percentage(in range: ClosedRange<Self>) -> Double {
        guard range.upperBound - range.lowerBound > 0 else {
            return 0
        }

        return Double(self - range.lowerBound) / Double(range.upperBound - range.lowerBound)
    }
}

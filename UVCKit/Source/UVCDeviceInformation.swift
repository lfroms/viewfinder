//
//  UVCDeviceInformation.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-06.
//

struct UVCDeviceInformation {
    private static let pattern = "^UVC\\s+Camera\\s+VendorID\\_([0-9]+)\\s+ProductID\\_([0-9]+)$"
    
    let productId: Int
    let vendorId: Int
    
    init?(modelId: String) {
        let regex = try? NSRegularExpression(pattern: Self.pattern, options: [])
        
        guard
            let match = regex?.firstMatch(in: modelId, options: [], range: NSRange(location: 0, length: modelId.count)),
            match.numberOfRanges == 3,
            let vendorIdRange = Range<String.Index>(match.range(at: 1), in: modelId),
            let vendorId = Int(modelId[vendorIdRange]),
            let productIdRange = Range<String.Index>(match.range(at: 2), in: modelId),
            let productId = Int(modelId[productIdRange])
        else {
            return nil
        }
        
        self.productId = productId
        self.vendorId = vendorId
    }
}

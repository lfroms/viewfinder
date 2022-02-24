//
//  UVCCoordinateControl.swift
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-09.
//

public class UVCCoordinateControl: UVCControl, UVCControllable, UVCRangeControllable {
    public struct Coordinate: Equatable {
        let x: Int
        let y: Int
    }

    public lazy var defaultValue: Coordinate = readCoordinate(requestType: .getDefault)
    public lazy var minimum: Coordinate = readCoordinate(requestType: .getMinimum)
    public lazy var maximum: Coordinate = readCoordinate(requestType: .getMaximum)
    public lazy var resolution: Coordinate = readCoordinate(requestType: .getResolution)

    public var value: Coordinate {
        get {
            readCoordinate(requestType: .getCurrent)
        }

        set {
            let coordinate = (newValue.x * 3600) << 32 | (newValue.y * 3600)
            _ = try? write(value: coordinate, length: length)
        }
    }

    private func readCoordinate(requestType: UVCRequestCode) -> Coordinate {
        guard let value = try? read(requestType: requestType, length: length) else {
            return Coordinate(x: 0, y: 0)
        }

        let coordinatePair = splitValue(value)
        return Coordinate(x: coordinatePair.0, y: coordinatePair.1)
    }

    private func splitValue(_ value: Int) -> (Int, Int) {
        let array: [UInt8] = value.eightBitByteArray

        let array1: [UInt8] = Array(array.prefix(4))
        let array2: [UInt8] = array.suffix(4)

        let value1 = Int(Int32(array1).littleEndian) / 3600
        let value2 = Int(Int32(array2).littleEndian) / 3600

        return (value1, value2)
    }
}

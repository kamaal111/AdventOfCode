//
//  Coordinates.swift
//  
//
//  Created by Kamaal Farah on 08/12/2022.
//

import Foundation
import ShrimpExtensions

public struct Coordinates: Equatable, Hashable {
    public var x: Int
    public var y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    public func isTouching(_ other: Coordinates) -> Bool {
        abs(x - other.x) <= 1 && abs(y - other.y) <= 1
    }

    public func isDiagonal(to other: Coordinates) -> Bool {
        let deltaY = other.y - y
        let deltaX = other.x - x
        let π = Double.pi
        let angle = abs(round(Double(atan2(Float(deltaY), Float(deltaX)) * 180) / π))

        return angle == 45 || angle == 135
    }

    public static let zero = Coordinates(x: 0, y: 0)
}

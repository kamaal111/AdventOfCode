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

    public func to(_ coordinates: Coordinates) -> [Coordinates] {
        if x == coordinates.x && y == coordinates.y {
            return []
        }

        if x == coordinates.x {
            let difference = y - coordinates.y
            return (1..<abs(difference))
                .map({
                    let y: Int
                    if difference < 0 {
                        y = self.y + $0
                    } else {
                        y = self.y - $0
                    }
                    return Coordinates(x: x, y: y)
                })
        }

        if y == coordinates.y {
            let difference = x - coordinates.x
            return (1..<abs(difference))
                .map({
                    let x: Int
                    if difference < 0 {
                        x = self.x + $0
                    } else {
                        x = self.x - $0
                    }
                    return Coordinates(x: x, y: y)
                })
        }

        fatalError("Too lazy to support now")
    }

    public var north: Coordinates {
        north(1)
    }

    public var south: Coordinates {
        south(1)
    }

    public var southEast: Coordinates {
        Coordinates(x: x + 1, y: y + 1)
    }

    public var east: Coordinates {
        east(1)
    }

    public var southWest: Coordinates {
        Coordinates(x: x + 1, y: y - 1)
    }

    public var west: Coordinates {
        west(1)
    }

    public func north(_ amount: Int) -> Coordinates {
        Coordinates(x: x - amount, y: y)
    }

    public func south(_ amount: Int) -> Coordinates {
        Coordinates(x: x + amount, y: y)
    }

    public func east(_ amount: Int) -> Coordinates {
        Coordinates(x: x, y: y + amount)
    }

    public func west(_ amount: Int) -> Coordinates {
        Coordinates(x: x, y: y - amount)
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

//
//  Coordinates.swift
//  
//
//  Created by Kamaal Farah on 08/12/2022.
//

import Foundation

public struct Coordinates: Equatable, Hashable {
    public var x: Int
    public var y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    public func isDiagonal(from other: Coordinates) -> Bool {
        (x - other.x) == (y - other.y)
    }

    public static let zero = Coordinates(x: 0, y: 0)
}

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

    public func areTouching(_ other: Coordinates) -> Bool {
        abs(x - other.x) <= 1 && abs(y - other.y) <= 1
    }

    public static let zero = Coordinates(x: 0, y: 0)
}

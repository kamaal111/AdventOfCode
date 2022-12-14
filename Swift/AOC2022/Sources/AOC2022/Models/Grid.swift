//
//  Grid.swift
//  
//
//  Created by Kamaal Farah on 08/12/2022.
//

import Foundation
import ShrimpExtensions

public struct Grid<Cell> {
    private(set) var items: [[Cell]]

    public init(items: [[Cell]] = []) {
        self.items = items
    }

    public init(size: Size, defaultValue: Cell) {
        var items: [[Cell]] = []
        for _ in 0..<size.width {
            var row: [Cell] = []
            for _ in 0..<size.height {
                row = row.appended(defaultValue)
            }
            items = items.appended(row)
        }
        self.items = items
    }

    public var size: Size {
        Size(width: width, height: height)
    }

    public var height: Int {
        items.count
    }

    public var width: Int {
        items.last?.count ?? 0
    }

    public func getCell(x: Int, y: Int) -> Cell? {
        getRow(x: x)?.at(y)
    }

    public func getCell(at coordinates: Coordinates) -> Cell? {
        getCell(x: coordinates.x, y: coordinates.y)
    }

    public func cellIsBottomEdge(x: Int) -> Bool {
        x >= (height - 1)
    }

    public func cellIsTopEdge(x: Int) -> Bool {
        x == 0
    }

    public func cellIsLeftEdge(y: Int) -> Bool {
        y == 0
    }

    public func cellIsRightEdge(y: Int) -> Bool {
        y >= (width - 1)
    }

    public func getRow(x: Int) -> [Cell]? {
        items.at(x)
    }

    public func getColumn(y: Int) -> [Cell] {
        (0..<width)
            .compactMap({ getCell(x: $0, y: y) })
    }

    public mutating func setCell(x: Int, y: Int, with value: Cell) {
        items[x][y] = value
    }

    public mutating func setCell(at coordinates: Coordinates, with value: Cell) {
        setCell(x: coordinates.x, y: coordinates.y, with: value)
    }

    public mutating func addRow(_ row: [Cell]) {
        if let widthCount = items.last?.count, widthCount != row.count {
            assertionFailure("Should not add oneven row")
            return
        }
        items = items.appended(row)
    }
}

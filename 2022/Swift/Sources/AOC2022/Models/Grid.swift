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
        for _ in 0..<size.height {
            var row: [Cell] = []
            for _ in 0..<size.width {
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
        getRow(y: y)?.at(x)
    }

    public func getCell(at coordinates: Coordinates) -> Cell? {
        getCell(x: coordinates.x, y: coordinates.y)
    }

    public func cellIsBottomEdge(y: Int) -> Bool {
        y >= (height - 1)
    }

    public func cellIsTopEdge(y: Int) -> Bool {
        y == 0
    }

    public func cellIsLeftEdge(x: Int) -> Bool {
        x == 0
    }

    public func cellIsRightEdge(x: Int) -> Bool {
        x >= (width - 1)
    }

    public func getRow(y: Int) -> [Cell]? {
        items.at(y)
    }

    public func getColumn(x: Int) -> [Cell] {
        getColumn(start: 0, x: x)
    }

    public func getColumn(start: Int, x: Int) -> [Cell] {
        (start..<height)
            .compactMap({ getCell(x: x, y: $0)})
    }

    public func getColumn(
        start: Int,
        x: Int,
        until predicate: ((cell: Cell, coordinate: Coordinates)) -> Bool) -> [(cell: Cell, coordinate: Coordinates)] {
            guard start <= height else { return [] }

            func mapYToCellAndCoordinates(_ y: Int) -> (Cell, Coordinates) {
                let coordinate = Coordinates(x: x, y: y)
                let cell = getCell(at: coordinate)!
                return (cell, coordinate)
            }

            return (start..<height)
                .asArray()
                .map(mapYToCellAndCoordinates, until: predicate)
        }

    public func draw(from start: Int = 0, mapping: (Cell) -> String) -> String {
        items
            .map({
                $0
                    .ranged(from: start)
                    .map(mapping)
                    .joined()
            })
            .joined(separator: "\n")
    }

    public mutating func setCell(x: Int, y: Int, with value: Cell) {
        items[y][x] = value
    }

    public mutating func setCell(at coordinates: Coordinates, with value: Cell) {
        setCell(x: coordinates.x, y: coordinates.y, with: value)
    }

    public mutating func setCells(_ coordinates: [Coordinates], with value: Cell) {
        for coordinate in coordinates {
            setCell(at: coordinate, with: value)
        }
    }

    public mutating func addRow(_ row: [Cell]) {
        if let widthCount = items.last?.count, widthCount != row.count {
            assertionFailure("Should not add oneven row")
            return
        }
        items = items.appended(row)
    }
}

extension Grid where Cell == CustomStringConvertible {
    public func draw(from start: Int = 0) -> String {
        draw(from: start, mapping: \.description)
    }
}

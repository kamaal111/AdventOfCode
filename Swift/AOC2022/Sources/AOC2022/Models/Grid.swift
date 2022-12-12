//
//  Grid.swift
//  
//
//  Created by Kamaal Farah on 08/12/2022.
//

import Foundation
import ShrimpExtensions

public struct Grid<Cell>: CustomStringConvertible {
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
        Size(width: xLength, height: yLength)
    }

    public var xLength: Int {
        items.first?.count ?? 0
    }

    public var yLength: Int {
        items.count
    }

    public func getCell(x: Int, y: Int) -> Cell? {
        getRow(x)?.at(y)
    }

    public func cellIsBottomEdge(x: Int) -> Bool {
        x >= (xLength - 1)
    }

    public func cellIsTopEdge(x: Int) -> Bool {
        x == 0
    }

    public func cellIsLeftEdge(y: Int) -> Bool {
        y == 0
    }

    public func cellIsRightEdge(y: Int) -> Bool {
        y >= (yLength - 1)
    }

    public func getRow(_ x: Int) -> [Cell]? {
        items.at(x)
    }

    public func getColumn(_ y: Int) -> [Cell] {
        (0..<yLength)
            .compactMap({ getCell(x: $0, y: y) })
    }

    public mutating func setCell(x: Int, y: Int, with value: Cell) {
        items[x][y] = value
    }

    public mutating func addRow(_ row: [Cell]) {
        if let lastRowCount = items.last?.count, row.count != row.count {
            assertionFailure("Should not add oneven row")
            return
        }
        items = items.appended(row)
    }

    // - MARK: CustomStringConvertible

    public var description: String {
        var string = ""
        for row in items {
            var rowString = ""
            for cell in row {
                rowString += "|\(String(describing: cell))|"
            }
            let seperator = (0..<rowString.count).map({ _ in "-" }).joined()
            string += "\(seperator)\n\(rowString)\n\(seperator)\n"
        }
        return string
    }
}

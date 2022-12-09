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

    public var xLength: Int {
        items.first?.count ?? 0
    }

    public var yLength: Int {
        items.count
    }

    public func getCell(x: Int, y: Int) -> Cell? {
        getRow(x).at(y)
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

    public func getRow(_ x: Int) -> [Cell] {
        items[x]
    }

    public func getColumn(_ y: Int) -> [Cell] {
        (0..<yLength)
            .compactMap({ getCell(x: $0, y: y) })
    }

    public mutating func addRow(_ row: [Cell]) {
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

//
//  Grid.swift
//  
//
//  Created by Kamaal Farah on 08/12/2022.
//

import Foundation
import ShrimpExtensions

struct Grid<Cell> {
    private(set) var items: [[Cell]]

    init(items: [[Cell]]) {
        self.items = items
    }

    init() {
        self.init(items: [])
    }

    var xLength: Int {
        items.first?.count ?? 0
    }

    var yLength: Int {
        items.count
    }

    func getCell(x: Int, y: Int) -> Cell? {
        getRow(x).at(y)
    }

    func cellIsBottomEdge(x: Int) -> Bool {
        x >= (xLength - 1)
    }

    func cellIsTopEdge(x: Int) -> Bool {
        x == 0
    }

    func cellIsLeftEdge(y: Int) -> Bool {
        y == 0
    }

    func cellIsRightEdge(y: Int) -> Bool {
        y >= (yLength - 1)
    }

    func getRow(_ x: Int) -> [Cell] {
        items[x]
    }

    func getColumn(_ y: Int) -> [Cell] {
        (0..<yLength)
            .compactMap({ getCell(x: $0, y: y) })
    }

    mutating func addRow(_ row: [Cell]) {
        items = items.appended(row)
    }
}

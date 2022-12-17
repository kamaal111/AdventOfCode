//
//  GridTests.swift
//  
//
//  Created by Kamaal M Farah on 10/12/2022.
//

import XCTest
@testable import AOC2022

final class GridTests: XCTestCase {
    func testGetCell() throws {
        let grid = Grid(items: [
            ["🔥", "🧊", "💧"],
            ["☀️", "💥", "☄️"],
            ["💨", "🫧", "⚡️"],
        ])
        let cases = [
            (Coordinates(x: 0, y: 0), "🔥"),
            (Coordinates(x: 1, y: 0), "🧊"),
            (Coordinates(x: 2, y: 0), "💧"),
            (Coordinates(x: 0, y: 1), "☀️"),
            (Coordinates(x: 1, y: 1), "💥"),
            (Coordinates(x: 2, y: 1), "☄️"),
            (Coordinates(x: 0, y: 2), "💨"),
            (Coordinates(x: 1, y: 2), "🫧"),
            (Coordinates(x: 2, y: 2), "⚡️"),

        ]
        for (coordinates, expectedValue) in cases {
            let cell = try XCTUnwrap(grid.getCell(at: coordinates))
            XCTAssertEqual(cell, expectedValue)
        }
    }

    func testGetRow() throws {
        let grid = Grid(items: [
            ["🔥", "🧊", "💧"],
            ["☀️", "💥", "☄️"],
            ["💨", "🫧", "⚡️"],
        ])
        let cases = [
            (0, ["🔥", "🧊", "💧"]),
            (1, ["☀️", "💥", "☄️"]),
            (2, ["💨", "🫧", "⚡️"]),
        ]
        for (rowNumber, expectedRow) in cases {
            let row = grid.getRow(y: rowNumber)
            XCTAssertEqual(row, expectedRow)
        }
    }

    func testGetColumn() throws {
        let grid = Grid(items: [
            ["🔥", "🧊", "💧"],
            ["☀️", "💥", "☄️"],
            ["💨", "🫧", "⚡️"],
        ])
        let cases = [
            (0, ["🔥", "☀️", "💨"]),
            (1, ["🧊", "💥", "🫧"]),
            (2, ["💧", "☄️", "⚡️"]),
        ]
        for (columnNumber, expectedColumn) in cases {
            let column = grid.getColumn(x: columnNumber)
            XCTAssertEqual(column, expectedColumn)
        }
    }

    func testGetColumnUntill() {
        let grid = Grid(items: [
            ["🔥", "🧊", "💧"],
            ["☀️", "💥", "☄️"],
            ["💨", "🫧", "⚡️"],
        ])
        let cases = [
            (0, ["🔥", "☀️"], "☀️", 0),
            (1, ["🧊", "💥", "🫧"], "🫧", 0),
            (2, ["💧"], "💧", 0),
            (1, ["💥", "🫧"], "🫧", 1),
            (1, ["🫧"], "🫧", 2),
        ]
        for (columnNumber, expectedColumn, untill, start) in cases {
            let column = grid.getColumn(start: start, x: columnNumber, until: { $0.cell == untill })
            XCTAssertEqual(column.map(\.cell), expectedColumn)
        }
    }

    func testAddRow() {
        var grid = Grid(size: Size(width: 2, height: 2), defaultValue: "🔥")
        grid.addRow(["🧊", "💧"])
        XCTAssertEqual(grid.items, [
            ["🔥", "🔥"],
            ["🔥", "🔥"],
            ["🧊", "💧"],
        ])
    }

    func testSizeInitializer() {
        let cases = [
            (Size(width: 2, height: 3), [
                ["🔥", "🔥"],
                ["🔥", "🔥"],
                ["🔥", "🔥"],
            ]),
            (Size(width: 3, height: 2), [
                ["🔥", "🔥", "🔥"],
                ["🔥", "🔥", "🔥"],
            ]),
        ]
        for (size, expectedItems) in cases {
            let grid = Grid(size: size, defaultValue: "🔥")
            XCTAssertEqual(grid.items, expectedItems)
            XCTAssertEqual(grid.size, size)
            XCTAssertEqual(grid.height, size.height)
            XCTAssertEqual(grid.width, size.width)
        }
    }

    func testUpdatingCells() {
        let cases = [
            (Coordinates(x: 0, y: 1), Size(width: 2, height: 2), [
                ["🔥", "🔥"],
                ["🧊", "🔥"]
            ]),
            (Coordinates(x: 1, y: 0), Size(width: 2, height: 2), [
                ["🔥", "🧊"],
                ["🔥", "🔥"]
            ]),
        ]
        for (coordinatesToSet, gridSize, expectedItems) in cases {
            var grid = Grid(size: gridSize, defaultValue: "🔥")
            grid.setCell(at: coordinatesToSet, with: "🧊")
            XCTAssertEqual(grid.items, expectedItems)
        }
    }
}

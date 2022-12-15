//
//  GridTests.swift
//  
//
//  Created by Kamaal M Farah on 10/12/2022.
//

import XCTest
@testable import AOC2022

final class GridTests: XCTestCase {
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

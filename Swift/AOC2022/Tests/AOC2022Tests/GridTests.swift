//
//  GridTests.swift
//  
//
//  Created by Kamaal M Farah on 10/12/2022.
//

import XCTest
@testable import AOC2022

final class GridTests: XCTestCase {
    func testSizeInitializer() {
        let grid = Grid(size: Size(width: 2, height: 3), defaultValue: "x")
        XCTAssertEqual(grid.items, [["x", "x"], ["x", "x"], ["x", "x"]])
    }

    func testUpdatingCells() {
        var grid = Grid(size: Size(width: 2, height: 2), defaultValue: "x")
        grid.setCell(x: 0, y: 1, with: "y")
        XCTAssertEqual(grid.items, [["x", "y"], ["x", "x"]])
    }
}

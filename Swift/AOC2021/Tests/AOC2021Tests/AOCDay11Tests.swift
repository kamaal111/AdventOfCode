//
//  AOCDay11Tests.swift
//  
//
//  Created by Kamaal Farah on 11/12/2021.
//

import XCTest
@testable import AOC2021

final class AOCDay11Tests: XCTestCase {
    let exampleInput = """
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
"""

    func testDay11Part1() throws {
        let input = try XCTUnwrap(AOCDay11.input)
        let result = AOCDay11.part1.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testDay11Part1Example() throws {
        let result = AOCDay11.part1.execute(with: exampleInput)
        XCTAssertEqual(result, 1656)
    }

    func testDay11Part2() throws {
        let input = try XCTUnwrap(AOCDay11.input)
        let result = AOCDay11.part2.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testDay11Part2Example() throws {
        let result = AOCDay11.part2.execute(with: exampleInput)
        XCTAssertEqual(result, 0)
    }
}

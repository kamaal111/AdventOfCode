//
//  AOCDay9Tests.swift
//  
//
//  Created by Kamaal Farah on 10/12/2021.
//

import XCTest
@testable import AOC2021

final class AOCDay9Tests: XCTestCase {
    let exampleInput = """
2199943210
3987894921
9856789892
8767896789
9899965678
"""

    func testDay9Part1() throws {
        let input = try XCTUnwrap(AOCDay9.input)
        let result = AOCDay9.part1.execute(with: input)
        XCTAssertEqual(result, 600)
    }

    func testDay9Part1Example() throws {
        let result = AOCDay9.part1.execute(with: exampleInput)
        XCTAssertEqual(result, 15)
    }

    func testDay9Part2() throws {
        let input = try XCTUnwrap(AOCDay9.input)
        let result = AOCDay9.part2.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testDay9Part2Example() throws {
        let result = AOCDay9.part2.execute(with: exampleInput)
        XCTAssertEqual(result, 0)
    }
}

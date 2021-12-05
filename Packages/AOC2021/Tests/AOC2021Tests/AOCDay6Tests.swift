//
//  AOCDay6Tests.swift
//  
//
//  Created by Kamaal M Farah on 05/12/2021.
//

import XCTest
@testable import AOC2021

final class AOCDay6Tests: XCTestCase {
    let exampleInput = """
"""

    func testDay6Part1() throws {
        let input = try XCTUnwrap(AOCDay6.input)
        let result = AOCDay6.part1.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testDay6Part1Example() throws {
        let result = AOCDay6.part1.execute(with: exampleInput)
        XCTAssertEqual(result, 0)
    }

    func testDay6Part2() throws {
        let input = try XCTUnwrap(AOCDay6.input)
        let result = AOCDay6.part2.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testDay1Part2Example() throws {
        let result = AOCDay6.part2.execute(with: exampleInput)
        XCTAssertEqual(result, 0)
    }
}

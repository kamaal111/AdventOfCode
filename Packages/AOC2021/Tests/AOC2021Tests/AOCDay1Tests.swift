//
//  AOCDay1Tests.swift
//  
//
//  Created by Kamaal M Farah on 05/12/2021.
//

import XCTest
@testable import AOC2021

final class AOCDay1Tests: XCTestCase {
    let exampleInput = """
199
200
208
210
200
207
240
269
260
263
"""

    func testDay1Part1() throws {
        let input = try XCTUnwrap(AOCDay1.input)
        let result = AOCDay1.part1.execute(with: input)
        XCTAssertEqual(result, 1374)
    }

    func testDay1Part1Example() throws {
        let result = AOCDay1.part1.execute(with: exampleInput)
        XCTAssertEqual(result, 7)
    }

    func testDay1Part2() throws {
        let input = try XCTUnwrap(AOCDay1.input)
        let result = AOCDay1.part2.execute(with: input)
        XCTAssertEqual(result, 1418)
    }

    func testDay1Part2Example() throws {
        let result = AOCDay1.part2.execute(with: exampleInput)
        XCTAssertEqual(result, 5)
    }
}

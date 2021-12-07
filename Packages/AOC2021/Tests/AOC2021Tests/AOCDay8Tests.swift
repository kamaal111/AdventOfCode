//
//  AOCDay8Tests.swift
//  
//
//  Created by Kamaal Farah on 07/12/2021.
//

import XCTest
@testable import AOC2021

final class AOCDay8Tests: XCTestCase {
    let exampleInput = ""

    func testDay8Part1() throws {
        let input = try XCTUnwrap(AOCDay8.input)
        let result = AOCDay8.part1.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testDay8Part1Example() throws {
        let result = AOCDay8.part1.execute(with: exampleInput)
        XCTAssertEqual(result, 0)
    }

    func testDay8Part2() throws {
        let input = try XCTUnwrap(AOCDay8.input)
        let result = AOCDay8.part2.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testDay8Part2Example() throws {
        let result = AOCDay8.part2.execute(with: exampleInput)
        XCTAssertEqual(result, 0)
    }
}

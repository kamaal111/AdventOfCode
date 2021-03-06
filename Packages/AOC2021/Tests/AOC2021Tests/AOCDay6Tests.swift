//
//  AOCDay6Tests.swift
//  
//
//  Created by Kamaal M Farah on 05/12/2021.
//

import XCTest
@testable import AOC2021

final class AOCDay6Tests: XCTestCase {
    let exampleInput = "3,4,3,1,2"

    func testDay6Part1() throws {
        let input = try XCTUnwrap(AOCDay6.input)
        let result = AOCDay6.part1.execute(with: input)
        XCTAssertNotEqual(result, 360219)
        XCTAssertNotEqual(result, 554471)
        XCTAssertEqual(result, 361169)
    }

    func testDay6Part1Example() throws {
        let result = AOCDay6.part1.execute(with: exampleInput)
        XCTAssertEqual(result, 5934)
    }

    func testDay6Part2() throws {
        let input = try XCTUnwrap(AOCDay6.input)
        let result = AOCDay6.part2.execute(with: input)
        XCTAssertEqual(result, 1634946868992)
    }

    func testDay6Part2Example() throws {
        let result = AOCDay6.part2.execute(with: exampleInput)
        XCTAssertEqual(result, 26984457539)
    }
}

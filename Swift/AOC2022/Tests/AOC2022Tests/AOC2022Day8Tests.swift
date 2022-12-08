//
//  AOC2022Day8Tests.swift
//
//
//  Created by Kamaal M Farah on 07/12/2022.
//

import XCTest
@testable import AOC2022

final class AOC2022Day8Tests: XCTestCase {
    let exampleInput = """
30373
25512
65332
33549
35390
"""

    let input = AOC2022.Day8.input

    func testPart1() {
        let result = AOC2022.Day8.Part1.execute(with: input)
        XCTAssertNotEqual(result, 7280)
        XCTAssertNotEqual(result, 5418)
        XCTAssertNotEqual(result, 1325)
        XCTAssertEqual(result, 1533)
    }

    func testPart1Example() {
        let result = AOC2022.Day8.Part1.execute(with: exampleInput)
        XCTAssertEqual(result, 21)
    }

    func testPart2() {
        let result = AOC2022.Day8.Part2.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testPart2Example() {
        let result = AOC2022.Day8.Part2.execute(with: exampleInput)
        XCTAssertEqual(result, 8)
    }
}

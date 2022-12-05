//
//  AOC2022Day6Tests.swift
//
//
//  Created by Kamaal M Farah on 03/12/2022.
//

import XCTest
@testable import AOC2022

final class AOC2022Day6Tests: XCTestCase {
    let exampleInput = """
"""

    let input = AOC2022.Day6.input

    func testPart1() {
        let result = AOC2022.Day6.Part1.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testPart1Example() {
        let result = AOC2022.Day6.Part1.execute(with: exampleInput)
        XCTAssertEqual(result, 0)
    }

    func testPart2() {
        let result = AOC2022.Day6.Part2.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testPart2Example() {
        let result = AOC2022.Day6.Part2.execute(with: exampleInput)
        XCTAssertEqual(result, 0)
    }
}

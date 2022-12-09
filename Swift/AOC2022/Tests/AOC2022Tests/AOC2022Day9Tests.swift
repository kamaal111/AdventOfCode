//
//  AOC2022Day9Tests.swift
//
//
//  Created by Kamaal M Farah on 07/12/2022.
//

import XCTest
@testable import AOC2022

final class AOC2022Day9Tests: XCTestCase {
    let exampleInput = """
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
"""

    let input = AOC2022.Day9.input
    let day = AOC2022.Day9.self

    func testPart1() {
        let result = day.Part1.execute(with: input)
        XCTAssertNotEqual(result, 6187)
        XCTAssertNotEqual(result, 5646)
        XCTAssertNotEqual(result, 5914)
        XCTAssertEqual(result, 0)
    }

    func testPart1Example() {
        let result = day.Part1.execute(with: exampleInput)
        XCTAssertEqual(result, 13)
    }

    func testPart2() {
        let result = day.Part2.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testPart2Example() {
        let result = day.Part2.execute(with: exampleInput)
        XCTAssertEqual(result, 0)
    }
}

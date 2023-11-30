//
//  AOC2022Day5Tests.swift
//
//
//  Created by Kamaal M Farah on 03/12/2022.
//

import XCTest
@testable import AOC2022

final class AOC2022Day5Tests: XCTestCase {
    let exampleInput = """
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
"""

    let input = AOC2022.Day5.input

    func testPart1() {
        let result = AOC2022.Day5.Part1.execute(with: input)
        XCTAssertEqual(result, "HBTMTBSDC")
    }

    func testPart1Example() {
        let result = AOC2022.Day5.Part1.execute(with: exampleInput)
        XCTAssertEqual(result, "CMZ")
    }

    func testPart2() {
        let result = AOC2022.Day5.Part2.execute(with: input)
        XCTAssertEqual(result, "PQTJRSHWS")
    }

    func testPart2Example() {
        let result = AOC2022.Day5.Part2.execute(with: exampleInput)
        XCTAssertEqual(result, "MCD")
    }
}

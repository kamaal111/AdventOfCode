//
//  AOC2022Day4Tests.swift
//
//
//  Created by Kamaal M Farah on 03/12/2022.
//

import XCTest
@testable import AOC2022

final class AOC2022Day4Tests: XCTestCase {
    let exampleInput = """
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
"""

    let input = AOC2022.Day4.input

    func testPart1() {
        let result = AOC2022.Day4.Part1.execute(with: input)
        XCTAssertEqual(result, 560)
    }

    func testPart1Example() {
        let result = AOC2022.Day4.Part1.execute(with: exampleInput)
        XCTAssertEqual(result, 2)
    }

    func testPart2() {
        let result = AOC2022.Day4.Part2.execute(with: input)
        XCTAssertEqual(result, 839)
    }

    func testPart2Example() {
        let result = AOC2022.Day4.Part2.execute(with: exampleInput)
        XCTAssertEqual(result, 4)
    }
}

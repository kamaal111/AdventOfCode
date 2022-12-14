//
//  AOC2022Day14Tests.swift
//  
//
//  Created by Kamaal M Farah on 14/12/2022.
//

import XCTest
@testable import AOC2022

final class AOC2022Day14Tests: XCTestCase {
    let exampleInput = """
498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9
"""

    let input = AOC2022.Day14.input
    let day = AOC2022.Day14.self

    func testPart1() {
        let result = day.Part1.execute(with: input)
        XCTAssertNotEqual(result, 399)
        XCTAssertNotEqual(result, 443)
        XCTAssertEqual(result, 0)
    }

    func testPart1Example() {
        let result = day.Part1.execute(with: exampleInput)
        XCTAssertEqual(result, 24)
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


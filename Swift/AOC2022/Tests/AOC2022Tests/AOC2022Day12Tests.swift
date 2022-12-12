//
//  AOC2022Day12Tests.swift
//  
//
//  Created by Kamaal M Farah on 12/12/2022.
//

import XCTest
@testable import AOC2022

final class AOC2022Day12Tests: XCTestCase {
    let exampleInput = """
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
"""

    let input = AOC2022.Day12.input
    let day = AOC2022.Day12.self

    func testPart1() {
        let result = day.Part1.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testPart1Example() {
        let result = day.Part1.execute(with: exampleInput)
        XCTAssertEqual(result, 31)
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


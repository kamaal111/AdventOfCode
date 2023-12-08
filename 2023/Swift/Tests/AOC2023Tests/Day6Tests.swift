//
//  Day6Tests.swift
//
//
//  Created by Kamaal M Farah on 08/12/2023.
//

import XCTest
@testable import AOC2023

final class Day6Tests: XCTestCase {
    func testPart1() {
        let result = Day6.part1(input: Day6.input)
        XCTAssertEqual(result, 114400)
    }

    func testPart2() {
        let result = Day6.part2(input: Day6.input)
        XCTAssertEqual(result, 21039729)
    }
}

//
//  Day8Tests.swift
//  
//
//  Created by Kamaal M Farah on 08/12/2023.
//

import XCTest
@testable import AOC2023

final class Day8Tests: XCTestCase {
    func testPart1() {
        let result = Day8.part1(input: Day8.input)
        XCTAssertEqual(result, 12361)
    }

    func testPart2() {
        let result = Day8.part2(input: Day8.input)
        XCTAssertEqual(result, 18_215_611_419_223)
    }
}

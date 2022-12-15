//
//  AOC2022Day15Tests.swift
//  
//
//  Created by Kamaal M Farah on 15/12/2022.
//

import XCTest
@testable import AOC2022

final class AOC2022Day15Tests: XCTestCase {
    let exampleInput = """
Sensor at x=2, y=18: closest beacon is at x=-2, y=15
Sensor at x=9, y=16: closest beacon is at x=10, y=16
Sensor at x=13, y=2: closest beacon is at x=15, y=3
Sensor at x=12, y=14: closest beacon is at x=10, y=16
Sensor at x=10, y=20: closest beacon is at x=10, y=16
Sensor at x=14, y=17: closest beacon is at x=10, y=16
Sensor at x=8, y=7: closest beacon is at x=2, y=10
Sensor at x=2, y=0: closest beacon is at x=2, y=10
Sensor at x=0, y=11: closest beacon is at x=2, y=10
Sensor at x=20, y=14: closest beacon is at x=25, y=17
Sensor at x=17, y=20: closest beacon is at x=21, y=22
Sensor at x=16, y=7: closest beacon is at x=15, y=3
Sensor at x=14, y=3: closest beacon is at x=15, y=3
Sensor at x=20, y=1: closest beacon is at x=15, y=3
"""

    let input = AOC2022.Day15.input
    let day = AOC2022.Day15.self

    func testPart1() {
        let result = day.Part1.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testPart1Example() {
        let result = day.Part1.execute(with: exampleInput)
        XCTAssertEqual(result, 0)
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

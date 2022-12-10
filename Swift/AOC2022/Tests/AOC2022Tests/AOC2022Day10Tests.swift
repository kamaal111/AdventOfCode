//
//  AOC2022Day10Tests.swift
//  
//
//  Created by Kamaal M Farah on 10/12/2022.
//

import XCTest
@testable import AOC2022

final class AOC2022Day10Tests: XCTestCase {
    let input = AOC2022.Day10.input
    let day = AOC2022.Day10.self

    func testPart1() {
        let result = day.Part1.execute(with: input)
        XCTAssertNotEqual(result, 13920)
        XCTAssertEqual(result, 14860)
    }

    func testPart1Example() {
        let result = day.Part1.execute(with: exampleInput)
        XCTAssertEqual(result, 13140)
    }

    func testPart2() {
        let result = day.Part2.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testPart2Example() {
        let result = day.Part2.execute(with: exampleInput)
        XCTAssertEqual(result, 0)
    }

    // - MARK: Internals

    func testSimulateCycles() {
        let cases = [
            (20, 420),
            (60, 1140),
            (100, 1800),
            (140, 2940),
            (180, 2880),
            (220, 3960),
        ]

        for (cycle, expectedStrength) in cases {
            let cycles = self.day.simulateCycles(exampleInput, untill: cycle + 1)
            let strength = cycles[cycle]
            XCTAssertEqual(strength, expectedStrength)
        }
    }

    func testParse() {
        let cases = [
            ("noop", self.day.ParseResult(cycles: 1, value: 0)),
            ("addx 15", self.day.ParseResult(cycles: 2, value: 15)),
            ("addx -11", self.day.ParseResult(cycles: 2, value: -11))
        ]

        for (command, expectedResult) in cases {
            XCTAssertEqual(self.day.parse(command), expectedResult)
        }
    }
}

private let exampleInput = """
addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop
"""

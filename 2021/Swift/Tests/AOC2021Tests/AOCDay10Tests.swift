//
//  AOCDay10Tests.swift
//  
//
//  Created by Kamaal Farah on 10/12/2021.
//

import XCTest
@testable import AOC2021

final class AOCDay10Tests: XCTestCase {
    let exampleInput = """
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]
"""

    func testDay10Part1() throws {
        let input = try XCTUnwrap(AOCDay10.input)
        let result = AOCDay10.part1.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testDay10Part1Example() throws {
        let result = AOCDay10.part1.execute(with: exampleInput)
        XCTAssertEqual(result, 26397)
    }

    func testDay10Part2() throws {
        let input = try XCTUnwrap(AOCDay10.input)
        let result = AOCDay10.part2.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testDay10Part2Example() throws {
        let result = AOCDay10.part2.execute(with: exampleInput)
        XCTAssertEqual(result, 0)
    }
}

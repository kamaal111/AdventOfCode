//
//  AOC2022Day6Tests.swift
//
//
//  Created by Kamaal M Farah on 03/12/2022.
//

import XCTest
@testable import AOC2022

final class AOC2022Day6Tests: XCTestCase {
    let exampleInput = [
        "mjqjpqmgbljsphdztnvjfqwrcgsmlb",
        "bvwbjplbgvbhsrlpgdmjqwftvncz",
        "nppdvjthqldpwncqszvftbrmjlhg",
        "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg",
        "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
    ]

    let input = AOC2022.Day6.input

    func testPart1() {
        let result = AOC2022.Day6.Part1.execute(with: input)
        XCTAssertEqual(result, 1647)
    }

    func testPart1Example() {
        let results = [7, 5, 6, 10, 11]
        for (index, input) in exampleInput.enumerated() {
            let result = AOC2022.Day6.Part1.execute(with: input)
            XCTAssertEqual(result, results[index])
        }
    }

    func testPart2() {
        let result = AOC2022.Day6.Part2.execute(with: input)
        XCTAssertEqual(result, 2447)
    }

    func testPart2Example() {
        let results = [19, 23, 23, 29, 26]
        for (index, input) in exampleInput.enumerated() {
            let result = AOC2022.Day6.Part2.execute(with: input)
            XCTAssertEqual(result, results[index])
        }
    }
}

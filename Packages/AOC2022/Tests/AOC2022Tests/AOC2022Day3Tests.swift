//
//  AOC2022Day3Tests.swift
//  
//
//  Created by Kamaal M Farah on 03/12/2022.
//

import XCTest
@testable import AOC2022

final class AOC2022Day3Tests: XCTestCase {
    let exampleInput = """
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
"""

    func testPart1() {
        let result = AOC2022.Day3.Part1.excecute(with: AOC2022.Day3.input)
        XCTAssertEqual(result, 8243)
    }

    func testPart1Example() {
        let result = AOC2022.Day3.Part1.excecute(with: exampleInput)
        XCTAssertEqual(result, 157)
    }

    func testPart2() {
        let result = AOC2022.Day3.Part2.excecute(with: AOC2022.Day3.input)
        XCTAssertEqual(result, 2631)
    }

    func testPart2Example() {
        let result = AOC2022.Day3.Part2.excecute(with: exampleInput)
        XCTAssertEqual(result, 70)
    }
}

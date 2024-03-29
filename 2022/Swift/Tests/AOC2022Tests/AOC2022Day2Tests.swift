//
//  AOC2022Day2Tests.swift
//  
//
//  Created by Kamaal M Farah on 01/12/2022.
//

import XCTest
@testable import AOC2022

final class AOC2022Day2Tests: XCTestCase {
    let exampleInput = """
A Y
B X
C Z
"""

    func testPart1() {
        let result = AOC2022.Day2.Part1.excecute(with: AOC2022.Day2.input)
        XCTAssertEqual(result, 14375)
    }

    func testPart1Example() {
        let result = AOC2022.Day2.Part1.excecute(with: exampleInput)
        XCTAssertEqual(result, 15)
    }

    func testPart2() {
        let result = AOC2022.Day2.Part2.excecute(with: AOC2022.Day2.input)
        XCTAssertEqual(result, 10274)
    }

    func testPart2Example() {
        let result = AOC2022.Day2.Part2.excecute(with: exampleInput)
        XCTAssertEqual(result, 12)
    }
}


//
//  AOC2022Day1Tests.swift
//
//
//  Created by Kamaal M Farah on 26/11/2022.
//

import XCTest
@testable import AOC2022

final class AOC2022Day1Tests: XCTestCase {
    let exampleInput = """
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
"""

    func testPart1() throws {
        let result = AOC2022.Day1.Part1.excecute(with: AOC2022.Day1.input)
        XCTAssertEqual(result, 67450)
    }

    func testPart1Example() throws {
        let result = AOC2022.Day1.Part1.excecute(with: exampleInput)
        XCTAssertEqual(result, 24000)
    }

    func testPart2() throws {
        let result = AOC2022.Day1.Part2.excecute(with: AOC2022.Day1.input)
        XCTAssertEqual(result, 199357)
    }

    func testPart2Example() throws {
        let result = AOC2022.Day1.Part2.excecute(with: exampleInput)
        XCTAssertEqual(result, 45000)
    }
}

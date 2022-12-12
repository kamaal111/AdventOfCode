//
//  AOC2022Day11Tests.swift
//  
//
//  Created by Kamaal M Farah on 11/12/2022.
//

import XCTest
@testable import AOC2022

final class AOC2022Day11Tests: XCTestCase {
    let exampleInput = """
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
"""

    let input = AOC2022.Day11.input
    let day = AOC2022.Day11.self

    func testPart1() {
        let result = day.Part1.execute(with: input)
        XCTAssertEqual(result, 54752)
    }

    func testPart1Example() {
        let result = day.Part1.execute(with: exampleInput)
        XCTAssertEqual(result, 10605)
    }

    func testPart2() {
//       let result = day.Part2.execute(with: input)
//       XCTAssertEqual(result, 0)
    }

    func testPart2Example() {
//       let result = day.Part2.execute(with: exampleInput)
//       XCTAssertEqual(result, 2713310158)
    }
}

//
//  AOC2022Day13Tests.swift
//  
//
//  Created by Kamaal M Farah on 12/12/2022.
//

import XCTest
@testable import AOC2022

final class AOC2022Day13Tests: XCTestCase {
    let exampleInput = """
[1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]
"""

    let input = AOC2022.Day13.input
    let day = AOC2022.Day13.self

    func testPart1() {
        let result = day.Part1.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testPart1Example() {
        let result = day.Part1.execute(with: exampleInput)
        XCTAssertEqual(result, 13)
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


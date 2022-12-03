//
//  AOCDay5Tests.swift
//  
//
//  Created by Kamaal M Farah on 05/12/2021.
//

import XCTest
@testable import AOC2021

final class AOCDay5Tests: XCTestCase {
    let exampleInput = """
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
"""

    func testDay5Part1() throws {
        let input = try XCTUnwrap(AOCDay5.input)
        let result = AOCDay5.part1.execute(with: input)
        XCTAssertEqual(result, 5147)
    }

    func testDay5Part1Example() throws {
        let result = AOCDay5.part1.execute(with: exampleInput)
        XCTAssertEqual(result, 5)
    }

//    func testDay5Part2() throws {
//        let input = try XCTUnwrap(AOCDay1.input)
//        let result = AOCDay5.part2.execute(with: input)
//        XCTAssertEqual(result, 16925)
//    }
//
//    func testDay5Part2Example() throws {
//        let result = AOCDay5.part2.execute(with: exampleInput)
//        XCTAssertEqual(result, 12)
//    }
}

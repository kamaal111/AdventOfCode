//
//  AOCDay7Tests.swift
//  
//
//  Created by Kamaal M Farah on 06/12/2021.
//

import XCTest
@testable import AOC2021

final class AOCDay7Tests: XCTestCase {
    let exampleInput = "16,1,2,0,4,2,7,1,2,14"

    func testDay7Part1() throws {
        let input = try XCTUnwrap(AOCDay7.input)
        let result = AOCDay7.part1.execute(with: input)
        XCTAssertEqual(result, 356179)
    }

    func testDay7Part1Example() throws {
        let result = AOCDay7.part1.execute(with: exampleInput)
        XCTAssertEqual(result, 37)
    }

    func testDay7Part2() throws {
        let input = try XCTUnwrap(AOCDay7.input)
        let result = AOCDay7.part2.execute(with: input)
        XCTAssertEqual(result, 99788435)
    }

    func testDay7Part2Example() throws {
        let result = AOCDay7.part2.execute(with: exampleInput)
        XCTAssertEqual(result, 168)
    }
}

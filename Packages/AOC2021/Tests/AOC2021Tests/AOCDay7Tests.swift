//
//  AOCDay7Tests.swift
//  
//
//  Created by Kamaal M Farah on 06/12/2021.
//

import XCTest
@testable import AOC2021

final class AOCDay7Tests: XCTestCase {
    let exampleInput = ""

    func testDay7Part1() throws {
        let input = try XCTUnwrap(AOCDay7.input)
        let result = AOCDay7.part1.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testDay7Part1Example() throws {
        let result = AOCDay7.part1.execute(with: exampleInput)
        XCTAssertEqual(result, 0)
    }

    func testDay7Part2() throws {
        let input = try XCTUnwrap(AOCDay7.input)
        let result = AOCDay7.part2.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testDay7Part2Example() throws {
        let result = AOCDay7.part2.execute(with: exampleInput)
        XCTAssertEqual(result, 0)
    }
}

//
//  AOC2022Day9Tests.swift
//
//
//  Created by Kamaal M Farah on 07/12/2022.
//

import XCTest
@testable import AOC2022

final class AOC2022Day9Tests: XCTestCase {
    let exampleInput = """
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
"""

    let exampleInput2 = """
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
"""

    let input = AOC2022.Day9.input
    let day = AOC2022.Day9.self

    func testPart1() {
        let result = day.Part1.execute(with: input)
        XCTAssertNotEqual(result, 6187)
        XCTAssertNotEqual(result, 5646)
        XCTAssertNotEqual(result, 5914)
        XCTAssertNotEqual(result, 3665)
        XCTAssertNotEqual(result, 6148)
        XCTAssertNotEqual(result, 6147)
        XCTAssertEqual(result, 6175)
    }

    func testPart1Example() {
        let result = day.Part1.execute(with: exampleInput)
        XCTAssertEqual(result, 13)
    }

    func testPart2() {
        let result = day.Part2.execute(with: input)
        XCTAssertNotEqual(result, 11040)
//        XCTAssertNotEqual(result, 6175)
//        XCTAssertEqual(result, 0)
    }

    func testPart2Example() {
//        let result = day.Part2.execute(with: exampleInput2)
//        XCTAssertEqual(result, 36)
    }

    // - MARK: Internals

    func testMove() {
        let cases1Knot = [
            (day.move(head: Coordinates.zero, tailHistory: [.zero], command: "R 4", knots: 1), Coordinates(x: 4, y: 0)),
            (day.move(head: Coordinates(x: 4, y: 0), tailHistory: [Coordinates(x: 3, y: 0)], command: "U 4", knots: 1), Coordinates(x: 4, y: 4)),
            (day.move(head: Coordinates(x: 4, y: 4), tailHistory: [Coordinates(x: 4, y: 3)], command: "L 3", knots: 1), Coordinates(x: 1, y: 4)),
            (day.move(head: Coordinates(x: 1, y: 4), tailHistory: [Coordinates(x: 2, y: 4)], command: "D 1", knots: 1), Coordinates(x: 1, y: 3)),
            (day.move(head: Coordinates(x: 1, y: 3), tailHistory: [Coordinates(x: 2, y: 4)], command: "R 4", knots: 1), Coordinates(x: 5, y: 3)),
            (day.move(head: Coordinates(x: 5, y: 3), tailHistory: [Coordinates(x: 4, y: 3)], command: "D 1", knots: 1), Coordinates(x: 5, y: 2)),
            (day.move(head: Coordinates(x: 5, y: 2), tailHistory: [Coordinates(x: 4, y: 3)], command: "L 5", knots: 1), Coordinates(x: 0, y: 2)),
            (day.move(head: Coordinates(x: 0, y: 2), tailHistory: [Coordinates(x: 1, y: 2)], command: "R 2", knots: 1), Coordinates(x: 2, y: 2)),
        ]
        for (index, (result, expectedHead)) in cases1Knot.enumerated() {
            XCTAssertEqual(result.head, expectedHead)
            XCTAssertEqual(result.tailPath.count, Self.tailTrails1Knot[index].count)
            XCTAssertEqual(result.tailPath.map({ "\($0.x),\($0.y)" }), Self.tailTrails1Knot[index].map({ "\($0.x),\($0.y)" }))
        }
    }

    private static let tailTrails1Knot: [[Coordinates]] = [
        [Coordinates.zero, Coordinates(x: 1, y: 0), Coordinates(x: 2, y: 0), Coordinates(x: 3, y: 0)],
        [Coordinates(x: 3, y: 0), Coordinates(x: 4, y: 1), Coordinates(x: 4, y: 2), Coordinates(x: 4, y: 3)],
        [Coordinates(x: 4, y: 3), Coordinates(x: 3, y: 4), Coordinates(x: 2, y: 4)],
        [Coordinates(x: 2, y: 4)],
        [Coordinates(x: 2, y: 4), Coordinates(x: 3, y: 3), Coordinates(x: 4, y: 3)],
        [Coordinates(x: 4, y: 3)],
        [Coordinates(x: 4, y: 3), Coordinates(x: 3, y: 2), Coordinates(x: 2, y: 2), Coordinates(x: 1, y: 2)],
        [Coordinates(x: 1, y: 2)]
    ]
}

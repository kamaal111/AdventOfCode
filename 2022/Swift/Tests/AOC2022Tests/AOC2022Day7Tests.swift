//
//  AOC2022Day7Tests.swift
//
//
//  Created by Kamaal M Farah on 06/12/2022.
//

import XCTest
@testable import AOC2022

final class AOC2022Day7Tests: XCTestCase {
    let exampleInput = """
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
"""

    let input = AOC2022.Day7.input

    func testPart1() {
        let result = AOC2022.Day7.Part1.execute(with: input)
        XCTAssertNotEqual(result, 1287502)
        XCTAssertNotEqual(result, 1077499)
        XCTAssertEqual(result, 1206825)
    }

    func testPart1Example() {
        let result = AOC2022.Day7.Part1.execute(with: exampleInput)
        XCTAssertEqual(result, 95437)
    }

    func testPart2() {
        let result = AOC2022.Day7.Part2.execute(with: input)
        XCTAssertEqual(result, 9608311)
    }

    func testPart2Example() {
        let result = AOC2022.Day7.Part2.execute(with: exampleInput)
        XCTAssertEqual(result, 24933642)
    }
}

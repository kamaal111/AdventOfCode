//
//  Day12Tests.swift
//  AOC
//
//  Created by Kamaal M Farah on 12/12/24.
//

import Testing
import Foundation
@testable import AOC

private let inputURL = Bundle.module.url(forResource: "day12", withExtension: "txt")!
private let input = try! String(contentsOf: inputURL, encoding: .utf8)

private let example = """
RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE
"""

private let example2 = """
AAAA
BBCD
BBCC
EEEC
"""

@Test func day12Part1Example() async throws {
    let result = Day12.part1(example)

    #expect(result == 1930)
}

@Test func day12Part1() async throws {
    let result = Day12.part1(input)

    #expect(result == 1396562)
}

@Test func day12Part2Example() async throws {
    let result = Day12.part2(example2)

    #expect(result == 0)
}

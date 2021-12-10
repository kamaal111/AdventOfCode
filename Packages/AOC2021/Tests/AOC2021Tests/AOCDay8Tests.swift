//
//  AOCDay8Tests.swift
//  
//
//  Created by Kamaal Farah on 07/12/2021.
//

import XCTest
@testable import AOC2021

final class AOCDay8Tests: XCTestCase {
    let exampleInput = """
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
"""

    func testDay8Part1() throws {
        let input = try XCTUnwrap(AOCDay8.input)
        let result = AOCDay8.part1.execute(with: input)
        XCTAssertEqual(result, 383)
    }

    func testDay8Part1Example() throws {
        let result = AOCDay8.part1.execute(with: exampleInput)
        XCTAssertEqual(result, 26)
    }

    func testDay8Part2() throws {
        let input = try XCTUnwrap(AOCDay8.input)
        let result = AOCDay8.part2.execute(with: input)
        XCTAssertEqual(result, 0)
    }

    func testDay8Part2Example() throws {
        let result = AOCDay8.part2.execute(with: exampleInput)
        XCTAssertEqual(result, 61229)
    }
}

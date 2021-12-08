//
//  AOCDay8.swift
//  
//
//  Created by Kamaal Farah on 07/12/2021.
//

import Foundation

struct AOCDay8 {
    public static let part1 = Part1()
    public static let part2 = Part2()

    public static let input: String? = {
        guard let inputURL = Bundle.module.url(forResource: "day8", withExtension: "txt") else { return nil }
        return try? String(contentsOf: inputURL, encoding: .utf8)
    }()

    private init() { }

    public struct Part1 {
        fileprivate init() { }

        /// 1 -> cf
        /// 4 -> bdf | bcd
        /// 7 -> acf
        /// 8 -> abdeg | acdfg | abdfg | acdeg
        public func execute(with input: String) -> Int {
            let singleMapping: [Int: [String]] = [
                1: ["cf"],
                4: [],
                7: [],
                8: []
            ]
            let combinedMapping: [Int: String] = [
                1: "cf",
                4: "bcdf",
                7: "acf",
                8: "abcdefg"
            ]
            var sum = 0
            for (lineNumber, line) in input.splitLines.enumerated() {
                let splittedLine = line.split(separator: "|")
                let outputs = splittedLine[1]
                for output in outputs.split(separator: " ") {
                    let orderedOutput = String(output.sorted())
                    var broke = false
                    mappingLoop: for item in combinedMapping {
                        if item.value.contains(orderedOutput) {
                            sum += 1
                            broke = true
                            print(lineNumber, "found", output)
//                            break mappingLoop
                        }
                    }
//                    if !broke {
//                        print(lineNumber, "not found", output)
//                    }
                }
            }
            return sum
        }
    }

    public struct Part2 {
        fileprivate init() { }

        public func execute(with input: String) -> Int {
            return 0
        }
    }
}

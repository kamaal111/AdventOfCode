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

        public func execute(with input: String) -> Int {
            var sum = 0
            for (_, line) in input.splitLines.enumerated() {
                let splittedLine = line.split(separator: "|")
                let outputs = splittedLine[1]
                for output in outputs.split(separator: " ") {
                    let orderedOutput = String(output.sorted())
                    if [2, 3, 4, 7].contains(orderedOutput.count) {
                        sum += 1
                    }
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

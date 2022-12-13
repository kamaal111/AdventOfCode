//
//  Day13.swift
//  
//
//  Created by Kamaal M Farah on 13/12/2022.
//

import Foundation
import ShrimpExtensions

typealias AnyArray = [Any]

extension AOC2022 {
    public enum Day13: DayScaffold {
        public static let resourceName = "day13"

        public enum Part1 {
            public static func execute(with input: String) -> Int {
                let pairs = parseInput(input)
                for pair in pairs {
                    comparePairs(left: pair.left, right: pair.right)
                    break
                }
                return 0
            }
        }

        public enum Part2 {
            public static func execute(with input: String) -> Int {
                0
            }
        }

        private static func comparePairs(left: Any, right: Any) {
            if left is AnyArray {
                print("left is array", left)
            }
        }

        private static func parseInput(_ input: String) -> [(left: [Any], right: [Any])] {
            var pairs: [([Any], [Any])] = []
            var single: [Any]?
            for line in input.splitLines(omittingEmptySubsequences: false) {
                if let parsedLine = parseLine(line) {
                    if let unwrappedSingle = single {
                        pairs = pairs.appended((unwrappedSingle, parsedLine))
                        single = nil
                    } else {
                        single = parsedLine
                    }
                }
            }
            return pairs
        }

        private static func parseLine(_ line: String.SubSequence) -> [Any]? {
            guard line != "" else { return nil }
            guard line.count > 2 else { return [] }

            let data = line.data(using: .utf8)!
            let array = try! JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            return refineParsedLine(array)
        }

        private static func refineParsedLine(_ parsedLine: [Any]) -> [Any] {
            var refined: [Any] = []
            for element in parsedLine {
                if element is Int {
                    refined = refined.appended(element)
                } else if element is NSArray {
                    let refinedArrayElement = refineParsedLine(element as! [Any])
                    refined = refined.appended(refinedArrayElement)
                } else {
                    fatalError("What are you? \(type(of: element))")
                }
            }
            return refined
        }
    }
}

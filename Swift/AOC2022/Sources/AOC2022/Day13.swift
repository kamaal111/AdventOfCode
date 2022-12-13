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
                parseInput(input)
                    .enumerated()
                    .reduce(0, {
                        let comparison = comparePairs(left: $1.element.left, right: $1.element.right)
                        if comparison == .rightHigher {
                            return $0 + ($1.offset + 1)
                        }
                        return $0
                    })
            }
        }

        public enum Part2 {
            public static func execute(with input: String) -> Int {
                let pairs = parseInput(input)
                return 0
            }
        }

        private static func comparePairs(left: Any, right: Any) -> PairComparison {
            if let left = left as? Int {
                if let right = right as? Int {
                    if left < right {
                        return .rightHigher
                    }
                    if left > right {
                        return .rightLower
                    }
                    return .same
                }

                return comparePairs(left: [left], right: right)
            }

            if let right = right as? Int {
                return comparePairs(left: left, right: [right])
            }

            if let left = left as? AnyArray, let right = right as? AnyArray {
                var left = left.reversed().asArray()
                var right = right.reversed().asArray()
                while !left.isEmpty && !right.isEmpty {
                    let leftElement = left.popLast()!
                    let rightElement = right.popLast()!
                    let comparison = comparePairs(left: leftElement, right: rightElement)
                    if comparison == .same {
                        continue
                    }
                    return comparison
                }
                if left.count > right.count {
                    return .rightLower
                }
                if left.count < right.count {
                    return .rightHigher
                }
                return .same
            }

            fatalError("Impossibru")
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
                    refined = refined.appended(element as! Int)
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

private enum PairComparison {
    case same
    case rightHigher
    case rightLower
}

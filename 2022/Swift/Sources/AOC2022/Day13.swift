//
//  Day13.swift
//  
//
//  Created by Kamaal M Farah on 13/12/2022.
//

import Foundation
import ShrimpExtensions

private typealias AnyArray = [Any]

extension AOC2022 {
    public enum Day13: DayScaffold {
        public static let resourceName = "day13"

        public enum Part1 {
            public static func execute(with input: String) -> Int {
                parseInputAsPairs(input)
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
                let startDivider = [[2]]
                let endDivider = [[6]]
                let singles = parseInputAsSingles("\(startDivider)\n\(endDivider)\n\(input)")
                    .sorted(by: {
                        comparePairs(left: $0, right: $1) == .rightHigher
                    })

                var startDividerIndex: Int?
                var endDividerIndex: Int?
                for (index, single) in singles.enumerated() {
                    if startDividerIndex == nil && (single as? [[Int]]) == startDivider {
                        startDividerIndex = index + 1
                    }
                    if startDividerIndex != nil && (single as? [[Int]]) == endDivider {
                        endDividerIndex = index + 1
                        break
                    }
                }

                return startDividerIndex! * endDividerIndex!
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

            if right is Int {
                return comparePairs(left: left, right: [right])
            }

            var left = (left as! AnyArray).reversed().asArray()
            var right = (right as! AnyArray).reversed().asArray()
            while !left.isEmpty && !right.isEmpty {
                let leftElement = left.popLast()!
                let rightElement = right.popLast()!
                let comparison = comparePairs(left: leftElement, right: rightElement)
                if comparison != .same {
                    return comparison
                }
            }

            if left.count > right.count {
                return .rightLower
            }

            if left.count < right.count {
                return .rightHigher
            }

            return .same
        }

        private static func parseInputAsSingles(_ input: String) -> [AnyArray] {
            input
                .splitLines
                .map(parseLine)
        }

        private static func parseInputAsPairs(_ input: String) -> [(left: AnyArray, right: AnyArray)] {
            var pairs: [(AnyArray, AnyArray)] = []
            var single: AnyArray?
            for line in input.splitLines {
                let parsedLine = parseLine(line)
                if let unwrappedSingle = single {
                    pairs = pairs.appended((unwrappedSingle, parsedLine))
                    single = nil
                } else {
                    single = parsedLine
                }
            }
            return pairs
        }

        private static func parseLine(_ line: String.SubSequence) -> AnyArray {
            let data = line.data(using: .utf8)!
            let array = try! JSONSerialization.jsonObject(with: data, options: []) as! AnyArray
            return refineParsedLine(array)
        }

        private static func refineParsedLine(_ parsedLine: AnyArray) -> AnyArray {
            parsedLine
                .map({
                    if $0 is NSNumber {
                        return $0 as! Int
                    }
                    if $0 is NSArray {
                        return refineParsedLine($0 as! AnyArray)
                    }
                    fatalError("What are you? \(type(of: $0))")
                })
        }
    }
}

private enum PairComparison {
    case same
    case rightHigher
    case rightLower
}

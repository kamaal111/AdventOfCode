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

                var pairsInTheRightOrder: [Int] = []
                for (index, pair) in pairs.enumerated() {
                inner:
                    for (leftIndex, leftElement) in pair.left.enumerated() {
                        if let right = pair.right.at(leftIndex) {
                            let comparison = comparePairs(left: leftElement, right: right)
                            switch comparison {
                            case .same:
                                continue
                            case .rightHigher:
                                pairsInTheRightOrder = pairsInTheRightOrder.appended(index + 1)
                                break inner
                            case .rightLower:
                                break inner
                            }
                        } else {
                            break
                        }
                    }
                }

                print(pairsInTheRightOrder)
                return pairsInTheRightOrder.reduce(0, { $0 + $1 })
            }
        }

        public enum Part2 {
            public static func execute(with input: String) -> Int {
                0
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
                for (index, leftElement) in left.enumerated() {
                    if let rightElement = right.at(index) {
                        let comparison = comparePairs(left: leftElement, right: rightElement)
                        print(leftElement, rightElement, comparison)
                        switch comparison {
                        case .same:
                            continue
                        case .rightHigher:
                            return .rightHigher
                        case .rightLower:
                            return .rightLower
                        }
                    } else {
                        return .rightLower
                    }
                }
            }

            fatalError("yes")
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

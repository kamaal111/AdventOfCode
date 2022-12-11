//
//  Day11.swift
//  
//
//  Created by Kamaal M Farah on 11/12/2022.
//

import Foundation
import Algorithms
import ShrimpExtensions

extension AOC2022 {
    public enum Day11: DayScaffold {
        public static let resourceName = "day11"

        public enum Part1 {
            public static func execute(with input: String) -> Int {
                keepAwayPlayInteractions(input, rounds: 20)
            }
        }

        public enum Part2 {
            public static func execute(with input: String) -> Int {
                keepAwayPlayInteractions(input, rounds: 20)
            }
        }
    }

    static func keepAwayPlayInteractions(_ input: String, rounds: Int) -> Int {
        var monkeys = parseMonkeys(from: input)

        var round = 0
        while round < rounds {
            for id in monkeys.keys.sorted() {
                let monkey = monkeys[id]!
                monkeys[id]!.itemsInspected += monkey.items.count
                for item in monkey.items.reversed() {
                    let newWorryLevel = calculateOperation(monkey.operation, worryLevel: item) / 3
                    let monkeyToThrowTo = monkey.decision[(newWorryLevel % monkey.testDivisbleBy) == 0]!
                    monkeys[monkeyToThrowTo]!.items = monkeys[monkeyToThrowTo]!.items.appended(newWorryLevel)
                    _ = monkeys[id]!.items.popLast()
                }
            }
            round += 1
        }

        return monkeys
            .sorted(by: { $0.value.itemsInspected > $1.value.itemsInspected })
            .range(from: 0, to: 2)
            .reduce(1, { $0 * $1.value.itemsInspected })
    }

    static func calculateOperation(_ rawOperation: String, worryLevel: Int) -> Int {
        if rawOperation.contains("*") {
            return formatOperation(rawOperation, worryLevel: worryLevel, operator: "*")
                .reduce(1, *)
        } else if rawOperation.contains("+") {
            return formatOperation(rawOperation, worryLevel: worryLevel, operator: "+")
                .reduce(0, +)
        }

        fatalError("Ain't no way")
    }

    static func formatOperation(_ rawOperation: String, worryLevel: Int, operator: String) -> [Int] {
        rawOperation
            .split(separator: `operator`)
            .map({
                if $0.contains("old") {
                    return worryLevel
                }
                return $0.trimmingCharacters(in: .whitespaces).int!
            })
    }

    static func parseMonkeys(from input: String) -> [Monkey.ID: Monkey] {
        let lines = input.splitLines
        let strides = 6

        return lines
            .enumerated()
            .striding(by: strides)
            .map({
                let monkeyID: Monkey.ID = $0.offset / strides
                let monkeyInfo = lines
                    .range(from: $0.offset + 1, to: $0.offset + strides)
                    .map({
                        let keyValue = $0.split(separator: ":")
                        return keyValue[1]
                    })
                let items = monkeyInfo[0]
                    .split(separator: ",")
                    .map({ $0.trimmingCharacters(in: .whitespaces).int! })
                let operation = monkeyInfo[1]
                    .split(separator: "=")[1]
                    .trimmingCharacters(in: .whitespaces)
                let testDivisbleBy = monkeyInfo[2].filter(\.isNumber).int!
                let decisionTrue: Monkey.ID = monkeyInfo[3].filter(\.isNumber).int!
                let decisionFalse: Monkey.ID = monkeyInfo[4].filter(\.isNumber).int!

                return Monkey(
                    id: monkeyID,
                    items: items,
                    operation: operation,
                    testDivisbleBy: testDivisbleBy,
                    decision: [true: decisionTrue, false: decisionFalse])
            })
            .reduce([:], {
                var result = $0
                result[$1.id] = $1
                return result
            })
    }
}

struct Monkey: Identifiable {
    let id: Int
    var items: [Int]
    let operation: String
    let testDivisbleBy: Int
    let decision: [Bool: Monkey.ID]
    var itemsInspected = 0
}

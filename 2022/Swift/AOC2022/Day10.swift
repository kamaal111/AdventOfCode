//
//  Day10.swift
//  
//
//  Created by Kamaal M Farah on 10/12/2022.
//

import Foundation
import ShrimpExtensions

private let CHECKPOINTS = [20, 60, 100, 140, 180, 220]
private let CRT_SIZE = Size(width: 40, height: 6)
private let SPRITE_SIZE = 3

extension AOC2022 {
    public enum Day10: DayScaffold {
        public static let resourceName = "day10"

        public enum Part1 {
            public static func execute(with input: String) -> Int {
                let cycles = simulateCycles(input, untill: CHECKPOINTS.last!)
                return CHECKPOINTS
                    .reduce(0, { $0 + cycles[$1]! })
            }
        }

        public enum Part2 {
            public static func execute(with input: String) -> String {
                drawSprites(input)
            }
        }

        static func drawSprites(_ input: String) -> String {
            let grid = Grid(size: CRT_SIZE, defaultValue: "x")
            let screen = grid.items
                .reduce("", {
                    $0 + $1.joined() + "\n"
                })
            return screen
        }

        static func simulateCycles(_ input: String, untill cycleEnd: Int) -> [Int: Int] {
            var cycles = 1
            var xValue = 1
            var checkpoints = CHECKPOINTS.reversed().asArray()
            var sums: [Int: Int] = CHECKPOINTS.reduce([:], {
                var result = $0
                result[$1] = 1
                return result
            })

            for command in input.splitLines {
                let result = parse(String(command))
                let previousXValue = xValue

                cycles += result.cycles
                xValue += result.value

                if cycles == checkpoints.last! {
                    let checkpoint = checkpoints.popLast()!
                    sums[checkpoint] = xValue * checkpoint
                } else if (cycles - 1) == checkpoints.last! {
                    let checkpoint = checkpoints.popLast()!
                    sums[checkpoint] = previousXValue * checkpoint
                }

                if cycles >= cycleEnd || checkpoints.isEmpty {
                    break
                }
            }

            return sums
        }

        static func parse(_ command: String) -> ParseResult {
            if command == "noop" {
                return ParseResult(cycles: 1, value: 0)
            }

            let value = command.split(separator: " ")[1].int!
            return ParseResult(cycles: 2, value: value)
        }

        struct ParseResult: Equatable {
            let cycles: Int
            let value: Int
        }
    }
}

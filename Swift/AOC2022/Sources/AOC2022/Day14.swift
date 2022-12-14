//
//  Day14.swift
//  
//
//  Created by Kamaal M Farah on 14/12/2022.
//

import Foundation
import ShrimpExtensions

private let STARTING_POINT = Coordinates(x: 500, y: 0)

extension AOC2022 {
    public enum Day14: DayScaffold {
        public static let resourceName = "day14"

        public enum Part1 {
            public static func execute(with input: String) -> Int {
                let grid = parseInput(input)
                return 0
            }
        }

        public enum Part2 {
            public static func execute(with input: String) -> Int {
                0
            }
        }

        private static func parseInput(_ input: String) -> Grid<Plot> {
            var size = Size(width: 0, height: 0)
            var rockLine: [[Coordinates]] = []

            for line in input.splitLines {
                let parsedLine = parseLine(line)
                rockLine = rockLine.appended(parsedLine)
                for coordinate in parsedLine {
                    if (coordinate.x + 1) > size.width {
                        size.width = coordinate.x + 1
                    }
                    if (coordinate.y + 1) > size.height {
                        size.height = coordinate.y + 1
                    }
                }
            }

            var grid = Grid(size: size, defaultValue: Plot.air)
            grid.setCell(at: STARTING_POINT, with: .start)
            for line in rockLine {
                for rock in line {
                    grid.setCell(at: rock, with: .rock)
                }
            }

            return grid
        }

        private static func parseLine(_ line: String.SubSequence) -> [Coordinates] {
            line
                .split(separator: "->")
                .map({
                    let coordinates = $0.trimmingCharacters(in: .whitespaces).splitCommas
                    return Coordinates(x: coordinates[0].int!, y: coordinates[1].int!)
                })
        }
    }
}

private enum Plot: String {
    case start = "+"
    case air = "."
    case rock = "#"
    case sand = "o"
}

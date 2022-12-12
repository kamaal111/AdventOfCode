//
//  Day12.swift
//  
//
//  Created by Kamaal M Farah on 12/12/2022.
//

import Foundation
import Algorithms
import ShrimpExtensions

extension AOC2022 {
    public enum Day12: DayScaffold {
        public static let resourceName = "day12"

        public enum Part1 {
            public static func execute(with input: String) -> Int {
                let result = parse(input)
                makePaths(result.grid, from: [result.start], to: result.end)
                return 0
            }
        }

        public enum Part2 {
            public static func execute(with input: String) -> Int {
                0
            }
        }

        private static func parse(_ input: String) -> ParseResult {
            var grid = Grid<Elevation>()
            var start: Coordinates!
            var end: Coordinates!

            for (x, line) in input.splitLines.enumerated() {
                var row: [Elevation] = []
                for (y, character) in line.enumerated() {
                    row = row.appended(Elevation(character: character))
                    if character == "S" {
                        start = Coordinates(x: x, y: y)
                    } else if character == "E" {
                        end = Coordinates(x: x, y: y)
                    }
                }
                grid.addRow(row)
            }

            return ParseResult(grid: grid, start: start, end: end)
        }

        private static func makePaths(_ grid: Grid<Elevation>, from start: [Coordinates], to end: Coordinates) {
            let max = 1

//            var grid = grid
            var i = 0
            let currentPosition = start.last!
            while i < max {
                let currentElevation = grid.getCell(x: currentPosition.x, y: currentPosition.y)!
                print("current", currentElevation)
                if currentPosition.y < grid.width { // right
                    let rightElevation = grid.getCell(at: currentPosition.right)!
                    print("right", rightElevation)
                }
                if currentPosition.y > 0 { // left
                    let leftElevation = grid.getCell(at: currentPosition.left)!
                    print("left", leftElevation)
                }
                if currentPosition.x < grid.height { // down
                    let downElevation = grid.getCell(at: currentPosition.down)!
                    print("down", downElevation)
                }
                if currentPosition.x > 0 { // up
                    let upElevation = grid.getCell(at: currentPosition.up)!
                    print("up", upElevation)
                }
                i += 1
            }
//            print(grid)
        }
    }
}

private struct ParseResult {
    let grid: Grid<Elevation>
    let start: Coordinates
    let end: Coordinates
}

private struct Elevation {
    let character: Character

    var height: Int {
        if character.isLowercase {
            return Int(character.asciiValue!) - 96
        }
        return Int(character.asciiValue!) - 38
    }
}

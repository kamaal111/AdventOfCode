//
//  Day14.swift
//  
//
//  Created by Kamaal M Farah on 14/12/2022.
//

import Foundation
import ShrimpExtensions

private let STARTING_POINT = Coordinates(x: 0, y: 500)

extension AOC2022 {
    public enum Day14: DayScaffold {
        public static let resourceName = "day14"

        public enum Part1 {
            public static func execute(with input: String) -> Int {
                let grid = parseInput(input)
                return pourSand(in: grid)
            }
        }

        public enum Part2 {
            public static func execute(with input: String) -> Int {
                0
            }
        }

        private static func pourSand(
            in grid: Grid<Plot>,
            start: Coordinates = STARTING_POINT.south,
            units: Int = 0,
            iterations: Int = 0) -> Int {
                print("units", units, iterations)
                guard iterations < 12_429 else {
                    // close to stack overflow
                    return units
                }

                let trajectory = grid.getColumn(x: start.x, y: start.y, until: { $0.cell != .air })
                let landing = trajectory.last!
                let southCell = grid.getCell(at: landing.coordinate.south)!
                if southCell == .abyss {
                    return units
                }

                let southWestCoordinates = landing.coordinate.southWest
                let southWest = grid.getCell(at: southWestCoordinates)!
                switch southWest {
                case .start:
                    fatalError("No Way Jose")
                case .air:
                    return pourSand(in: grid, start: southWestCoordinates, units: units, iterations: iterations + 1)
                case .rock, .sand:
                    break // Go on to south east
                case .abyss:
                    return units
                }

                let southEastCoordinates = landing.coordinate.southEast
                let southEast = grid.getCell(at: southEastCoordinates)
                switch southEast {
                case .start:
                    fatalError("Huh?")
                case .air:
                    return pourSand(in: grid, start: southEastCoordinates, units: units, iterations: iterations + 1)
                case .rock, .sand, .none:
                    var grid = grid
                    grid.setCell(at: landing.coordinate, with: .sand)
                    return pourSand(in: grid, start: STARTING_POINT.south, units: units + 1, iterations: iterations + 1)
                case .abyss:
                    return units
                }
            }

        private static func parseInput(_ input: String) -> Grid<Plot> {
            var size = Size(width: 0, height: 0)
            var rockLine: [[Coordinates]] = []

            for line in input.splitLines {
                let parsedLine = parseLine(line)
                rockLine = rockLine.appended(parsedLine)
                for coordinate in parsedLine {
                    if (coordinate.x + 1) > size.height {
                        size.height = coordinate.x + 1
                    }
                    if (coordinate.y + 1) > size.width {
                        size.width = coordinate.y + 1
                    }
                }
            }

            var grid = Grid(size: size, defaultValue: Plot.air)
            grid.setCell(at: STARTING_POINT, with: .start)
            for line in rockLine {
                var line = line.reversed().asArray()
                var point = line.popLast()
                while point != nil {
                    let next = line.popLast()
                    if let next {
                        grid.setCells(point!.to(next).concat([point!, next]), with: .rock)
                    }
                    point = next
                }
            }
            let abyss = (0..<size.width)
                .map({ _ in Plot.abyss })
            grid.addRow(abyss)

            return grid
        }

        private static func parseLine(_ line: String.SubSequence) -> [Coordinates] {
            line
                .split(separator: "->")
                .map({
                    let coordinates = $0.trimmingCharacters(in: .whitespaces).splitCommas
                    return Coordinates(x: coordinates[1].int!, y: coordinates[0].int!)
                })
        }
    }
}

private enum Plot: String {
    case start = "+"
    case air = "."
    case rock = "#"
    case sand = "o"
    case abyss = "~"
}

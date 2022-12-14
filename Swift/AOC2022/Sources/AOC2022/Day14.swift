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
                let grid = parseInput(input, withAbyss: true)
                return pourSand(in: grid)
            }
        }

        public enum Part2 {
            public static func execute(with input: String) -> Int {
                let grid = parseInput(input, withAbyss: false)
                return pourSand(in: grid)
            }
        }

        private static func pourSand(in grid: Grid<Plot>) -> Int {
            let floor = 0..<(grid.height + 1)
            var start = STARTING_POINT.south
            var units = 0
            var grid = grid

            var iteration = 0
            while true {
                print(iteration, units)
                iteration += 1
                let trajectory = grid.getColumn(x: start.x, y: start.y, until: { $0.cell != .air })
                guard let landing = trajectory.last, landing.cell != .start else {
                    // Can't pour anymore
                    return units
                }

                let southCoordinates = landing.coordinate.south
                if !floor.contains(southCoordinates.x) {
                    grid.setCell(at: landing.coordinate, with: .sand)
                    units += 1
                    start = STARTING_POINT.south
                    continue
                }

                guard let southCell = grid.getCell(at: southCoordinates) else {
                    let air = (0..<grid.width)
                        .map({ _ in Plot.air }) // breath air
                    grid.addRow(air)
                    start = southCoordinates
                    continue
                }
                if southCell == .abyss {
                    return units
                }

                let southWestCoordinates = landing.coordinate.southWest
                if floor.contains(southWestCoordinates.x) {
                    let southWest = grid.getCell(at: southWestCoordinates)!
                    switch southWest {
                    case .start:
                        fatalError("No Way Jose")
                    case .air:
                        start = southWestCoordinates
                        continue
                    case .rock, .sand:
                        break // Go on to south east
                    case .abyss:
                        return units
                    }
                }

                let southEastCoordinates = landing.coordinate.southEast
                if !floor.contains(southEastCoordinates.x) {
                    grid.setCell(at: landing.coordinate, with: .sand)
                    units += 1
                    start = STARTING_POINT.south
                    continue
                }

                let southEast = grid.getCell(at: southEastCoordinates)
                switch southEast {
                case .start:
                    fatalError("Huh?")
                case .air:
                    start = southEastCoordinates
                    continue
                case .rock, .sand, .none:
                    grid.setCell(at: landing.coordinate, with: .sand)
                    units += 1
                    start = STARTING_POINT.south
                    continue
                case .abyss:
                    return units
                }
            }

            fatalError("Just don't escape")
        }

        private static func parseInput(_ input: String, withAbyss: Bool) -> Grid<Plot> {
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

            if size != grid.size {
                fatalError("Why are you doing this to me?")
            }

            if withAbyss {
                let abyss = (0..<size.width)
                    .map({ _ in Plot.abyss })
                grid.addRow(abyss)
            }

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

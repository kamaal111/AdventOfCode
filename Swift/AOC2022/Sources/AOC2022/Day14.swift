//
//  Day14.swift
//  
//
//  Created by Kamaal M Farah on 14/12/2022.
//

import Foundation
import ShrimpExtensions

private let STARTING_POINT = Coordinates(x: 500, y: 0)
private let DRIP_POINT = STARTING_POINT.south

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
            var start = DRIP_POINT
            var iterations = 0
            var units = 0
            var grid = grid

            func rest(_ coordinates: Coordinates) {
                units += 1
                start = DRIP_POINT
                grid.setCell(at: coordinates, with: .sand)
            }

            func roll(_ coordinates: Coordinates) {
                start = coordinates
            }

            while true {
                iterations += 1
                print("iterations=\(iterations); units=\(units); start=(x: \(start.x), y: \(start.y))")
                let trajectory = grid
                    .getColumn(start: start.y, x: start.x, until: { $0.cell != .air })
                    .prepended((.start, start))
                let landing = trajectory.last!

                let southCoordinates = landing.coordinate.south
                let southCell = grid.getCell(at: southCoordinates)!
                switch southCell {
                case .start:
                    if southCoordinates == DRIP_POINT {
                        fatalError("Not in the first part")
                    }
                case .air:
                    roll(southCoordinates) // roll deeper
                    continue
                case .rock, .sand:
                    break // look left and then right before crossing
                case .abyss:
                    return units
                }

                let southWestCoordinates = landing.coordinate.southWest
                let southWestCell = grid.getCell(at: southWestCoordinates)!
                switch southWestCell {
                case .start:
                    fatalError("Huh?")
                case .air:
                    roll(southWestCoordinates)
                    continue
                case .rock, .sand:
                    break // check south east
                case .abyss:
                    return units
                }

                let southEastCoordinates = landing.coordinate.southEast
                let southEastCell = grid.getCell(at: southEastCoordinates)
                switch southEastCell {
                case .start:
                    fatalError("It will not work this time either")
                case .air:
                    roll(southEastCoordinates)
                    continue
                case .rock, .sand, .none:
                    rest(landing.coordinate)
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
                var line = line.reversed().asArray()
                var point = line.popLast()
                while point != nil {
                    let next = line.popLast()
                    if let next {
                        let rockCoordinates = point!.to(next).concat([point!, next])
                        grid.setCells(rockCoordinates, with: .rock)
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
                    return Coordinates(x: coordinates[0].int!, y: coordinates[1].int!)
                })
        }

        private static func drawGrid(_ grid: Grid<Plot>, from start: Int) {
            let drawnGrid = grid
                .items
                .map({
                    $0
                        .range(from: start)
                        .map(\.rawValue)
                        .joined()
                })
                .joined(separator: "\n")
            print(drawnGrid)
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

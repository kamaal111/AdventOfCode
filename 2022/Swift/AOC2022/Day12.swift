//
//  Day12.swift
//  
//
//  Created by Kamaal M Farah on 12/12/2022.
//

import Foundation
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
            let status = findEnd(grid, from: start, to: end, endPaths: [])
            print("status", status)
        }

        private static func findEnd(
            _ grid: Grid<Elevation>,
            from start: [Coordinates],
            to end: Coordinates,
            endPaths: [PathFindingStatus]) -> PathFindingStatus {
                let currentPosition = start.last!
                let currentElevation = grid.getCell(at: currentPosition)!

                print("iter", start.count)
                var isDeadEnd = true
                var endPaths = endPaths
                if currentPosition.y < grid.width - 1 && !start.contains(currentPosition.east) { // right
                    let rightElevation = grid.getCell(at: currentPosition.east)!
                    if currentElevation.canWalk(up: rightElevation) {
                        let newPath = start.appended(currentPosition.east)
                        if currentPosition.east == end {
                            endPaths = endPaths.appended(.end(path: newPath))
                        } else {
                            let status = findEnd(grid, from: newPath, to: end, endPaths: endPaths)
                            switch status {
                            case .end(path: let path):
                                endPaths = endPaths.appended(.end(path: path))
                            case .onGoing:
                                isDeadEnd = false
                            case .dead:
                                break
                            }
                        }
                    }
                }

                if currentPosition.y > 0 && !start.contains(currentPosition.west) { // left
                    let leftElevation = grid.getCell(at: currentPosition.west)!
                    if currentElevation.canWalk(up: leftElevation) {
                        let newPath = start.appended(currentPosition.west)
                        if currentPosition.west == end {
                            endPaths = endPaths.appended(.end(path: newPath))
                        } else {
                            let status = findEnd(grid, from: newPath, to: end, endPaths: endPaths)
                            switch status {
                            case .end(path: let path):
                                endPaths = endPaths.appended(.end(path: path))
                            case .onGoing:
                                isDeadEnd = false
                            case .dead:
                                break
                            }
                        }
                    }
                }

                if currentPosition.x < grid.height - 1 && !start.contains(currentPosition.south) { // down
                    let downElevation = grid.getCell(at: currentPosition.south)!
                    if currentElevation.canWalk(up: downElevation) {
                        let newPath = start.appended(currentPosition.south)
                        if currentPosition.south == end {
                            endPaths = endPaths.appended(.end(path: newPath))
                        } else {
                            let status = findEnd(grid, from: newPath, to: end, endPaths: endPaths)
                            switch status {
                            case .end(path: let path):
                                endPaths = endPaths.appended(.end(path: path))
                            case .onGoing:
                                isDeadEnd = false
                            case .dead:
                                break
                            }
                        }
                    }
                }

                if currentPosition.x > 0 && !start.contains(currentPosition.north) { // up
                    let upElevation = grid.getCell(at: currentPosition.north)!
                    if currentElevation.canWalk(up: upElevation) {
                        let newPath = start.appended(currentPosition.north)
                        if currentPosition.north == end {
                            endPaths = endPaths.appended(.end(path: newPath))
                        } else {
                            let status = findEnd(grid, from: newPath, to: end, endPaths: endPaths)
                            switch status {
                            case .end(path: let path):
                                endPaths = endPaths.appended(.end(path: path))
                            case .onGoing:
                                isDeadEnd = false
                            case .dead:
                                break
                            }
                        }
                    }
                }

                if !endPaths.isEmpty {
                    let shortestPath = endPaths
                        .compactMap({ status -> [Coordinates]? in
                            switch status {
                            case .onGoing, .dead:
                                return nil
                            case .end(let path):
                                return path
                            }
                        })
                        .sorted(by: \.count, using: .orderedAscending)
                    print("shortestPath", shortestPath)
                    return .end(path: shortestPath.first!)
                }

                if isDeadEnd {
                    return .dead
                }

                return .onGoing
            }
    }
}

enum PathFindingStatus: Equatable {
    case dead
    case onGoing
    case end(path: [Coordinates])
}

private struct ParseResult {
    let grid: Grid<Elevation>
    let start: Coordinates
    let end: Coordinates
}

private struct Elevation: Equatable {
    let character: Character

    var height: Int {
        if character.isLowercase {
            return Int(character.asciiValue!) - 96
        }
        return Int(character.asciiValue!) - 38
    }

    func canWalk(up otherElevation: Elevation) -> Bool {
        (otherElevation.height >= height && (otherElevation.height - height) <= 1) || otherElevation.height < height
    }
}

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
                if currentPosition.y < grid.width - 1 && !start.contains(currentPosition.right) { // right
                    let rightElevation = grid.getCell(at: currentPosition.right)!
                    if currentElevation.canWalk(up: rightElevation) {
                        let newPath = start.appended(currentPosition.right)
                        if currentPosition.right == end {
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

                if currentPosition.y > 0 && !start.contains(currentPosition.left) { // left
                    let leftElevation = grid.getCell(at: currentPosition.left)!
                    if currentElevation.canWalk(up: leftElevation) {
                        let newPath = start.appended(currentPosition.left)
                        if currentPosition.left == end {
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

                if currentPosition.x < grid.height - 1 && !start.contains(currentPosition.down) { // down
                    let downElevation = grid.getCell(at: currentPosition.down)!
                    if currentElevation.canWalk(up: downElevation) {
                        let newPath = start.appended(currentPosition.down)
                        if currentPosition.down == end {
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

                if currentPosition.x > 0 && !start.contains(currentPosition.up) { // up
                    let upElevation = grid.getCell(at: currentPosition.up)!
                    if currentElevation.canWalk(up: upElevation) {
                        let newPath = start.appended(currentPosition.up)
                        if currentPosition.up == end {
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

private struct Elevation {
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

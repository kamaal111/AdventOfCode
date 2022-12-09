//
//  Day9.swift
//
//
//  Created by Kamaal M Farah on 08/12/2022.
//

import Foundation
import ShrimpExtensions

extension AOC2022 {
    public enum Day9: DayScaffold {
        public static let resourceName = "day9"

        public enum Part1 {
            public static func execute(with input: String) -> Int {
                var locationsVisitedByTails: [MarkedCell] = [MarkedCell(coordinates: .zero, end: .tail)]
                var headLocation = MarkedCell(coordinates: .zero, end: .head)

                for line in input.splitLines {
                    let command = line.split(separator: " ")
                    let direction = command[0]
                    let range = 0..<command[1].int!
                    let currentMove = Move(rawValue: String(direction))!

                    switch currentMove {
                    case .right:
                        print("--------------------")
                        print("move", currentMove)
                        for i in range {
                            let lastHeadLocation = headLocation.coordinates
                            headLocation.coordinates.x += 1
                            if i != 0 && !locationsVisitedByTails.last!.coordinates.isDiagonal(from: lastHeadLocation) {
                                locationsVisitedByTails.append(MarkedCell(coordinates: lastHeadLocation, end: .tail))
                            }

                            printStep(head: headLocation.coordinates, tail: locationsVisitedByTails.last!.coordinates)
                        }
                        print("--------------------")
                    case .down:
                        print("--------------------")
                        print("move", currentMove)
                        for i in range {
                            let lastHeadLocation = headLocation.coordinates
                            headLocation.coordinates.y -= 1
                            if i != 0 && !locationsVisitedByTails.last!.coordinates.isDiagonal(from: lastHeadLocation) {
                                locationsVisitedByTails.append(MarkedCell(coordinates: lastHeadLocation, end: .tail))
                            }

                            printStep(head: headLocation.coordinates, tail: locationsVisitedByTails.last!.coordinates)
                        }
                        print("--------------------")
                    case .left:
                        print("--------------------")
                        print("move", currentMove)
                        for i in range {
                            let lastHeadLocation = headLocation.coordinates
                            headLocation.coordinates.x -= 1
                            if i != 0 && !locationsVisitedByTails.last!.coordinates.isDiagonal(from: lastHeadLocation) {
                                locationsVisitedByTails.append(MarkedCell(coordinates: lastHeadLocation, end: .tail))
                            }

                            printStep(head: headLocation.coordinates, tail: locationsVisitedByTails.last!.coordinates)
                        }
                        print("--------------------")
                    case .up:
                        print("--------------------")
                        print("move", currentMove)
                        for i in range {
                            let lastHeadLocation = headLocation.coordinates
                            headLocation.coordinates.y += 1
                            if i != 0 && !locationsVisitedByTails.last!.coordinates.isDiagonal(from: lastHeadLocation) {
                                locationsVisitedByTails.append(MarkedCell(coordinates: lastHeadLocation, end: .tail))
                            }

                            printStep(head: headLocation.coordinates, tail: locationsVisitedByTails.last!.coordinates)
                        }
                        print("--------------------")
                    }
                }

                print("locationsVisitedByTails", locationsVisitedByTails.map({ "\($0.coordinates.x),\($0.coordinates.y)" }), locationsVisitedByTails.uniques().count)
                return locationsVisitedByTails.uniques().count
            }
        }

        public enum Part2 {
            public static func execute(with input: String) -> Int {
                0
            }
        }
    }
}

private func printStep(head: Coordinates, tail: Coordinates) {
    print("tail", tail)
    print("head", head)
}

private enum Move: String {
    case up = "U"
    case down = "D"
    case right = "R"
    case left = "L"

    func isDiagonal(_ other: Move) -> Bool {
        switch self {
        case .up, .down:
            return other == .left || other == .right
        case .right, .left:
            return other == .up || other == .down
        }
    }
}

private struct MarkedCell: Hashable {
    var coordinates: Coordinates
    let end: End

    enum End {
        case tail
        case head
        case nada
    }
}

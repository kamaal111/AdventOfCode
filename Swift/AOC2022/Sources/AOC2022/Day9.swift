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
                tailPath(from: input, 1).count
            }
        }

        public enum Part2 {
            public static func execute(with input: String) -> Int {
                tailPath(from: input, 9).count
            }
        }

        private static func tailPath(from input: String, _ knots: Int) -> [MarkedCell] {
            var locationsVisitedByTails: [MarkedCell] = [MarkedCell(coordinates: .zero, end: .tail)]
            var headLocation = MarkedCell(coordinates: .zero, end: .head)

            for line in input.splitLines {
                let result = move(
                    head: headLocation.coordinates,
                    tail: locationsVisitedByTails.last!.coordinates,
                    tailHistory: locationsVisitedByTails,
                    command: String(line),
                    knots: knots)
                locationsVisitedByTails.append(contentsOf: result.tailPath.map({ MarkedCell(coordinates: $0, end: .tail) }))
                headLocation.coordinates = result.head
            }

//            print("locationsVisitedByTails", locationsVisitedByTails.map({ "\($0.coordinates.x),\($0.coordinates.y)" }), locationsVisitedByTails.uniques().count)
            return locationsVisitedByTails.uniques()
        }

        static func move(
            head: Coordinates,
            tail: Coordinates,
            tailHistory: [MarkedCell],
            command: String,
            knots: Int) -> MoveResult {
                let command = command.split(separator: " ")
                let direction = Direction(rawValue: String(command[0]))!
                let range = 0..<command[1].int!

                var newHead = head
                var tailPath: [Coordinates] = [tail]

                for _ in range {
                    let lastHead = newHead
                    switch direction {
                    case .right:
                        newHead.x += 1
                    case .up:
                        newHead.y += 1
                    case .down:
                        newHead.y -= 1
                    case .left:
                        newHead.x -= 1
                    }

                    if newHead.isTouching(tailPath.last!) && newHead.isTouching(tailPath.last!) {
                        printStep(head: newHead, tail: tailPath.last!)
                        continue
                    }

                    if newHead.isTouching(tailPath.last!) && newHead.isTouching(tailPath.last!) {
                        printStep(head: newHead, tail: tailPath.last!)
                        continue
                    }

                    if newHead.isTouching(tailPath.last!) {
                        tailPath.append(tailPath.last!)
                        printStep(head: newHead, tail: tailPath.last!)
                        continue
                    }

                    tailPath.append(lastHead)
                    printStep(head: newHead, tail: tailPath.last!)
                }

                return MoveResult(head: newHead, tailPath: tailPath)
            }
    }
}

struct MoveResult {
    let head: Coordinates
    let tailPath: [Coordinates]
}

private func printStep(head: Coordinates, tail: Coordinates) {
//    print("tail", tail)
//    print("head", head)
}

private enum Direction: String {
    case up = "U"
    case down = "D"
    case right = "R"
    case left = "L"
}

struct MarkedCell: Hashable {
    var coordinates: Coordinates
    let end: End

    enum End {
        case tail
        case head
        case nada
    }
}

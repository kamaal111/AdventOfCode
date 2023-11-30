//
//  Day5.swift
//
//
//  Created by Kamaal M Farah on 04/12/2022.
//

import Foundation
import ShrimpExtensions

extension AOC2022 {
    public enum Day5: DayScaffold {
        public static let resourceName = "day5"

        public enum Part1 {
            public static func execute(with input: String) -> String {
                let lines = input.splitLines
                var cratesResult = getCrates(lines)

                let moves = lines[lines.index(lines.startIndex, offsetBy: cratesResult.endIndex)..<lines.endIndex]
                movesHook(moves) { move in
                    for _ in 0..<move.amountOfCratesToMove {
                        if let crateToMove = cratesResult.crates[move.commandFrom]?.popLast() {
                            cratesResult.crates[move.commandTo]?.append(crateToMove)
                        }
                    }
                }

                return makeResult(cratesResult)
            }
        }

        public enum Part2 {
            public static func execute(with input: String) -> String {
                let lines = input.splitLines
                var cratesResult = getCrates(lines)

                let moves = lines[lines.index(lines.startIndex, offsetBy: cratesResult.endIndex)..<lines.endIndex]
                movesHook(moves) { move in
                    var cratesToMove: [Character] = []
                    for _ in 0..<move.amountOfCratesToMove {
                        if let crateToMove = cratesResult.crates[move.commandFrom]?.popLast() {
                            cratesToMove.append(crateToMove)
                        }
                    }

                    cratesResult.crates[move.commandTo]?.append(contentsOf: cratesToMove.reversed())
                }

                return makeResult(cratesResult)
            }
        }
    }
}

private func makeResult(_ cratesResult: CratesResult) -> String {
    String(cratesResult.crates
        .keys
        .sorted(by: <)
        .compactMap({ cratesResult.crates[$0]?.last }))
}

private func movesHook(_ moves: ArraySlice<String.SubSequence>, moveHandler: (Move) -> Void) {
    for move in moves {
        let splittedMoveByFrom = move.split(separator: "from")
        let amountOfCratesToMove = Int(splittedMoveByFrom[0].filter(\.isNumber))!
        let command = splittedMoveByFrom[1].split(separator: "to")
        let commandFrom = command[0].filter(\.isNumber)
        let commandTo = command[1].filter(\.isNumber)

        moveHandler(Move(amountOfCratesToMove: amountOfCratesToMove, commandFrom: commandFrom, commandTo: commandTo))
    }
}

private func getCrates(_ lines: [String.SubSequence]) -> CratesResult {
    var cratesEndIndex = 0
    var crates: [String: [Character]] = [:]
    for (lineIndex, line) in lines.enumerated() {
        // ⬇🤮🤮🤮🤮🤮🤮🤮🤮🤮⬇
        if line.contains(" 1   2   3") {
            cratesEndIndex = lineIndex + 1
            break
        }

        let lineLength = line.count
        if lineLength < 3 {
            continue
        }

        let amountOfCrates = ((lineLength - 3) / 4) + 1
        let crateIndices = (0..<amountOfCrates)
            .map({ ($0 * 4) + 1 })

        for (index, crateIndex) in crateIndices.enumerated() {
            let crate = line[line.index(line.startIndex, offsetBy: crateIndex)]
            if crate == " " {
                continue
            }

            let cratePosition = "\(index + 1)"
            if crates[cratePosition] == nil {
                crates[cratePosition] = [crate]
            } else {
                crates[cratePosition]!.prepend(crate)
            }
        }
    }

    return CratesResult(crates: crates, endIndex: cratesEndIndex)
}

private struct Move {
    let amountOfCratesToMove: Int
    let commandFrom: String
    let commandTo: String
}

private struct CratesResult {
    var crates: [String: [Character]]
    let endIndex: Int
}

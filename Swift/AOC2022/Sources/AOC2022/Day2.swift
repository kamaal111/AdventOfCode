//
//  Day2.swift
//  
//
//  Created by Kamaal M Farah on 01/12/2022.
//

import Foundation
import ShrimpExtensions

private let OPPONENT_STRATEGY: [String: ShapePlay] = [
    "A": .rock,
    "B": .paper,
    "C": .scissors,
]

extension AOC2022 {
    public struct Day2: DayScaffold {
        public static let resourceName = "day2"

        private init() { }

        public struct Part1 {
            private init() { }

            public static func excecute(with input: String) -> Int {
                let myStrategy: [String: ShapePlay] = [
                    "X": .rock,
                    "Y": .paper,
                    "Z": .scissors,
                ]

                var myTotalScore = 0
                for line in input.splitLines {
                    let inputs = line.split(separator: " ").map({ String($0) })
                    let opponentInput = OPPONENT_STRATEGY[inputs[0]]!
                    let myInput = myStrategy[inputs[1]]!

                    myTotalScore += myInput.scoreAgainstOpponent(opponentInput)
                }

                return myTotalScore
            }
        }

        public struct Part2 {
            private init() { }

            public static func excecute(with input: String) -> Int {
                let myStrategy: [String: PlayDecision] = [
                    "X": .lose,
                    "Y": .draw,
                    "Z": .win,
                ]

                var myTotalScore = 0
                for line in input.splitLines {
                    let inputs = line.split(separator: " ").map({ String($0) })
                    let opponentInput = OPPONENT_STRATEGY[inputs[0]]!
                    let myInput = myStrategy[inputs[1]]!.shapeAgainsOpponent(opponentInput)

                    myTotalScore += myInput.scoreAgainstOpponent(opponentInput)
                }

                return myTotalScore
            }
        }
    }
}

private enum PlayDecision: Int {
    case win = 6
    case lose = 0
    case draw = 3

    var score: Int {
        rawValue
    }

    func shapeAgainsOpponent(_ opponent: ShapePlay) -> ShapePlay {
        if self == .win {
            switch opponent {
            case .rock:
                return .paper
            case .paper:
                return .scissors
            case .scissors:
                return .rock
            }
        }

        if self == .lose {
            switch opponent {
            case .rock:
                return .scissors
            case .paper:
                return .rock
            case .scissors:
                return .paper
            }
        }

        return opponent
    }
}

private enum ShapePlay: Int {
    case rock = 1
    case paper = 2
    case scissors = 3

    var score: Int {
        rawValue
    }

    func scoreAgainstOpponent(_ opponent: ShapePlay) -> Int {
        let ownScore = score

        let decision: PlayDecision
        if self == opponent {
            decision = .draw
        } else if self == .rock {
            switch opponent {
            case .scissors:
                decision = .win
            case .paper:
                decision = .lose
            default:
                fatalError("should have been handled")
            }
        } else if self == .paper {
            switch opponent {
            case .rock:
                decision = .win
            case .scissors:
                decision = .lose
            default:
                fatalError("should have been handled")
            }
        } else {
            switch opponent { // scissors
            case .rock:
                decision = .lose
            case .paper:
                decision = .win
            default:
                fatalError("should have been handled")
            }
        }

        return ownScore + decision.score
    }
}

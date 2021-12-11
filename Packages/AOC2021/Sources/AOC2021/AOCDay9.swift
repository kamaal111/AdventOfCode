//
//  AOCDay9.swift
//  
//
//  Created by Kamaal Farah on 10/12/2021.
//

import Foundation

public struct AOCDay9 {
    public static let part1 = Part1()
    public static let part2 = Part2()

    public static let input: String? = {
        guard let inputURL = Bundle.module.url(forResource: "day9", withExtension: "txt") else { return nil }
        return try? String(contentsOf: inputURL, encoding: .utf8)
    }()

    private init() { }

    public struct Part1 {
        fileprivate init() { }

        public func execute(with input: String) -> Int {
            let lines = input.splitLines
            let amountOfNumbersInEachLine = lines.first!.count
            let joinedLines = lines.joined()
            var lowCharacters = 0
            for (index, character) in joinedLines.enumerated() {
                let intCharacter = character.int!

                var lowerThanBottom = true
                if (index + amountOfNumbersInEachLine) < joinedLines.count {
                    let bottom = joinedLines[index + amountOfNumbersInEachLine].int!
                    lowerThanBottom = bottom > intCharacter
                }

                var lowerThanTop = true
                if index >= amountOfNumbersInEachLine {
                    let top = joinedLines[index - amountOfNumbersInEachLine].int!
                    lowerThanTop =  top > intCharacter
                }

                var lowerThanRight = true
                if (index % amountOfNumbersInEachLine) != (amountOfNumbersInEachLine - 1) {
                    let right = joinedLines[index + 1].int!
                    lowerThanRight = right > intCharacter
                }

                var lowerThanLeft = true
                if (index % amountOfNumbersInEachLine) != 0 {
                    let left = joinedLines[index - 1].int!
                    lowerThanLeft = left > intCharacter
                }

                if lowerThanTop && lowerThanRight && lowerThanLeft && lowerThanBottom {
                    lowCharacters += (intCharacter + 1)
                }
            }
            return lowCharacters
        }
    }

    public struct Part2 {
        fileprivate init() { }

        public func execute(with input: String) -> Int {
            let lines = input.splitLines
            let amountOfNumbersInEachLine = lines.first!.count
            let joinedLines = lines.joined()
            var basins: [EdgeInsets] = []

            for (index, character) in joinedLines.enumerated() {
                let intCharacter = character.int!

                var shifts = EdgeInsets(all: 0)
                var lastHighestNumbers = EdgeInsets(all: intCharacter)
                var lowerEdges = EdgeBools(all: true)

                var bottomChanged = true
                let bottomAccessIndex = (index + shifts.bottom) + amountOfNumbersInEachLine
                if bottomAccessIndex < joinedLines.count {
                    let bottom = joinedLines[bottomAccessIndex].int!
                    if bottom > lastHighestNumbers.bottom {
                        lastHighestNumbers.bottom = bottom
                        shifts.bottom += 1
                    } else {
                        bottomChanged = false
                    }
                }
                lowerEdges.bottom = bottomChanged

                var topChanged = true
                if (index + shifts.top) >= amountOfNumbersInEachLine {
                    let topIndex = (index + shifts.top) - amountOfNumbersInEachLine
                    let top = joinedLines[topIndex].int!
                    if top > lastHighestNumbers.top {
                        lastHighestNumbers.top = top
                        shifts.top += 1
                    } else {
                        topChanged = false
                    }
                }
                lowerEdges.top = topChanged

                var rightChanged = true
                if ((index + shifts.right) % amountOfNumbersInEachLine) != (amountOfNumbersInEachLine - 1) {
                    let rightIndex = index + (1 + shifts.right)
                    let right = joinedLines[rightIndex].int!
                    if right > lastHighestNumbers.right {
                        lastHighestNumbers.right = right
                        shifts.right += 1
                    } else {
                        rightChanged = false
                    }
                }
                lowerEdges.right = rightChanged

                var leftChanged = true
                if ((index - shifts.left) % amountOfNumbersInEachLine) != 0 {
                    let leftIndex = index - (1 + shifts.left)
                    let left = joinedLines[leftIndex].int!
                    if left > lastHighestNumbers.left {
                        lastHighestNumbers.left = left
                        shifts.left += 1
                    } else {
                        leftChanged = false
                    }
                }
                lowerEdges.left = leftChanged

                if lowerEdges.someAreFalse {
                    continue
                }

                shiftingLoop: while true {
                    if lowerEdges.bottom {
                        var bottomChanged = false
                        let bottomAccessIndex = (index + shifts.bottom) + amountOfNumbersInEachLine
                        if bottomAccessIndex < joinedLines.count {
                            let bottom = joinedLines[bottomAccessIndex].int!
                            if bottom > lastHighestNumbers.bottom {
                                lastHighestNumbers.bottom = bottom
                                shifts.bottom += 1
                                bottomChanged = true
                            }
                        }
                        lowerEdges.bottom = bottomChanged
                    }

                    if lowerEdges.top {
                        var topChanged = false
                        if (index + shifts.top) >= amountOfNumbersInEachLine {
                            let topIndex = (index + shifts.top) - amountOfNumbersInEachLine
                            let top = joinedLines[topIndex].int!
                            if top > lastHighestNumbers.top {
                                lastHighestNumbers.top = top
                                shifts.top += 1
                                topChanged = true
                            }
                        }
                        lowerEdges.top = topChanged
                    }

                    if lowerEdges.right {
                        var rightChanged = false
                        if ((index + shifts.right) % amountOfNumbersInEachLine) != (amountOfNumbersInEachLine - 1) {
                            let rightIndex = index + (1 + shifts.right)
                            let right = joinedLines[rightIndex].int!
                            if right > lastHighestNumbers.right {
                                lastHighestNumbers.right = right
                                shifts.right += 1
                                rightChanged = true
                            }
                        }
                        lowerEdges.right = rightChanged
                    }

                    if lowerEdges.left {
                        var leftChanged = false
                        if ((index - shifts.left) % amountOfNumbersInEachLine) != 0 {
                            let leftIndex = index - (1 + shifts.left)
                            let left = joinedLines[leftIndex].int!
                            if left > lastHighestNumbers.left {
                                lastHighestNumbers.left = left
                                shifts.left += 1
                                leftChanged = true
                            }
                        }
                        lowerEdges.left = leftChanged
                    }

                    if lowerEdges.allFalse {
                        if shifts.sum > 0 {
                            basins.append(shifts)
                        }
                        break shiftingLoop
                    }
                }
            }

            let sortedBasinSums = basins
                .map(\.sum)
                .sorted(by: { $0 > $1 })
            print(sortedBasinSums)
            return sortedBasinSums
                .prefix(3)
                .reduce(1, { $0 * $1 })
        }
    }
}

struct EdgeInsets {
    var top: Int
    var right: Int
    var bottom: Int
    var left: Int

    init(top: Int, right: Int, bottom: Int, left: Int) {
        self.top = top
        self.right = right
        self.bottom = bottom
        self.left = left
    }

    init(all: Int) {
        self.init(top: all, right: all, bottom: all, left: all)
    }

    var sum: Int {
        top + right + bottom + left
    }
}

struct EdgeBools {
    var top: Bool
    var right: Bool
    var bottom: Bool
    var left: Bool

    init(top: Bool, right: Bool, bottom: Bool, left: Bool) {
        self.top = top
        self.right = right
        self.bottom = bottom
        self.left = left
    }

    init(all: Bool) {
        self.init(top: all, right: all, bottom: all, left: all)
    }

    var allFalse: Bool {
        !top && !right && !bottom && !left
    }

    var someAreFalse: Bool {
        !top || !right || !bottom || !left
    }
}

extension Character {
    var string: String {
        String(self)
    }

    var int: Int? {
        string.int
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }

    var int: Int? {
        Int(self)
    }
}

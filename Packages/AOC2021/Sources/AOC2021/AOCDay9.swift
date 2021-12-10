//
//  AOCDay9.swift
//  
//
//  Created by Kamaal Farah on 10/12/2021.
//

import Foundation

struct AOCDay9 {
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

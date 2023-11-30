//
//  AOCDay1.swift
//  
//
//  Created by Kamaal M Farah on 05/12/2021.
//

import Foundation

public struct AOCDay1 {
    public static let part1 = Part1()
    public static let part2 = Part2()

    public static let input: String? = {
        guard let inputURL = Bundle.module.url(forResource: "day1", withExtension: "txt") else { return nil }
        return try? String(contentsOf: inputURL, encoding: .utf8)
    }()

    private init() { }

    public struct Part1 {
        fileprivate init() { }

        public func execute(with input: String) -> Int {
            var increases = 0
            let lines = input.splitLines
            for (lineNumber, line) in lines.enumerated() {
                guard let intLine = Int(line) else { return 0 }

                let nextLineNumber = lineNumber + 1
                if nextLineNumber < lines.count {
                    guard let nextLine = Int(lines[nextLineNumber]) else { return 0 }

                    if intLine < nextLine {
                        increases += 1
                    }
                }
            }
            return increases
        }
    }

    public struct Part2 {
        fileprivate init() { }

        public func execute(with input: String) -> Int {
            var increases = 0
            let lines = input.splitLines
            for (lineNumber, line) in lines.enumerated() {
                guard let intLine = Int(line) else { return 0 }

                let amountOfNextNumbers = 3
                if lineNumber + amountOfNextNumbers < lines.count {
                    var firstSum = intLine
                    var secondSum = 0

                    for index in 0..<amountOfNextNumbers {
                        guard let nextLine = Int(lines[index + lineNumber + 1]) else { return 0 }

                        if index < (amountOfNextNumbers - 1) {
                            firstSum += nextLine
                        }
                    
                        secondSum += nextLine
                    }

                    if secondSum > firstSum {
                        increases += 1
                    }

                }
            }
            return increases
        }
    }
}

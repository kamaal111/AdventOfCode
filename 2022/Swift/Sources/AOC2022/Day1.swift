//
//  Day1.swift
//  
//
//  Created by Kamaal M Farah on 26/11/2022.
//

import Foundation
import ShrimpExtensions

extension AOC2022 {
    public enum Day1: DayScaffold {
        public static let resourceName = "day1"

        public enum Part1 {
            public static func excecute(with input: String) -> Int {
                var highestCalories = 0
                var currentStreak = 0
                inputHook(with: input, newElf: {
                    if currentStreak > highestCalories {
                        highestCalories = currentStreak
                    }
                    currentStreak = 0
                }, calories: { currentStreak += $0 })

                if currentStreak != 0 && currentStreak > highestCalories {
                    highestCalories = currentStreak
                }

                return highestCalories
            }
        }

        public enum Part2 {
            public static func excecute(with input: String) -> Int {
                var highestCalories = [0, 0, 0]
                var currentStreak = 0
                inputHook(with: input, newElf: {
                    if currentStreak > highestCalories[2] {
                        highestCalories = newHighestCalories(
                            previousHighestCalories: highestCalories,
                            currentStreak: currentStreak)
                    }
                    currentStreak = 0
                }, calories: { currentStreak += $0 })

                if currentStreak != 0 && currentStreak > highestCalories[2] {
                    highestCalories = newHighestCalories(
                        previousHighestCalories: highestCalories,
                        currentStreak: currentStreak)
                }

                return highestCalories.reduce(0, { $0 + $1 })
            }

            private static func newHighestCalories(previousHighestCalories: [Int], currentStreak: Int) -> [Int] {
                var orderedHighestCalories = previousHighestCalories
                    .appended(currentStreak)
                    .sorted(by: { $0 > $1 })
                _ = orderedHighestCalories.popLast()

                return orderedHighestCalories
            }
        }
    }
}

private func inputHook(with input: String, newElf: () -> Void, calories: (Int) -> Void) {
    for line in input.split(omittingEmptySubsequences: false, whereSeparator: \.isNewline) {
        if line == "" {
            newElf()
        } else {
            if let number = Int(line) {
                calories(number)
            }
        }
    }
}

//
//  Day4.swift
//
//
//  Created by Kamaal M Farah on 03/12/2022.
//

import Foundation
import ShrimpExtensions

extension AOC2022 {
    public enum Day4: DayScaffold {
        public static let resourceName = "day4"

        public enum Part1 {
            public static func execute(with input: String) -> Int {
                amountOfOverlappingSchedules(input, where: { firstSchedule, secondSchedule in
                    firstSchedule.contains(secondSchedule.lowerBound) &&
                    firstSchedule.contains(secondSchedule.upperBound) ||
                    secondSchedule.contains(firstSchedule.lowerBound) &&
                    secondSchedule.contains(firstSchedule.upperBound)
                })
            }
        }

        public enum Part2 {
            public static func execute(with input: String) -> Int {
                amountOfOverlappingSchedules(input, where: { firstSchedule, secondSchedule in
                    firstSchedule.contains(secondSchedule.lowerBound) ||
                    firstSchedule.contains(secondSchedule.upperBound) ||
                    secondSchedule.contains(firstSchedule.lowerBound) ||
                    secondSchedule.contains(firstSchedule.upperBound)
                })
            }
        }
    }
}

private func amountOfOverlappingSchedules(
    _ input: String,
    where predicate: (ClosedRange<Int>, ClosedRange<Int>) -> Bool) -> Int {
        var overlappingSchedules = 0
        for schedulePairs in input.splitLines {
            let (firstSchedule, secondSchedule) = parseSchedulePairs(schedulePairs)
            if predicate(firstSchedule, secondSchedule) {
                overlappingSchedules += 1
            }
        }

        return overlappingSchedules
}

private func parseSchedulePairs(_ rawSchedulePairs: String.SubSequence) -> (ClosedRange<Int>, ClosedRange<Int>) {
    let schedules = rawSchedulePairs.split(separator: ",")

    return (parseSchedule(schedules[0]), parseSchedule(schedules[1]))
}

private func parseSchedule(_ rawSchedule: String.SubSequence) -> ClosedRange<Int> {
    let schedule = rawSchedule.split(separator: "-").map({ Int($0)! })

    return schedule[0]...schedule[1]
}

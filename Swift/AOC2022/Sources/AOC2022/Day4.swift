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
                var foundFullyOverlappingSchedules = 0
                for schedulePairs in input.splitLines {
                    let (firstSchedule, secondSchedule) = parseSchedulePairs(schedulePairs)
                    if firstSchedule.contains(secondSchedule.lowerBound) &&
                        firstSchedule.contains(secondSchedule.upperBound) {
                        foundFullyOverlappingSchedules += 1
                    } else if secondSchedule.contains(firstSchedule.lowerBound) &&
                                secondSchedule.contains(firstSchedule.upperBound) {
                        foundFullyOverlappingSchedules += 1
                    }
                }

                return foundFullyOverlappingSchedules
            }
        }

        public enum Part2 {
            public static func execute(with input: String) -> Int {
                var foundFullyOverlappingSchedules = 0
                for schedulePairs in input.splitLines {
                    let (firstSchedule, secondSchedule) = parseSchedulePairs(schedulePairs)
                    if firstSchedule.contains(secondSchedule.lowerBound) ||
                        firstSchedule.contains(secondSchedule.upperBound) {
                        foundFullyOverlappingSchedules += 1
                    } else if secondSchedule.contains(firstSchedule.lowerBound) ||
                                secondSchedule.contains(firstSchedule.upperBound) {
                        foundFullyOverlappingSchedules += 1
                    }
                }

                return foundFullyOverlappingSchedules
            }
        }
    }
}

private func parseSchedulePairs(_ rawSchedulePairs: String.SubSequence) -> (ClosedRange<Int>, ClosedRange<Int>) {
    let schedules = rawSchedulePairs.split(separator: ",")
    let firstSchedule = schedules[0].split(separator: "-").map({ Int($0)! })
    let secondSchedule = schedules[1].split(separator: "-").map({ Int($0)! })

    return (firstSchedule[0]...firstSchedule[1], secondSchedule[0]...secondSchedule[1])
}

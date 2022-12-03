//
//  Day3.swift
//  
//
//  Created by Kamaal M Farah on 03/12/2022.
//

import Foundation
import ShrimpExtensions

extension AOC2022 {
    public enum Day3: DayScaffold {
        public static let resourceName = "day3"

        public enum Part1 {
            public static func execute(with input: String) -> Int {
                var priorities = 0
                for line in input.splitLines {
                    let halfRucksackIndex = line.index(line.startIndex, offsetBy: line.count / 2)
                    let leftRucksackCompartment = line[line.startIndex..<halfRucksackIndex]
                    let rightRucksackCompartment = line[halfRucksackIndex..<line.endIndex]

                    let leftRucksackCompartmentGroupedByPriority = Dictionary(
                        grouping: leftRucksackCompartment,
                        by: characterToPriority)
                    let rightRucksackCompartmentGroupedByPriority = Dictionary(
                        grouping: rightRucksackCompartment,
                        by: characterToPriority)
                    for (leftPriority, _) in leftRucksackCompartmentGroupedByPriority {
                        if rightRucksackCompartmentGroupedByPriority[leftPriority] != nil {
                            priorities += leftPriority
                            break
                        }
                    }
                }

                return priorities
            }
        }

        public enum Part2 {
            public static func execute(with input: String) -> Int {
                var priorities = 0

                var group: [String.SubSequence] = []
                for (index, line) in input.splitLines.enumerated() {
                    if ((index + 1) % 3) == 0 {
                        let rucksack1GroupedByPriority = Dictionary(grouping: line, by: characterToPriority)
                        let rucksack2GroupedByPriority = Dictionary(grouping: group[0], by: characterToPriority)
                        let rucksack3GroupedByPriority = Dictionary(grouping: group[1], by: characterToPriority)

                        for (rucksack1Priority, _) in rucksack1GroupedByPriority {
                            if rucksack2GroupedByPriority[rucksack1Priority] != nil &&
                                rucksack3GroupedByPriority[rucksack1Priority] != nil {
                                priorities += rucksack1Priority
                                break
                            }
                        }

                        group = []
                    } else {
                        group = group.appended(line)
                    }
                }

                return priorities
            }
        }
    }
}

private func characterToPriority(_ character: Character) -> Int {
    let asciiValue = Int(character.asciiValue!)
    if character.isLowercase {
        return asciiValue - 96
    }
    return asciiValue - 38
}

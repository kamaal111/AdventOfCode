//
//  Day8.swift
//
//
//  Created by Kamaal M Farah on 08/12/2023.
//

import AOCTools
import Foundation
import KamaalExtensions

enum Day8: DayScaffold {
    static var resourceName = "day8"

    static func part1(input: String) -> Int {
        let (instructions, coordinates) = parseInput(input)
        let startingCoordinates = ["AAA"]
        return traverseCoordinates(
            instructions: instructions,
            coordinates: coordinates,
            startingCoordinates: startingCoordinates,
            endCondition: { $0 == "ZZZ" }
        )
    }

    static func part2(input: String) -> Int {
        let (instructions, coordinates) = parseInput(input)
        let startingCoordinates = coordinates
            .keys
            .filter({ $0.last == "A" })
        return traverseCoordinates(
            instructions: instructions,
            coordinates: coordinates,
            startingCoordinates: startingCoordinates,
            endCondition: { $0.last == "Z" }
        )
    }
}

private struct CountedValue {
    let value: String
    let count: Int
}

private enum Instructions {
    case left
    case right
}

private func traverseCoordinates(
    instructions: [Instructions],
    coordinates: [String: [Instructions : String]],
    startingCoordinates: [String],
    endCondition: (String) -> Bool
) -> Int {
    var steps = 0
    let instructionsSize = instructions.count
    var currentCoordinates = startingCoordinates
        .reduce([String: CountedValue](), { $0.merged(with: [$1: CountedValue(value: $1, count: 0)]) })
    while !currentCoordinates.allSatisfy({ endCondition($0.value.value) }) {
        let instruction = instructions[steps % instructionsSize]
        steps += 1
        currentCoordinates
            .filter({ !endCondition($0.value.value) })
            .forEach({
                currentCoordinates[$0.key] = CountedValue(
                    value: coordinates[$0.value.value]![instruction]!,
                    count: steps
                )
            })
    }
    let coordinateSteps = currentCoordinates
        .values
        .map(\.count)
        .uniques()
    return Maths.leastCommonMultiple(coordinateSteps)
}

private func parseInput(_ input: String) -> (instructions: [Instructions], coordinates: [String : [Instructions : String]]) {
    let lines = input.splitLines
    let instructions: [Instructions] = lines[0]
        .map({ if $0 == "L" { .left } else { .right } })
    let coordinates = lines.ranged(from: 1)
        .reduce([String: [Instructions: String]]()) { partialResult, value in
            let splittenValue = value.split(separator: " = ")
            let key = String(splittenValue[0])
            let nextCoordinates = splittenValue[1]
                .split(separator: ", ")
            assert(nextCoordinates.count == 2)
            return partialResult
                .merged(with: [key: [.left: String(nextCoordinates[0].suffix(3)), .right: String(nextCoordinates[1].prefix(3))]])
        }
    return (instructions, coordinates)
}

//
//  Day6.swift
//
//
//  Created by Kamaal M Farah on 08/12/2023.
//

import AOCTools
import Foundation
import KamaalExtensions

enum Day6: DayScaffold {
    static var resourceName = "day6"

    static func part1(input: String) -> Int {
        let (times, distances) = parseInput(input)
        return zip(times, distances)
            .map({ calculateWaysToWin(time: Double($0), distance: Double($1)) })
            .reduce(1, { $0 * $1 })
            .int
    }

    static func part2(input: String) -> Int {
        let (times, distances) = parseInput(input)
        let time = Double(times.map({ String($0) }).joined())!
        let distance = Double(distances.map({ String($0) }).joined())!
        return calculateWaysToWin(time: time, distance: distance).int
    }
}

private func calculateWaysToWin(time: Double, distance: Double) -> Double {
    let (shortest, longest) = Maths.quadraticEquation(time, distance, 1)
    return longest - shortest + 1
}

private func parseInput(_ input: String) -> (times: [Int], distances: [Int]) {
    let items = input
        .splitLines
        .map({
            $0
                .split(separator: ":")
                .last!
                .split(separator: " ")
                .map({ $0.int! })
        })
    assert(items.count == 2)
    return (items[0], items[1])
}

//
//  AOCDay6.swift
//  
//
//  Created by Kamaal M Farah on 05/12/2021.
//

import Foundation

struct AOCDay6 {
    public static let part1 = Part1()
    public static let part2 = Part2()

    public static let input: String? = {
        guard let inputURL = Bundle.module.url(forResource: "day6", withExtension: "txt") else { return nil }
        return try? String(contentsOf: inputURL, encoding: .utf8)
    }()

    private init() { }

    public struct Part1 {
        fileprivate init() { }

        public func execute(with input: String) -> Int {
            let fishDays = input
                .split(separator: ",")
                .compactMap({ Int(String($0).trimmingByWhitespacesAndNewLines) })

            return simulateFishLife(with: fishDays, to: 80)
        }
    }

    public struct Part2 {
        fileprivate init() { }

        public func execute(with input: String) -> Int {
            let fishDays = input
                .split(separator: ",")
                .compactMap({ Int(String($0).trimmingByWhitespacesAndNewLines) })

            return simulateFishLife(with: fishDays, to: 256)
        }
    }
}

func simulateFishLife(with initialFishes: [Int], to days: Int) -> Int {
    var fishDaysDict: [Int: Int] = initialFishes.reduce([:], {
        var initialDict = $0
        if initialDict[$1] != nil {
            initialDict[$1]! += 1
        } else {
            initialDict[$1] = 1
        }
        return initialDict
    })
    for _ in 1..<(days + 1) {
        var tempDict: [Int: Int] = [:]
        var resetedFishes = 0
        for (key, value) in fishDaysDict {
            if key == 0 && value > 0 {
                tempDict[8] = value
                resetedFishes = value
            } else {
                tempDict[key - 1] = value
            }
        }
        if tempDict[6] != nil {
            tempDict[6]! += resetedFishes
        } else {
            tempDict[6] = resetedFishes
        }
        fishDaysDict = tempDict
    }
    return fishDaysDict.reduce(0, { $0 + $1.value })
}

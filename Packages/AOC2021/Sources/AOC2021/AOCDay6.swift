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
                .compactMap({ FishLifeForce(days: String($0), isOG: true) })

            return simulateFishLife(with: fishDays, to: 80)
        }
    }

    public struct Part2 {
        fileprivate init() { }

        public func execute(with input: String) -> Int {
            let fishDays = input
                .split(separator: ",")
                .compactMap({ FishLifeForce(days: String($0), isOG: true) })

            return simulateFishLife(with: fishDays, to: 256)
        }
    }
}

func simulateFishLife(with initialFishes: [FishLifeForce], to days: Int) -> Int {
    let initialDict: [Int: Int] = (0..<9).reduce([:], {
        var result = $0
        result[$1] = 0
        return result
    })
    var fishDaysDict: [Int: Int] = initialFishes.reduce(initialDict, {
        var initialDict = $0
        initialDict[$1.days]! += 1
        return initialDict
    })
    for _ in 1..<(days + 1) {
        var tempDict: [Int: Int] = [:]
        var resetedFishes = 0
        for (key, value) in fishDaysDict.sorted(by: { $0.key > $1.key }) {
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

struct FishLifeForce {
    var days: Int
    var isOG: Bool
    var offspringsMade: Int = 0

    init?(days: String, isOG: Bool) {
        guard let daysInt = Int(days.trimmingByWhitespacesAndNewLines) else { fatalError("unknown day of \(days)") }
        self.init(days: daysInt, isOG: isOG)
    }

    init(days: Int, isOG: Bool) {
        self.days = days
        self.isOG = isOG
    }

    mutating func live() {
        days -= 1
    }

    mutating func makeOffspring() -> FishLifeForce? {
        offspringsMade += 1
        return .init(days: 8, isOG: false)
    }

    mutating func reset() -> FishLifeForce {
        days = 6
        return makeOffspring()!
    }
}

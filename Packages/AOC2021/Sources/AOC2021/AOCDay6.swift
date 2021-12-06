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

            return simulateFishLife(with: fishDays, to: 80)
        }
    }
}

func simulateFishLife(with initialFishes: [FishLifeForce], to days: Int) -> Int {
    var fishDays = initialFishes
    for _ in 1..<(days + 1) {
        for (fishDayIndex, fishDay) in fishDays.enumerated() {
            if fishDay.days == 0 {
                let offspring = fishDays[fishDayIndex].reset()
                fishDays.append(offspring)
            } else {
                fishDays[fishDayIndex].live()
            }
        }
    }
    let growth = initialFishes.map({ $0.predictedAmountOfOffsprings(totalDays: days) })
    print(growth) // 5934
    return fishDays.count
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

    func predictedAmountOfOffsprings(totalDays: Int) -> Double {
        return pow(Double(days), 7) / Double(totalDays)
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

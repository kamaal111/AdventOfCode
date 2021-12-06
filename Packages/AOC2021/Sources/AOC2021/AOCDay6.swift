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

        public func execute(with input: String, days: Int = 80) -> Int {
            var fishDays = input
                .split(separator: ",")
                .compactMap({ FishLifeForce(days: String($0), isOG: true) })

//            print(0, fishDays.count)

            for day in 0..<days {
                for (fishDayIndex, fishDay) in fishDays.enumerated() {
                    if fishDay.days == 0 {
                        let offspring = fishDays[fishDayIndex].reset()
                        fishDays.append(offspring)
                    } else {
                        fishDays[fishDayIndex].live()
                    }
                }

                if (day + 1) <= days {
//                    print((day + 1), fishDays.count)
                }
            }

            return fishDays.count
        }
    }

    public struct Part2 {
        fileprivate init() { }

        public func execute(with input: String) -> Int {
            return 0
        }
    }
}

struct FishLifeForce {
    var days: Int
    var isOG: Bool
    var createdOffSpring: Bool = false

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
        createdOffSpring = true
        return .init(days: 8, isOG: false)
    }

    mutating func reset() -> FishLifeForce {
        days = 6
        return makeOffspring()!
    }
}

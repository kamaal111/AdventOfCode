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
            var fishDays = input.split(separator: ",").compactMap({ FishLifeForce(days: String($0), isOG: true) })
            for day in 0..<80 {
                for (fishDayIndex, fishDay) in fishDays.enumerated() {
                    if fishDay.days == 0 {
                        if let offspring = fishDays[fishDayIndex].makeOffspring() {
                            fishDays.append(offspring)
                        }
                        fishDays[fishDayIndex].reset()
                    } else {
                        fishDays[fishDayIndex].days -= 1
                    }
                }
                if (day + 1) == 9 {
                    print(fishDays.map(\.days))
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
        guard let daysInt = Int(days) else { return nil }
        self.init(days: daysInt, isOG: isOG)
    }

    init(days: Int, isOG: Bool) {
        self.days = days
        self.isOG = isOG
    }

    mutating func makeOffspring() -> FishLifeForce? {
        createdOffSpring = true
        return .init(days: 8, isOG: false)
    }

    mutating func reset() {
        createdOffSpring = false
        days = 6
    }
}

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
            var fishDays = input.split(separator: ",").compactMap({ Int($0) })
            for _ in 0..<80 {
                for (fishDayIndex, fishDay) in fishDays.enumerated() {
                    if fishDay < 1 {
                        fishDays[fishDayIndex] = 6
                        fishDays.append(8)
                    } else {
                        fishDays[fishDayIndex] -= 1
                    }
                }
            }
            return fishDays.count // 360219
        }
    }

    public struct Part2 {
        fileprivate init() { }

        public func execute(with input: String) -> Int {
            return 0
        }
    }
}

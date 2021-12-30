//
//  AOCDay7.swift
//  
//
//  Created by Kamaal M Farah on 06/12/2021.
//

import Foundation

public struct AOCDay7 {
    public static let part1 = Part1()
    public static let part2 = Part2()

    public static let input: String? = {
        guard let inputURL = Bundle.module.url(forResource: "day7", withExtension: "txt") else { return nil }
        return try? String(contentsOf: inputURL, encoding: .utf8)
    }()

    private init() { }

    public struct Part1 {
        fileprivate init() { }

        public func execute(with input: String) -> Int {
            let horizontalPositions = input
                .splitCommas
                .compactMap({ Int(String($0).trimmingByWhitespacesAndNewLines) })

            var leastFuel = Int.max
            for (offset, _) in horizontalPositions.enumerated() {
                let index = offset + 1
                var sum = 0
                for position in horizontalPositions {
                    let minimum: Int
                    let maximum: Int
                    if position > index {
                        minimum = index
                        maximum = position
                    } else {
                        minimum = position
                        maximum = index
                    }
                    sum += (maximum - minimum)
                }
                if sum < leastFuel {
                    leastFuel = sum
                }
            }

            return leastFuel
        }
    }

    public struct Part2 {
        fileprivate init() { }

        public func execute(with input: String) -> Int {
            let horizontalPositions = input
                .splitCommas
                .compactMap({ Int(String($0).trimmingByWhitespacesAndNewLines) })

            var leastFuel = Int.max
            for (offset, _) in horizontalPositions.enumerated() {
                let index = offset + 1
                var sum = 0
                for position in horizontalPositions {
                    if position == index {
                       continue
                   }

                    let difference = abs(index - position)
                    sum += (difference * (difference + 1)) / 2
                }
                if sum < leastFuel {
                    leastFuel = sum
                }
            }

            return leastFuel
        }
    }
}

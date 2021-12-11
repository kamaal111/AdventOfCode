//
//  AOCDay11.swift
//  
//
//  Created by Kamaal Farah on 11/12/2021.
//

import Foundation

public struct AOCDay11 {
    public static let part1 = Part1()
    public static let part2 = Part2()

    public static let input: String? = {
        guard let inputURL = Bundle.module.url(forResource: "day11", withExtension: "txt") else { return nil }
        return try? String(contentsOf: inputURL, encoding: .utf8)
    }()

    private init() { }

    public struct Part1 {
        fileprivate init() { }

        public func execute(with input: String) -> Int {
            var takos = input.splitLines.joined(separator: "").map(\.int!)
            let steps = 0..<100
            for _ in steps {
                for (index, tako) in takos.enumerated() {
                    if tako == 9 {
                        print("flash")
                    }
                    takos[index] += 1
                }
            }
            print(takos)
            return 0
        }
    }

    public struct Part2 {
        fileprivate init() { }

        public func execute(with input: String) -> Int {
            return 0
        }
    }
}

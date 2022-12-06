//
//  Day6.swift
//
//
//  Created by Kamaal M Farah on 05/12/2022.
//

import Foundation
import ShrimpExtensions

extension AOC2022 {
    public enum Day6: DayScaffold {
        public static let resourceName = "day6"

        public enum Part1 {
            public static func execute(with input: String) -> Int {
                getMessageMarker(from: input, startMarker: 4)
            }
        }

        public enum Part2 {
            public static func execute(with input: String) -> Int {
                getMessageMarker(from: input, startMarker: 14)
            }
        }
    }
}

private func getMessageMarker(from input: String, startMarker: Int) -> Int {
    var carry = input.range(from: 0, to: startMarker)
    if Set(carry).count == startMarker {
        return startMarker
    }

    for (index, character) in input.range(from: startMarker).enumerated() {
        _ = carry.removeFirst()
        carry.append(character)

        if Set(carry).count == startMarker {
            return index + startMarker + 1
        }
    }

    return .max
}

extension String {
    func range(from start: Int, to end: Int? = nil) -> Substring {
        self[self.index(self.startIndex, offsetBy: start)..<self.index(self.startIndex, offsetBy: end ?? count)]
    }
}

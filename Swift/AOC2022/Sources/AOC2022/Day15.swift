//
//  Day15.swift
//  
//
//  Created by Kamaal M Farah on 15/12/2022.
//

import Foundation
import ShrimpExtensions

extension AOC2022 {
    public enum Day15: DayScaffold {
        public static let resourceName = "day15"

        public enum Part1 {
            public static func execute(with input: String) -> Int {
                parseInput(input)
                return 0
            }
        }

        public enum Part2 {
            public static func execute(with input: String) -> Int {
                0
            }
        }

        private static func parseInput(_ input: String) {
            var highestSize = Size(width: 0, height: 0)
            var lowestSize = Size(width: 0, height: 0)

            for line in input.splitLines {
                let coordinates = parseLine(line)
                if coordinates.sensor.x > highestSize.width {
                    highestSize.width = coordinates.sensor.x
                }
                if coordinates.sensor.y > highestSize.height {
                    highestSize.height = coordinates.sensor.y
                }
                if coordinates.beacon.x > highestSize.width {
                    highestSize.width = coordinates.beacon.x
                }
                if coordinates.beacon.y > highestSize.height {
                    highestSize.height = coordinates.beacon.y
                }

                if coordinates.sensor.x < lowestSize.width {
                    lowestSize.width = coordinates.sensor.x
                }
                if coordinates.sensor.y < lowestSize.height {
                    lowestSize.height = coordinates.sensor.y
                }
                if coordinates.beacon.x < lowestSize.width {
                    lowestSize.width = coordinates.beacon.x
                }
                if coordinates.beacon.y < lowestSize.height {
                    lowestSize.height = coordinates.beacon.y
                }
            }
            print(lowestSize, highestSize)
        }

        private static func parseLine(_ line: String.SubSequence) -> (sensor: Coordinates, beacon: Coordinates) {
            let coordinates = line
                .split(separator: ":")
                .map({
                    let coordinate = $0
                        .split(separator: ",")
                        .map({
                            $0
                                .split(separator: " ")
                                .last!
                                .split(separator: "=")
                                .last!
                                .int!
                        })
                    return Coordinates(x: coordinate[0], y: coordinate[1])
                })

            return (coordinates[0], coordinates[1])
        }
    }
}

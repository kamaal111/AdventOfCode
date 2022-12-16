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
            var highestSize = Size.zero
            var lowestSize = Size.zero
            var sensorsAndBeacons: [(sensor: Coordinates, beacon: Coordinates)] = []

            for line in input.splitLines {
                let sensorsAndBeacon = parseLine(line)
                sensorsAndBeacons = sensorsAndBeacons.appended(sensorsAndBeacon)
                highestSize = newHighestGridSize(
                    previousSize: highestSize,
                    sensor: sensorsAndBeacon.sensor,
                    beacon: sensorsAndBeacon.beacon)
                lowestSize = newLowestGridSize(
                    previousSize: lowestSize,
                    sensor: sensorsAndBeacon.sensor,
                    beacon: sensorsAndBeacon.beacon)
            }

            let fullWidth = highestSize.width - lowestSize.width + 1
            let fullHeight = highestSize.height - lowestSize.height + 1
            let fullSize = Size(width: fullWidth, height: fullHeight)
            var grid = Grid(size: fullSize, defaultValue: Mark.empty)

            for sensorAndBeacon in sensorsAndBeacons {
                let correctionX = fullSize.width - highestSize.width - 1
                let correctionY = fullSize.height - highestSize.height - 1
                let sensorCoordinates = sensorAndBeacon.sensor
                let corectedSensorCoordinates = Coordinates(
                    x: correctionX + sensorCoordinates.x,
                    y: correctionY + sensorCoordinates.y)
                let beaconCoordinates = sensorAndBeacon.beacon
                let correctedBeaconCoordinates = Coordinates(
                    x: correctionX + beaconCoordinates.x,
                    y: correctionY + beaconCoordinates.y)
                grid.setCell(at: corectedSensorCoordinates, with: .sensor(closestBeacon: correctedBeaconCoordinates))
                grid.setCell(at: correctedBeaconCoordinates, with: .beacon)
            }

            print(grid.draw(mapping: \.stringValue))
        }

        private static func newHighestGridSize(previousSize: Size, sensor: Coordinates, beacon: Coordinates) -> Size {
            var previousSize = previousSize
            if sensor.x > previousSize.width {
                previousSize.width = sensor.x
            }
            if sensor.y > previousSize.height {
                previousSize.height = sensor.y
            }
            if beacon.x > previousSize.width {
                previousSize.width = beacon.x
            }
            if beacon.y > previousSize.height {
                previousSize.height = beacon.y
            }
            return previousSize
        }

        private static func newLowestGridSize(previousSize: Size, sensor: Coordinates, beacon: Coordinates) -> Size {
            var previousSize = previousSize
            if sensor.x < previousSize.width {
                previousSize.width = sensor.x
            }
            if sensor.y < previousSize.height {
                previousSize.height = sensor.y
            }
            if beacon.x < previousSize.width {
                previousSize.width = beacon.x
            }
            if beacon.y < previousSize.height {
                previousSize.height = beacon.y
            }
            return previousSize
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

            return (sensor: coordinates[0], beacon: coordinates[1])
        }
    }
}

private enum Mark {
    case sensor(closestBeacon: Coordinates)
    case beacon
    case empty

    var stringValue: String {
        switch self {
        case .sensor:
            return "S"
        case .beacon:
            return "B"
        case .empty:
            return "."
        }
    }
}

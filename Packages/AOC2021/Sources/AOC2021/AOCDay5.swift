//
//  AOCDay5.swift
//  
//
//  Created by Kamaal M Farah on 05/12/2021.
//

import Foundation
import ShrimpExtensions

struct AOCDay5 {
    public static let part1 = Part1()
    public static let part2 = Part2()

    public static let input: String? = {
        guard let inputURL = Bundle.module.url(forResource: "day5", withExtension: "txt") else { return nil }
        return try? String(contentsOf: inputURL, encoding: .utf8)
    }()

    private init() { }

    public struct Part1 {
        fileprivate init() { }

        public func execute(with input: String) -> Int {
            let lines = input.splitLines

            var gridSize = 0
            for line in lines {
                for instruction in line.components(separatedBy: "->") {
                    let separatedInstruction = instruction.trimmingByWhitespacesAndNewLines.split(separator: ",")
                    for instruction in separatedInstruction {
                        if let coordinate = Int(instruction), coordinate > gridSize {
                            gridSize = coordinate
                        }
                    }
                }
            }

            let grid = VectorGrid(size: 1000)

            for line in lines {
                grid.markWithInstruction(String(line))
            }

//            grid.printGrid()

            return grid.countTooManyOverlaps(max: 1)
        }
    }

    public struct Part2 {
        fileprivate init() { }

        public func execute(with input: String) -> Int {
            return 0
        }
    }
}

class VectorGrid {
    var items: [VectorItem]
    let size: Int

    init(size: Int) {
        var items: [VectorItem] = []
        for x in 0..<size {
            for y in 0..<size {
                let item = VectorItem(x: x, y: y)
                items.append(item)
            }
        }
        self.size = size
        self.items = items
    }

    func markWithInstruction(_ instructions: String) {
        var paresedInstructions: [VectorItem] = []
        for instruction in instructions.components(separatedBy: "->") {
            let separatedInstruction = instruction.trimmingByWhitespacesAndNewLines.split(separator: ",")
            guard separatedInstruction.count > 1,
                    let x = Int(separatedInstruction[0]),
                    let y = Int(separatedInstruction[1]) else { return }
            paresedInstructions.append(.init(x: x, y: y))
        }

        guard paresedInstructions.count > 1 else { return }

        var items = self.items

        if paresedInstructions[0].x == paresedInstructions[1].x { // vertical move
            var minimum = 0
            var maximum = 0

            if paresedInstructions[0].y > paresedInstructions[1].y {
                minimum = paresedInstructions[1].y
                maximum = paresedInstructions[0].y
            } else {
                minimum = paresedInstructions[0].y
                maximum = paresedInstructions[1].y
            }

            for i in minimum...maximum {
                let gridIndex = (i * size + paresedInstructions[0].x) + 1
                items[gridIndex].overlaps += 1
            }
        } else if paresedInstructions[0].y == paresedInstructions[1].y { // horizontal move
            var minimum = 0
            var maximum = 0

            if paresedInstructions[0].x > paresedInstructions[1].x {
                minimum = paresedInstructions[1].x
                maximum = paresedInstructions[0].x
            } else {
                minimum = paresedInstructions[0].x
                maximum = paresedInstructions[1].x
            }

            for i in minimum...maximum {
                let gridIndex = (paresedInstructions[0].y *  size + i) + 1
                items[gridIndex].overlaps += 1
            }
        }

        self.items = items
    }

    func printGrid() {
        var rows: [[Int]] = []
        for item in items {
            if rows.isEmpty {
                rows.append([item.overlaps])
            }

            if (rows.last?.count ?? 0) < size {
                rows[rows.count - 1].append(item.overlaps)
            } else {
                rows.append([item.overlaps])
            }
        }
        for row in rows {
            print("\(row.count)x\(rows.count)", row)
        }
    }

    func countTooManyOverlaps(max: Int) -> Int {
        var sum = 0
        for item in items {
            if item.overlaps > max {
                sum += 1
            }
        }
        return sum
    }
}

struct VectorItem {
    let x: Int
    let y: Int
    var overlaps = 0

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

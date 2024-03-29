//
//  Day8.swift
//
//
//  Created by Kamaal M Farah on 07/12/2022.
//

import Foundation
import ShrimpExtensions

extension AOC2022 {
    public enum Day8: DayScaffold {
        public static let resourceName = "day8"

        public enum Part1 {
            public static func execute(with input: String) -> Int {
                var visibleTrees = 0
                process(input) { tick in
                    if tick.isEdge {
                        visibleTrees += 1
                        return
                    }

                    if tick.sightIsClear {
                        visibleTrees += 1
                    }
                }

                return visibleTrees
            }
        }

        public enum Part2 {
            public static func execute(with input: String) -> Int {
                var highestScenicScore = 0
                process(input) { tick in
                    if tick.isEdge {
                        return
                    }

                    let edges = tick.scenicEdges
                    if edges.scenicScore > highestScenicScore {
                        highestScenicScore = edges.scenicScore
                    }
                }

                return highestScenicScore
            }
        }
    }
}

private func makeGrid(from input: String) -> Grid<Tree> {
    input
        .splitLines
        .reduce(Grid<Tree>(), {
            let row = $1.map({ Tree(height: $0.int!) })
            var grid = $0
            grid.addRow(row)
            return grid
        })
}

private func process(_ input: String, tick: (ProcessTick) -> Void) {
    let grid = makeGrid(from: input)

    for (x, row) in grid.items.enumerated() {
        for y in 0..<row.count {
            tick(ProcessTick(grid: grid, coordinates: Coordinates(x: x, y: y)))
        }
    }
}

private struct Tree: Equatable, CustomStringConvertible {
    let height: Int

    // - MARK: CustomStringConvertible

    var description: String {
        "\(height)"
    }
}

private struct ProcessTick {
    let grid: Grid<Tree>
    let coordinates: Coordinates

    var tree: Tree {
        row[coordinates.x]
    }

    var scenicEdges: Edges {
        func findFunction(_ currentTree: Tree) -> Bool {
            currentTree.height >= tree.height
        }

        let bottom = treesBelow.findIndex(where: findFunction).added(1) ?? treesBelow.count
        let top = treesAbove.findIndex(where: findFunction).added(1) ?? treesAbove.count
        let right = treesToTheRight.findIndex(where: findFunction).added(1) ?? treesToTheRight.count
        let left = treesToTheLeft.findIndex(where: findFunction).added(1) ?? treesToTheLeft.count

        return Edges(top: top, left: left, right: right, bottom: bottom)
    }

    var sightIsClear: Bool {
        func getTallestTree(_ partialResult: Int, _ tree: Tree) -> Int {
            if tree.height > partialResult {
                return tree.height
            }

            return partialResult
        }

        let right = treesToTheRight.reduce(0, getTallestTree)
        let left = treesToTheLeft.reduce(0, getTallestTree)
        let top = treesAbove.reduce(0, getTallestTree)
        let bottom = treesBelow.reduce(0, getTallestTree)

        let edges = Edges(top: top, left: left, right: right, bottom: bottom)
        return edges.isVisible(from: tree)
    }

    var isEdge: Bool {
        grid.cellIsRightEdge(x: coordinates.x) ||
        grid.cellIsLeftEdge(x: coordinates.x) ||
        grid.cellIsTopEdge(y: coordinates.y) ||
        grid.cellIsBottomEdge(y: coordinates.y)
    }

    var treesToTheRight: [Tree] {
        row
            .ranged(from: coordinates.x + 1)
            .asArray()
    }

    var treesToTheLeft: [Tree] {
        row
            .ranged(from: 0, to: coordinates.x)
            .reversed()
    }

    var treesAbove: [Tree] {
        column
            .ranged(from: 0, to: coordinates.y)
            .reversed()
    }

    var treesBelow: [Tree] {
        column
            .ranged(from: coordinates.y + 1)
            .asArray()
    }

    var column: [Tree] {
        grid.getColumn(x: coordinates.x)
    }

    var row: [Tree] {
        grid.getRow(y: coordinates.y)!
    }
}

private struct Edges {
    let top: Int
    let left: Int
    let right: Int
    let bottom: Int

    var array: [Int] {
        [right, left, top, bottom]
    }

    var scenicScore: Int {
        array.reduce(1, { $0 * $1 })
    }

    func isVisible(from tree: Tree) -> Bool {
        array.first(where: { tree.height > $0 }) != nil
    }
}

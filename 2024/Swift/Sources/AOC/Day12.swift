//
//  Day12.swift
//  AOC
//
//  Created by Kamaal M Farah on 12/12/24.
//

public struct Day12 {
    private init() { }

    public static func part1(_ input: String) -> Int {
        let garden = prepare(input)
        let regions = garden.getRegions()
        let price = calculatePriceWithPerimeters(regions)

        return price
    }

    public static func part2(_ input: String) -> Int {
        let garden = prepare(input)
        let _ = garden.getRegions()

        return 0
    }

    private static func calculatePriceWithPerimeters(_ regions: [[Plot]]) -> Int {
        regions.reduce(0, { result, region in
            let perimeters = getPerimetersForRegion(region)
            let area = region.count

            return result + (area * perimeters)
        })
    }

    private static func getPerimetersForRegion(_ region: [Plot]) -> Int {
        region.reduce(0, { result, plot in
            var hasLeftNeighbor = false
            var hasRightNeighbor = false
            var hasUpperNeighbor = false
            var hasUnderNeighbor = false
            for nextPlot in region where nextPlot != plot {
                if !hasLeftNeighbor && nextPlot.point.x == (plot.point.x - 1) && nextPlot.point.y == plot.point.y {
                    hasLeftNeighbor = true
                }
                if !hasRightNeighbor && nextPlot.point.x == (plot.point.x + 1) && nextPlot.point.y == plot.point.y {
                    hasRightNeighbor = true
                }
                if !hasUpperNeighbor && nextPlot.point.x == plot.point.x && nextPlot.point.y == (plot.point.y - 1) {
                    hasUpperNeighbor = true
                }
                if !hasUnderNeighbor && nextPlot.point.x == plot.point.x && nextPlot.point.y == (plot.point.y + 1) {
                    hasUnderNeighbor = true
                }
                if hasLeftNeighbor && hasRightNeighbor && hasUpperNeighbor && hasUnderNeighbor {
                    break
                }
            }

            var perimeters = 0
            if !hasLeftNeighbor {
                perimeters += 1
            }
            if !hasRightNeighbor {
                perimeters += 1
            }
            if !hasUpperNeighbor {
                perimeters += 1
            }
            if !hasUnderNeighbor {
                perimeters += 1
            }

            return result + perimeters
        })
    }
}

private struct Point: Hashable {
    let x: Int
    let y: Int
}

private struct Plot: Hashable {
    let point: Point
    let value: Character
}

private struct Garden {
    let plots: [[Plot]]
    let height: Int
    let width: Int

    init(plots: [[Plot]]) {
        self.plots = plots
        self.height = plots.count - 1
        self.width = plots[0].count - 1
    }

    func get(x: Int, y: Int) -> Plot? {
        guard x >= 0 && x <= height && y >= 0 && y <= width else { return nil }

        return plots[x][y]
    }

    func getRegions() -> [[Plot]] {
        var checkedPoints = Set<Point>()
        var regions: [[Plot]] = []
        plots.forEach({ row in
            row.forEach({ plot in
                guard !checkedPoints.contains(plot.point) else { return }

                checkedPoints.insert(plot.point)
                var region: Set<Plot> = [plot]
                var pointsToCheck: [Point] = [plot.point]

                func handlePlot(_ plotToCheck: Plot?) {
                    guard let plotToCheck else { return }
                    guard plotToCheck.value == plot.value else { return }
                    guard !region.contains(plotToCheck) else { return }

                    region.insert(plotToCheck)
                    pointsToCheck.append(plotToCheck.point)
                    checkedPoints.insert(plotToCheck.point)
                }

                while !pointsToCheck.isEmpty {
                    let pointToCheck = pointsToCheck.popLast()!
                    handlePlot(get(x: pointToCheck.x, y: pointToCheck.y - 1))
                    handlePlot(get(x: pointToCheck.x, y: pointToCheck.y + 1))
                    handlePlot(get(x: pointToCheck.x - 1, y: pointToCheck.y))
                    handlePlot(get(x: pointToCheck.x + 1, y: pointToCheck.y))
                }

                assert(!region.isEmpty, "Expect there to be a region when coming to this point")

                regions.append(Array(region))
            })
        })

        return regions
    }

    static func fromInput(_ input: String) -> Garden {
        let plots = input
            .split(separator: "\n")
            .enumerated()
            .map({ x, line in
                line
                    .enumerated()
                    .map({ y, character in
                        Plot(point: .init(x: x, y: y), value: character)
                    })
            })

        return Garden(plots: plots)
    }
}

private func prepare(_ input: String) -> Garden {
    .fromInput(input)
}

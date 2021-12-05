package day5

import (
	"fmt"
	"log"
	"strconv"
	"strings"
)

const (
	STARTING_PLOT = "."
	FIRST_PLOT    = "1"
	SECOND_PLOT   = "2"
	LOSING_PLOT   = "2"
	GRID_SIZE     = 10
)

func Run(input string) {
	fmt.Println("Day 5 Part 1:", Part1(input)) // 10169, 4693
	fmt.Println("Day 5 Part 2:", Part2(input)) // 6132
}

func Part2(input string) int {
	lines := strings.Split(input, "\n")

	gridSize := 0
	for _, line := range lines {
		coordinates := strings.Split(strings.TrimSpace(line), "->")
		for _, coordinate := range coordinates {
			intCoordinates := makeCoordinate(coordinate)
			for _, coordinate := range intCoordinates {
				if gridSize < coordinate {
					gridSize = coordinate
				}
			}
		}
	}

	plots := []string{}

	for i := 0; i < ((gridSize+1)*(gridSize+1))-1; i += 1 {
		plots = append(plots, STARTING_PLOT)
	}

	diagonalTries := [][]int{}

	for _, line := range lines {
		coordinates := strings.Split(strings.TrimSpace(line), "->")
		firstCoordinate := makeCoordinate(coordinates[0])
		secondCoordinate := makeCoordinate(coordinates[1])

		if firstCoordinate[0] == secondCoordinate[0] { // vertical move
			minimum := 0
			maximum := 0

			if firstCoordinate[1] > secondCoordinate[1] {
				minimum = secondCoordinate[1]
				maximum = firstCoordinate[1]
			} else {
				minimum = firstCoordinate[1]
				maximum = secondCoordinate[1]
			}

			// fmt.Println(minimum, maximum)

			for i := minimum; i <= maximum; i += 1 {
				plotIndex := (i*(gridSize+1) + firstCoordinate[0]) + 1
				// fmt.Println("vertical move", firstCoordinate[0], firstCoordinate[1], "to", secondCoordinate[0], secondCoordinate[1], "plotIndex", plotIndex)
				if plotIndex >= len(plots) {
					continue
				}
				switch plots[plotIndex] {
				case STARTING_PLOT:
					plots[plotIndex] = FIRST_PLOT
				case FIRST_PLOT:
					plots[plotIndex] = SECOND_PLOT
				case SECOND_PLOT:
					plots[plotIndex] = LOSING_PLOT
				}
			}
		} else if firstCoordinate[1] == secondCoordinate[1] { // horizontal move
			minimum := 0
			maximum := 0

			if firstCoordinate[0] > secondCoordinate[0] {
				minimum = secondCoordinate[0]
				maximum = firstCoordinate[0]
			} else {
				minimum = firstCoordinate[0]
				maximum = secondCoordinate[0]
			}

			// fmt.Println(minimum, maximum)

			for i := minimum; i <= maximum; i += 1 {
				plotIndex := (firstCoordinate[1]*(gridSize+1) + i) + 1
				// fmt.Println("horizontal move", firstCoordinate[0], firstCoordinate[1], "to", secondCoordinate[0], secondCoordinate[1], "plotIndex", plotIndex)
				if plotIndex >= len(plots) {
					continue
				}
				switch plots[plotIndex] {
				case STARTING_PLOT:
					plots[plotIndex] = FIRST_PLOT
				case FIRST_PLOT:
					plots[plotIndex] = SECOND_PLOT
				case SECOND_PLOT:
					plots[plotIndex] = LOSING_PLOT
				}
			}
		} else { // diagonal move
			minimum := 0
			maximum := 0

			combinedCoordinate := []int{}
			combinedCoordinate = append(combinedCoordinate, firstCoordinate...)
			combinedCoordinate = append(combinedCoordinate, secondCoordinate...)

			for _, coordinate := range combinedCoordinate {
				if minimum > coordinate {
					minimum = coordinate
				}
				if maximum < coordinate {
					maximum = coordinate
				}
			}

			foundTry := false
			for _, diagonalTry := range diagonalTries {
				if diagonalTry[0] == minimum && diagonalTry[1] == maximum {
					foundTry = true
				}
			}

			if foundTry {
				continue
			}

			diagonalTries = append(diagonalTries, []int{minimum, maximum})

			fmt.Println(minimum, maximum)

			for i := minimum; i <= maximum; i += 1 {
				plotIndex := (i*(gridSize+1) + i) + 1
				fmt.Println("diagonal move", firstCoordinate[0], firstCoordinate[1], "to", secondCoordinate[0], secondCoordinate[1], "plotIndex", plotIndex)
				if plotIndex >= len(plots) {
					continue
				}
				switch plots[plotIndex] {
				case STARTING_PLOT:
					plots[plotIndex] = FIRST_PLOT
				case FIRST_PLOT:
					plots[plotIndex] = SECOND_PLOT
				case SECOND_PLOT:
					plots[plotIndex] = LOSING_PLOT
				}
			}
		}
	}

	tooManyOverlaps := 0
	orderedPlots := [][]string{}
	for _, plot := range plots {
		if len(orderedPlots) == 0 {
			orderedPlots = append(orderedPlots, []string{plot})
		}
		lastOrderedPlotIndex := len(orderedPlots) - 1
		lastOrderedPlot := orderedPlots[lastOrderedPlotIndex]
		if len(lastOrderedPlot) < (gridSize + 1) {
			orderedPlots[lastOrderedPlotIndex] = append(lastOrderedPlot, plot)
		} else {
			orderedPlots = append(orderedPlots, []string{plot})
		}
		if plot == LOSING_PLOT {
			tooManyOverlaps += 1
		}
	}

	for _, orderedPlot := range orderedPlots {
		fmt.Println(len(orderedPlot), orderedPlot)
	}

	return tooManyOverlaps
}

func Part1(input string) int {
	lines := strings.Split(input, "\n")

	gridSize := 0
	for _, line := range lines {
		coordinates := strings.Split(strings.TrimSpace(line), "->")
		for _, coordinate := range coordinates {
			intCoordinates := makeCoordinate(coordinate)
			for _, coordinate := range intCoordinates {
				if gridSize < coordinate {
					gridSize = coordinate
				}
			}
		}
	}

	plots := []string{}

	for i := 0; i < ((gridSize+1)*(gridSize+1))-1; i += 1 {
		plots = append(plots, STARTING_PLOT)
	}

	for _, line := range lines {
		coordinates := strings.Split(strings.TrimSpace(line), "->")
		firstCoordinate := makeCoordinate(coordinates[0])
		secondCoordinate := makeCoordinate(coordinates[1])

		if firstCoordinate[0] == secondCoordinate[0] { // vertical move
			minimum := 0
			maximum := 0

			if firstCoordinate[1] > secondCoordinate[1] {
				minimum = secondCoordinate[1]
				maximum = firstCoordinate[1]
			} else {
				minimum = firstCoordinate[1]
				maximum = secondCoordinate[1]
			}

			// fmt.Println(minimum, maximum)

			for i := minimum; i <= maximum; i += 1 {
				plotIndex := (i*(gridSize+1) + firstCoordinate[0]) + 1
				// fmt.Println("vertical move", firstCoordinate[0], firstCoordinate[1], "to", secondCoordinate[0], secondCoordinate[1], "plotIndex", plotIndex)
				if plotIndex >= len(plots) {
					continue
				}
				switch plots[plotIndex] {
				case STARTING_PLOT:
					plots[plotIndex] = FIRST_PLOT
				case FIRST_PLOT:
					plots[plotIndex] = SECOND_PLOT
				case SECOND_PLOT:
					plots[plotIndex] = LOSING_PLOT
				}
			}
		} else if firstCoordinate[1] == secondCoordinate[1] { // horizontal move
			minimum := 0
			maximum := 0

			if firstCoordinate[0] > secondCoordinate[0] {
				minimum = secondCoordinate[0]
				maximum = firstCoordinate[0]
			} else {
				minimum = firstCoordinate[0]
				maximum = secondCoordinate[0]
			}

			// fmt.Println(minimum, maximum)

			for i := minimum; i <= maximum; i += 1 {
				plotIndex := (firstCoordinate[1]*(gridSize+1) + i) + 1
				// fmt.Println("horizontal move", firstCoordinate[0], firstCoordinate[1], "to", secondCoordinate[0], secondCoordinate[1], "plotIndex", plotIndex)
				if plotIndex >= len(plots) {
					continue
				}
				switch plots[plotIndex] {
				case STARTING_PLOT:
					plots[plotIndex] = FIRST_PLOT
				case FIRST_PLOT:
					plots[plotIndex] = SECOND_PLOT
				case SECOND_PLOT:
					plots[plotIndex] = LOSING_PLOT
				}
			}
		}
	}

	tooManyOverlaps := 0
	orderedPlots := [][]string{}
	for _, plot := range plots {
		if len(orderedPlots) == 0 {
			orderedPlots = append(orderedPlots, []string{plot})
		}
		lastOrderedPlotIndex := len(orderedPlots) - 1
		lastOrderedPlot := orderedPlots[lastOrderedPlotIndex]
		if len(lastOrderedPlot) < (gridSize + 1) {
			orderedPlots[lastOrderedPlotIndex] = append(lastOrderedPlot, plot)
		} else {
			orderedPlots = append(orderedPlots, []string{plot})
		}
		if plot == LOSING_PLOT {
			tooManyOverlaps += 1
		}
	}

	// for _, orderedPlot := range orderedPlots {
	// fmt.Println(len(orderedPlot), orderedPlot)
	// }

	return tooManyOverlaps
}

func makeCoordinate(input string) []int {
	splittedCoordinate := strings.Split(input, ",")
	horizontal, err := strconv.Atoi(strings.TrimSpace(splittedCoordinate[0]))
	if err != nil {
		log.Fatalln(err)
	}

	vertical, err := strconv.Atoi(strings.TrimSpace(splittedCoordinate[1]))
	if err != nil {
		log.Fatalln(err)
	}

	return []int{horizontal, vertical}
}

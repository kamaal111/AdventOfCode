package day4

import (
	"fmt"
	"strings"
)

func Run(input string) {
	fmt.Println("Day 4 Part 2:", Part1(input))
	fmt.Println("Day 4 Part 2:", Part2(input))
}

func Part1(input string) int {
	lines := strings.Split(input, "\n")

	makeGame(lines)

	return 0
}

func Part2(input string) int {
	return 0
}

func makeGame(lines []string) {
	boards := []string{}
	// unmarkedBoards := []string{}

	for i := 1; i < len(lines); i += 1 {
		line := string(lines[i])
		fmt.Println(line)
		if line == "" {
			continue
		}

		boardsLength := len(boards)
		if boardsLength > 0 && len(boards[boardsLength-1]) < (5*5) {
			pieces := strings.Split(line, " ")
			fmt.Println(pieces)
		}
		// boards = append(boards, i)
		// unmarkedBoards = append(unmarkedBoards, i)
		break
	}
}

type Game struct {
	plays          []string
	boards         []string
	unmarkedBoards []string
}

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

	var board [][]int
	board = board[:]

	// plays := lines[0]
	// for _ = range plays {
	for i := 2; i < len(lines); i += 1 {
		if lines[i] == "" {
			board = append(board, []int{})
		}

		board[len(board)-1] = append(board[len(board)-1], i)
	}
	// }

	fmt.Println(board)

	return 0
}

func Part2(input string) int {
	return 0
}

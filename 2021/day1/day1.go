package day1

import (
	"log"
	"strconv"
	"strings"
)

func Run(input string) {
	log.Println("Day 1 Part 2:", Part1(input))
	log.Println("Day 1 Part 2:", Part2(input))
}

func Part2(input string) int {
	lines := strings.Split(input, "\n")

	increases := 0
	for lineNumber, line := range lines {
		intLine, err := strconv.Atoi(line)
		if err != nil {
			log.Fatal(err)
		}

		if lineNumber+3 < len(lines) {
			firstSum := intLine
			secondSum := 0
			for i := 0; i < 3; i += 1 {
				nextLine, err := strconv.Atoi(lines[lineNumber+i+1])
				if err != nil {
					log.Fatal(err)
				}

				if i < 2 {
					firstSum = firstSum + nextLine
				}

				secondSum = secondSum + nextLine
			}

			if secondSum > firstSum {
				increases += 1
			}
		}
	}

	return increases
}

func Part1(input string) int {
	lines := strings.Split(input, "\n")

	increases := 0
	for lineNumber, line := range lines {
		intLine, err := strconv.Atoi(line)
		if err != nil {
			log.Fatal(err)
		}

		if lineNumber+1 < len(lines) {
			nextLine, err := strconv.Atoi(lines[lineNumber+1])
			if err != nil {
				log.Fatal(err)
			}

			if intLine < nextLine {
				increases += 1
			}
		}
	}

	return increases
}

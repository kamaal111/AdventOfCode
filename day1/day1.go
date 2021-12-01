package main

import (
	"io/ioutil"
	"log"
	"strconv"
	"strings"
)

func main() {
	log.Println("Part 1:", part1())
	log.Println("Part 2:", part2())
}

func part2() int {
	lines, err := getInputLines()
	if err != nil {
		log.Fatal(err)
	}

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

func part1() int {
	lines, err := getInputLines()
	if err != nil {
		log.Fatal(err)
	}

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

func getInputLines() ([]string, error) {
	inputFileBytes, err := ioutil.ReadFile("./input.txt")
	if err != nil {
		return nil, err
	}
	lines := strings.Split(string(inputFileBytes), "\n")
	return lines, nil
}

package day2

import (
	"fmt"
	"log"
	"strconv"
	"strings"
)

func Run(input string) {
	fmt.Println("Day 2 Part 2:", Part1(input))
	fmt.Println("Day 2 Part 2:", Part2(input))
}

func Part2(input string) int {
	lines := strings.Split(input, "\n")

	depth := 0
	horizontal := 0
	aim := 0
	for _, command := range lines {
		splittedCommand := strings.Split(command, " ")

		position, err := strconv.Atoi(splittedCommand[1])
		if err != nil {
			log.Fatal(err)
		}

		switch splittedCommand[0] {
		case "forward":
			horizontal += position
			depth += (position * aim)
		case "down":
			aim += position
		case "up":
			aim -= position
		}
	}

	return depth * horizontal
}

func Part1(input string) int {
	lines := strings.Split(input, "\n")

	depth := 0
	horizontal := 0
	for _, command := range lines {
		splittedCommand := strings.Split(command, " ")

		position, err := strconv.Atoi(splittedCommand[1])
		if err != nil {
			log.Fatal(err)
		}

		switch splittedCommand[0] {
		case "forward":
			horizontal += position
		case "down":
			depth += position
		case "up":
			depth -= position
		}
	}

	return depth * horizontal
}

package day2

import (
	"log"
	"strconv"
	"strings"

	"github.com/kamaal111/AdventOfCode/utils"
)

const inputPath = "day2/input.txt"

func Part1() int {
	lines, err := utils.GetInputLines(inputPath)
	if err != nil {
		log.Fatalln(err)
	}

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

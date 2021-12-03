package day3

import (
	"fmt"
	"log"
	"strconv"

	"github.com/kamaal111/AdventOfCode/2021/utils"
)

const inputPath = "day3/input.txt"

func Part2() int {
	lines, err := utils.GetInputLines(inputPath)
	if err != nil {
		log.Fatalln(err)
	}

	var oxygenBitCriteria []string

	zeros := 0
	var zerosBitCriteria []string
	ones := 0
	var onesBitCriteria []string

	for _, line := range lines {
		if line[0] == '0' {
			zeros += 1
			zerosBitCriteria = append(zerosBitCriteria, line)
		} else {
			ones += 1
			onesBitCriteria = append(onesBitCriteria, line)
		}
	}

	oxygen := ""

	if zeros > ones {
		oxygen = "0"
		oxygenBitCriteria = zerosBitCriteria
	} else if ones > zeros {
		oxygen = "1"
		oxygenBitCriteria = onesBitCriteria
	}

	lengthOfFirstCriteria := len(oxygenBitCriteria[0])
	for i := 1; i < lengthOfFirstCriteria; i += 1 {
		for _, line := range oxygenBitCriteria {
			fmt.Println(string(line[i]))
		}
	}

	fmt.Println(oxygen)

	return 0 * 0
}

func Part1() int {
	lines, err := utils.GetInputLines(inputPath)
	if err != nil {
		log.Fatalln(err)
	}

	gammaRate := ""
	epsilonRate := ""

	lengthOfFirstLine := len(lines[0])
	for i := 0; i < lengthOfFirstLine; i += 1 {
		zeros := 0
		ones := 0

		for _, line := range lines {
			if line[i] == '0' {
				zeros += 1
			} else {
				ones += 1
			}
		}

		if zeros > ones {
			gammaRate += "0"
			epsilonRate += "1"
		} else if ones > zeros {
			gammaRate += "1"
			epsilonRate += "0"
		}
	}

	gammaRateInt, err := strconv.ParseInt(gammaRate, 2, 64)
	if err != nil {
		log.Fatalln(err)
	}

	epsilonRateInt, err := strconv.ParseInt(epsilonRate, 2, 64)
	if err != nil {
		log.Fatalln(err)
	}

	return int(gammaRateInt * epsilonRateInt)
}

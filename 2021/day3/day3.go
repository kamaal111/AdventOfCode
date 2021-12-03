package day3

import (
	"log"
	"strconv"

	"github.com/kamaal111/AdventOfCode/2021/utils"
)

func Part2(inputPath string) int {
	lines, err := utils.GetInputLines(inputPath)
	if err != nil {
		log.Fatalln(err)
	}

	oxygen := getOxygen(lines)
	scrubber := getScrubber(lines)

	oxygenInt, err := strconv.ParseInt(oxygen, 2, 64)
	if err != nil {
		log.Fatalln(err)
	}

	scrubberInt, err := strconv.ParseInt(scrubber, 2, 64)
	if err != nil {
		log.Fatalln(err)
	}

	return int(oxygenInt * scrubberInt)
}

func getScrubber(lines []string) string {
	bitCriteria := lines

	scrubber := ""

	lengthOfFirstLine := len(lines[0])
	for i := 0; i < lengthOfFirstLine; i += 1 {
		zeros := 0
		var zerosBitCriteria []string
		ones := 0
		var onesBitCriteria []string

		index := 1
		for _, line := range bitCriteria {
			if line[i] == '0' {
				zeros += 1
				zerosBitCriteria = append(zerosBitCriteria, line)
			} else {
				ones += 1
				onesBitCriteria = append(onesBitCriteria, line)
			}
			index += 1
		}

		if zeros <= ones {
			scrubber += "0"
			bitCriteria = zerosBitCriteria
		} else if ones < zeros {
			scrubber += "1"
			bitCriteria = onesBitCriteria
		}

		if len(bitCriteria) <= 1 {
			return bitCriteria[0]
		}
	}

	return scrubber
}

func getOxygen(lines []string) string {
	bitCriteria := lines

	oxygen := ""

	lengthOfFirstLine := len(lines[0])
	for i := 0; i < lengthOfFirstLine; i += 1 {
		zeros := 0
		var zerosBitCriteria []string
		ones := 0
		var onesBitCriteria []string

		index := 1
		for _, line := range bitCriteria {
			if line[i] == '0' {
				zeros += 1
				zerosBitCriteria = append(zerosBitCriteria, line)
			} else {
				ones += 1
				onesBitCriteria = append(onesBitCriteria, line)
			}
			index += 1
		}

		if zeros > ones {
			oxygen += "0"
			bitCriteria = zerosBitCriteria
		} else if ones >= zeros {
			oxygen += "1"
			bitCriteria = onesBitCriteria
		}

		if len(bitCriteria) <= 1 {
			return bitCriteria[0]
		}
	}

	return oxygen
}

func Part1(inputPath string) int {
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

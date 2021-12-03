package main

import (
	"fmt"
	"log"
	"time"

	"github.com/kamaal111/AdventOfCode/2021/day1"
	"github.com/kamaal111/AdventOfCode/2021/day2"
	"github.com/kamaal111/AdventOfCode/2021/day3"
	"github.com/kamaal111/AdventOfCode/2021/day4"
	"github.com/kamaal111/AdventOfCode/2021/utils"
)

func main() {
	start := time.Now()

	inputDay1, err := utils.GetInputString("day1/input.txt")
	if err != nil {
		log.Fatal(err)
	}
	day1.Run(inputDay1)

	inputDay2, err := utils.GetInputString("day2/input.txt")
	if err != nil {
		log.Fatal(err)
	}
	day2.Run(inputDay2)

	inputDay3, err := utils.GetInputString("day3/input.txt")
	if err != nil {
		log.Fatal(err)
	}
	day3.Run(inputDay3)

	inputDay4, err := utils.GetInputString("day4/input.txt")
	if err != nil {
		log.Fatal(err)
	}
	day4.Run(inputDay4)

	elapsed := time.Since(start)
	fmt.Printf("Time: %s\n", elapsed)
}

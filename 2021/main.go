package main

import (
	"log"

	"github.com/kamaal111/AdventOfCode/2021/day1"
	"github.com/kamaal111/AdventOfCode/2021/day2"
	"github.com/kamaal111/AdventOfCode/2021/day3"
)

func main() {
	log.Println("Day 1 Part 1:", day1.Part1()) // 1374
	log.Println("Day 1 Part 2:", day1.Part2()) // 1418

	log.Println("Day 2 Part 1:", day2.Part1()) // 2272262
	log.Println("Day 2 Part 2:", day2.Part2()) // 2134882034

	log.Println("Day 3 Part 1:", day3.Part1()) // 1025636
	log.Println("Day 3 Part 2:", day3.Part2()) // 793873
}

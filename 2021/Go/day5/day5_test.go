package day5

import (
	"testing"

	"github.com/kamaal111/AdventOfCode/aoc2021/utils"
)

const exampleInput = `0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2`

const inputPath = "../../../Swift/AOC2021/Sources/AOC2021/Inputs/day5.txt"

func TestPart1(t *testing.T) {
	input, err := utils.GetInputString(inputPath)
	if err != nil {
		t.Errorf("could not get input: %v", err)
	}

	got := Part1(input)
	want := 5147

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}
}

func TestPart1Example(t *testing.T) {
	got := Part1(exampleInput)
	want := 5

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}
}

func TestPart2(t *testing.T) {
	input, err := utils.GetInputString(inputPath)
	if err != nil {
		t.Errorf("could not get input: %v", err)
	}

	got := Part2(input)
	want := 16925

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}
}

func TestPart2Example(t *testing.T) {
	got := Part2(exampleInput)
	want := 12

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}
}

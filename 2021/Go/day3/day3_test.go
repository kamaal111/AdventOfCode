package day3

import (
	"testing"

	"github.com/kamaal111/AdventOfCode/aoc2021/utils"
)

const inputPath = "../Swift/Sources/AOC2021/Inputs/day3.txt"

const exampleInput = `00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010`

func TestPart1(t *testing.T) {
	input, err := utils.GetInputString(inputPath)
	if err != nil {
		t.Errorf("could not get input: %v", err)
	}

	got := Part1(input)
	want := 1025636

	if got != want {
		t.Errorf("got %q, wanted %q", got, want)
	}
}

func TestPart1Example(t *testing.T) {
	got := Part1(exampleInput)
	want := 198

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
	want := 793873

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}
}

func TestPart2Example(t *testing.T) {
	got := Part2(exampleInput)
	want := 230

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}
}

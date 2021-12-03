package day1

import (
	"testing"

	"github.com/kamaal111/AdventOfCode/2021/utils"
)

const inputPath = "input.txt"

const exampleInput = `199
200
208
210
200
207
240
269
260
263`

func TestPart1(t *testing.T) {
	input, err := utils.GetInputString(inputPath)
	if err != nil {
		t.Errorf("could not get input: %v", err)
	}

	got := Part1(input)
	want := 1374

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}
}

func TestPart1Example(t *testing.T) {
	got := Part1(exampleInput)
	want := 7

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
	want := 1418

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}
}

func TestPart2Example(t *testing.T) {
	got := Part2(exampleInput)
	want := 5

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}
}

package day2

import (
	"testing"

	"github.com/kamaal111/AdventOfCode/2021/utils"
)

const inputPath = "input.txt"

const exampleInput = `forward 5
down 5
forward 8
up 3
down 8
forward 2`

func TestPart1(t *testing.T) {
	input, err := utils.GetInputString(inputPath)
	if err != nil {
		t.Errorf("could not get input: %v", err)
	}

	got := Part1(input)
	want := 2272262

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}
}

func TestPart1Example(t *testing.T) {
	got := Part1(exampleInput)
	want := 150

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
	want := 2134882034

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}
}

func TestPart2Example(t *testing.T) {
	got := Part2(exampleInput)
	want := 900

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}
}

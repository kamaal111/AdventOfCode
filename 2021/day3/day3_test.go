package day3

import (
	"testing"

	"github.com/kamaal111/AdventOfCode/2021/utils"
)

const inputPath = "input.txt"

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
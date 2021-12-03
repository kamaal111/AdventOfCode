package day3

import "testing"

const inputPath = "input.txt"

func TestPart1(t *testing.T) {
	got := Part1(inputPath)
	want := 1025636

	if got != want {
		t.Errorf("got %q, wanted %q", got, want)
	}
}

func TestPart2(t *testing.T) {
	got := Part2(inputPath)
	want := 793873

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}
}

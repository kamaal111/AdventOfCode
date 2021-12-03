package day2

import "testing"

const inputPath = "input.txt"

func TestPart1(t *testing.T) {
	got := Part1(inputPath)
	want := 2272262

	if got != want {
		t.Errorf("got %q, wanted %q", got, want)
	}
}

func TestPart2(t *testing.T) {
	got := Part2(inputPath)
	want := 2134882034

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}
}

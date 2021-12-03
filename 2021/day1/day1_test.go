package day1

import "testing"

const inputPath = "input.txt"

func TestPart1(t *testing.T) {
	got := Part1(inputPath)
	want := 1374

	if got != want {
		t.Errorf("got %q, wanted %q", got, want)
	}
}

func TestPart2(t *testing.T) {
	got := Part2(inputPath)
	want := 1418

	if got != want {
		t.Errorf("got %q, wanted %q", got, want)
	}
}

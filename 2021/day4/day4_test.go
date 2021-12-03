package day4

import "testing"

const exampleInput = ``

func TestPart1Example(t *testing.T) {
	got := Part1(exampleInput)
	want := 22

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}
}

func TestPart2Example(t *testing.T) {
	got := Part2(exampleInput)
	want := 23

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}
}

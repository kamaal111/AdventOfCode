import { test, expect, describe } from "bun:test";

import { part1, part2, mapping, parseInput } from ".";
import { getInput } from "../utils/getInput";

const EXAMPLE_INPUT = `seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4`;

describe("day5", () => {
  test("part1", async () => {
    const input = await getInput("day5");
    expect(part1(input)).toBe(0);
  });

  test("part1 with example input", () => {
    const { seeds, maps } = parseInput(EXAMPLE_INPUT);
    const expectedSeeds = [81, 14, 57, 13];
    expect(seeds.map((seed) => mapping(seed, maps, "seed-to-soil"))).toEqual(
      expectedSeeds,
    );
    // expect(part1(EXAMPLE_INPUT)).toBe(35);
  });

  test("part2", async () => {
    const input = await getInput("day5");
    const result = part2(input);
    expect(result).toBe(0);
  });

  test("part2 with example input", () => {
    expect(part2(EXAMPLE_INPUT)).toBe(0);
  });
});

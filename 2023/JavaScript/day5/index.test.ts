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
    expect(part1(input)).toBe(84470622);
  });

  test("part1 with example input", () => {
    expect(part1(EXAMPLE_INPUT)).toBe(35);
  });

  test("part1 with example input mappings", () => {
    // Seed 79, soil 81, fertilizer 81, water 81, light 74, temperature 78, humidity 78, location 82.
    // Seed 14, soil 14, fertilizer 53, water 49, light 42, temperature 42, humidity 43, location 43.
    // Seed 55, soil 57, fertilizer 57, water 53, light 46, temperature 82, humidity 82, location 86.
    // Seed 13, soil 13, fertilizer 52, water 41, light 34, temperature 34, humidity 35, location 35.
    const { seeds, maps } = parseInput(EXAMPLE_INPUT);
    const expectedSoils = [81, 14, 57, 13];
    const expectedFertilizers = [81, 53, 57, 52];
    const expectedWaters = [81, 49, 53, 41];
    const expectedLights = [74, 42, 46, 34];
    const expectedTemperatures = [78, 42, 82, 34];
    const expectedHumidities = [78, 43, 82, 35];
    const expectedLocations = [82, 43, 86, 35];

    expect(seeds.map((value) => mapping(value, maps, "seed-to-soil"))).toEqual(
      expectedSoils,
    );
    expect(
      expectedSoils.map((value) => mapping(value, maps, "soil-to-fertilizer")),
    ).toEqual(expectedFertilizers);
    expect(
      expectedFertilizers.map((value) =>
        mapping(value, maps, "fertilizer-to-water"),
      ),
    ).toEqual(expectedWaters);
    expect(
      expectedWaters.map((value) => mapping(value, maps, "water-to-light")),
    ).toEqual(expectedLights);
    expect(
      expectedLights.map((value) =>
        mapping(value, maps, "light-to-temperature"),
      ),
    ).toEqual(expectedTemperatures);
    expect(
      expectedTemperatures.map((value) =>
        mapping(value, maps, "temperature-to-humidity"),
      ),
    ).toEqual(expectedHumidities);
    expect(
      expectedHumidities.map((value) =>
        mapping(value, maps, "humidity-to-location"),
      ),
    ).toEqual(expectedLocations);
  });

  test("part2", async () => {
    const input = await getInput("day5");
    const result = part2(input);
    expect(result).toBe(0);
  });

  test("part2 with example input", () => {
    expect(part2(EXAMPLE_INPUT)).toBe(46);
  });
});

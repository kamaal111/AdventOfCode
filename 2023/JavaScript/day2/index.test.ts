import { test, expect, describe } from "bun:test";

import { part1, part2 } from ".";
import { getInput } from "../utils/getInput";

const EXAMPLE_INPUT = `Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green`;

describe("day2", () => {
  test("part1", async () => {
    const input = await getInput("day2");
    expect(part1(input)).toBe(2331);
  });

  test("part1 with example input", () => {
    expect(part1(EXAMPLE_INPUT)).toBe(8);
  });

  test("part2", async () => {
    const input = await getInput("day2");
    const result = part2(input);
    expect(result).toBe(71585);
  });

  test("part2 with example input", () => {
    expect(part2(EXAMPLE_INPUT)).toBe(2286);
  });
});

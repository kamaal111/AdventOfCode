import { test, expect, describe } from "bun:test";

import { part1, part2 } from ".";
import { getInput } from "../utils/getInput";

const EXAMPLE_INPUT = `Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11`;

describe("day4", () => {
  test("part1", async () => {
    const input = await getInput("day4");
    expect(part1(input)).toBe(15268);
  });

  test("part1 with example input", () => {
    expect(part1(EXAMPLE_INPUT)).toBe(13);
  });

  test("part2", async () => {
    const input = await getInput("day4");
    const result = part2(input);
    expect(result).toBe(6283755);
  });

  test("part2 with example input", () => {
    expect(part2(EXAMPLE_INPUT)).toBe(30);
  });
});

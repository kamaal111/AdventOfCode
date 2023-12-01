import { test, expect, describe } from "bun:test";

import { part1, part2 } from ".";
import { getInput } from "../utils/getInput";

const EXAMPLE_INPUT1 = `1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet`;

const EXAMPLE_INPUT2 = `two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen`;

describe("day1", () => {
  test("part1", async () => {
    const input = await getInput("day1");
    expect(part1(input)).toBe(54561);
  });

  test("part1 with example input", () => {
    expect(part1(EXAMPLE_INPUT1)).toBe(142);
  });

  test("part2", async () => {
    const input = await getInput("day1");
    const result = part2(input);
    expect(result).not.toBe(54185);
    expect(result).not.toBe(53560);
    expect(result).toBe(54076);
  });

  test("part2 with example input", () => {
    expect(part2(EXAMPLE_INPUT2)).toBe(281);
  });
});

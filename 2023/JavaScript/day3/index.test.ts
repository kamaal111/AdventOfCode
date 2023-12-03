import { test, expect, describe } from "bun:test";

import { part1, part2 } from ".";
import {
  part1 as part1Refactored,
  part2 as part2Refactored,
} from "./refactored";
import { getInput } from "../utils/getInput";

const EXAMPLE_INPUT = `
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
`;

describe("day3", () => {
  test("part1", async () => {
    const input = await getInput("day3");
    const result = part1(input);
    expect(result).toBeGreaterThan(518219);
    expect(result).toBe(522726);
  });

  test("part1 refactored", async () => {
    const input = await getInput("day3");
    const result = part1Refactored(input);
    expect(result).toBe(522726);
  });

  test("part1 with example input", () => {
    expect(part1(EXAMPLE_INPUT)).toBe(4361);
  });

  test("part1 with example input raw", () => {
    expect(467 + 35 + 633 + 617 + 592 + 755 + 664 + 598).toBe(4361);
  });

  test("part2", async () => {
    const input = await getInput("day3");
    const result = part2(input);
    expect(result).toBeGreaterThan(467835);
    expect(result).toBe(81721933);
  });

  test("part2 with example input", () => {
    expect(part2(EXAMPLE_INPUT)).toBe(467835);
  });

  test("part2 with example input raw", () => {
    expect(467 * 35 + 755 * 598).toBe(467835);
  });

  test("part2 refactored with example input", async () => {
    expect(part2Refactored(EXAMPLE_INPUT)).toBe(467835);
  });

  test("part2 refactored", async () => {
    const input = await getInput("day3");
    expect(part2Refactored(input)).toBe(81721933);
  });
});

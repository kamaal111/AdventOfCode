import { test, expect, describe } from "bun:test";

import { part1, part2 } from ".";
import { getInput } from "../utils/getInput";

const EXAMPLE_INPUT = `Time:      7  15   30
Distance:  9  40  200`;

describe("day6", () => {
  test("part1", async () => {
    const input = await getInput("day6");
    expect(part1(input)).toBe(114400);
  });

  test("part1 with example input", () => {
    expect(part1(EXAMPLE_INPUT)).toBe(288);
  });

  test.skip("part2", async () => {
    const input = await getInput("day6");
    const result = part2(input);
    expect(result).toBe(21039729);
  });

  test("part2 with example input", () => {
    expect(part2(EXAMPLE_INPUT)).toBe(71503);
  });
});

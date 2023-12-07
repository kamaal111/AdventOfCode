import { test, expect, describe } from "bun:test";

import { part1, part2 } from ".";
import { getInput } from "../utils/getInput";

const EXAMPLE_INPUT = `32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483`;

describe("day7", () => {
  test("part1", async () => {
    const input = await getInput("day7");
    expect(part1(input)).toBe(252295678);
  });

  test("part1 with example input", () => {
    expect(part1(EXAMPLE_INPUT)).toBe(6440);
  });

  test("part2", async () => {
    const input = await getInput("day7");
    const result = part2(input);
    expect(result).toBeLessThan(250765966);
    expect(result).toBeLessThan(250719032);
    expect(result).toBe(250577259);
  });

  test("part2 with example input", () => {
    expect(part2(EXAMPLE_INPUT)).toBe(5905);
  });
});

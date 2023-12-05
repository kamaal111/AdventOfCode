import { test, expect, describe } from "bun:test";

import { part1, part2 } from ".";
import { getInput } from "../utils/getInput";

const EXAMPLE_INPUT = ``;

describe("day6", () => {
  test("part1", async () => {
    const input = await getInput("day6");
    expect(part1(input)).toBe(0);
  });

  test("part1 with example input", () => {
    expect(part1(EXAMPLE_INPUT)).toBe(0);
  });

  test("part2", async () => {
    const input = await getInput("day6");
    const result = part2(input);
    expect(result).toBe(0);
  });

  test("part2 with example input", () => {
    expect(part2(EXAMPLE_INPUT)).toBe(0);
  });
});

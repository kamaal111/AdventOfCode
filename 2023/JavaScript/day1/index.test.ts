import { test, expect, describe } from "bun:test";

import { part1, part2 } from ".";
import { getInput } from "../utils/getInput";

const EXAMPLE_INPUT = ``;

describe("day1", () => {
  test("part1", async () => {
    const input = await getInput("day1");
    expect(part1(input)).toBe("");
  });

  test("part1 with example input", () => {
    expect(part1(EXAMPLE_INPUT)).toBe("");
  });

  test("part2", async () => {
    const input = await getInput("day1");
    expect(part2(input)).toBe("");
  });

  test("part2 with example input", () => {
    expect(part2(EXAMPLE_INPUT)).toBe("");
  });
});

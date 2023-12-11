import { test, expect, describe, beforeAll } from "bun:test";

import { part1, part2 } from ".";
import { getInput } from "../utils/getInput";

const EXAMPLE_INPUT1 = `
.....
.S-7.
.|.|.
.L-J.
.....
`;

const EXAMPLE_INPUT2 = `
..F7.
.FJ|.
SJ.L7
|F--J
LJ...
`;

const EXAMPLE_INPUT3 = `
...........
.S-------7.
.|F-----7|.
.||.....||.
.||.....||.
.|L-7.F-J|.
.|..|.|..|.
.L--J.L--J.
...........
`;

describe("day10", () => {
  let input: string;

  beforeAll(async () => {
    input = await getInput("day10");
  });

  test("part1 with example input", () => {
    expect(part1(EXAMPLE_INPUT1)).toEqual(4);
  });

  test("part1 with example input2", () => {
    expect(part1(EXAMPLE_INPUT2)).toEqual(8);
  });

  test("part1", async () => {
    const result = part1(input);
    expect(result).not.toEqual(4);
    expect(result).not.toEqual(9);
    expect(result).not.toEqual(5);
    expect(result).toEqual(6613);
  });

  test("part2 with example input", () => {
    expect(part2(EXAMPLE_INPUT3)).toEqual(4);
  });

  test.skip("part2", async () => {
    const result = part2(input);
    expect(result).toEqual(0);
  });
});

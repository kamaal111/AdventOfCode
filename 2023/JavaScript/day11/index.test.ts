import { test, expect, describe, beforeAll } from "bun:test";

import { part1, part2 } from ".";
import { getInput } from "../utils/getInput";

const EXAMPLE_INPUT = `...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....`;

describe("day11", () => {
  let input: Awaited<string>;

  beforeAll(async () => {
    input = await getInput("day11");
  });

  test("part1 with example input", () => {
    expect(part1(EXAMPLE_INPUT)).toEqual(0);
  });

  test.skip("part1", async () => {
    const result = part1(input);
    expect(result).toEqual(0);
  });

  test("part2 with example input", () => {
    expect(part2(EXAMPLE_INPUT)).toEqual(0);
  });

  test("part2", async () => {
    const result = part2(input);
    expect(result).toEqual(0);
  });
});

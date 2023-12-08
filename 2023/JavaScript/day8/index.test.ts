import { test, expect, describe } from "bun:test";

import { part1, part2 } from ".";
import { getInput } from "../utils/getInput";

const EXAMPLE_INPUT1 = `RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)`;

const EXAMPLE_INPUT2 = `LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)`;

const EXAMPLE_INPUT3 = `LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)`;

describe("day8", () => {
  test("part1", async () => {
    const input = await getInput("day8");
    expect(part1(input)).toEqual(12361);
  });

  test("part1 with example input", () => {
    expect(part1(EXAMPLE_INPUT1)).toEqual(2);
  });

  test("part1 with example input 2", () => {
    expect(part1(EXAMPLE_INPUT2)).toEqual(6);
  });

  test("part2", async () => {
    const input = await getInput("day8");
    const result = part2(input);
    expect(result).toBeGreaterThan(1516721);
    expect(result).toEqual(18215611419223);
  });

  test("part2 with example input", () => {
    expect(part2(EXAMPLE_INPUT3)).toEqual(6);
  });
});

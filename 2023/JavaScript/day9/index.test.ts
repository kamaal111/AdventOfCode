import { test, expect, describe, beforeAll } from "bun:test";

import {
  part1,
  part2,
  makeTreeForHistoryLine,
  parseInput,
  getPredictedHistoryOnTheLeft,
} from ".";
import { getInput } from "../utils/getInput";

const EXAMPLE_INPUT = `0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45`;

describe("day9", () => {
  let input: string;

  beforeAll(async () => {
    input = await getInput("day9");
  });

  test("part1 with example input", () => {
    expect(part1(EXAMPLE_INPUT)).toEqual(114);
  });

  test("part1", async () => {
    const result = part1(input);
    expect(result).toBeGreaterThan(831_158_931);
    expect(result).toBeLessThan(1_806_616_102);
    expect(result).toEqual(1_806_615_041);
  });

  test("historyLine", () => {
    const historyLine = parseInput("10 13 16 21 30 45");
    expect(historyLine.length).toEqual(1);
  });

  test("makeTreeForHistoryLine", () => {
    const tree = parseInput("10 13 16 21 30 45")[0];

    expect(tree.length).toEqual(2);
    expect(tree[0].value).toEqual(0);
    expect(tree[0].left?.value).toEqual(2);
    expect(tree[0].left?.left?.value).toEqual(0);
    expect(tree[0].left?.left?.left?.value).toEqual(3);
    expect(tree[0].left?.left?.left?.left?.value).toEqual(10);
  });

  test("part2", async () => {
    const result = part2(input);
    expect(result).toEqual(1211);
  });

  test("part2 with example input", () => {
    expect(part2(EXAMPLE_INPUT)).toEqual(2);
  });

  test("getPredictedHistoryOnTheLeft", () => {
    const historyLine = parseInput("10 13 16 21 30 45");

    const result = getPredictedHistoryOnTheLeft(
      makeTreeForHistoryLine(historyLine[0]),
    );

    expect(result).toEqual(5);
  });
});

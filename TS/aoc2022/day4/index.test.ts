import { describe, expect, test } from '@jest/globals';
import fs from 'fs/promises';
import { part1, part2 } from '.';

const EXAMPLE_INPUT = `2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8`;

describe('day1', () => {
  test('part1', async () => {
    const input = await getInput();
    expect(part1(input)).toBe(560);
  });

  test('part1 with example input', () => {
    expect(part1(EXAMPLE_INPUT)).toBe(2);
  });

  test('part2', async () => {
    const input = await getInput();
    expect(part2(input)).toBe(839);
  });

  test('part2 with example input', () => {
    expect(part2(EXAMPLE_INPUT)).toBe(4);
  });
});

let _input: string | null = null;

async function getInput() {
  if (_input != null) {
    return _input;
  }

  const input = await fs.readFile(
    '../../Swift/AOC2022/Sources/AOC2022/Inputs/day4.txt',
    'utf-8',
  );
  _input = input.toString();

  return _input;
}

import { describe, expect, test } from '@jest/globals';
import { part1, part2 } from '.';
import { getInput } from '../utilities/getInput';

const EXAMPLE_INPUT = `1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
`;

describe('day1', () => {
  test('part1', async () => {
    const input = await getInput('day1');
    expect(part1(input)).toBe(67450);
  });

  test('part1 with example input', () => {
    expect(part1(EXAMPLE_INPUT)).toBe(24000);
  });

  test('part2', async () => {
    const input = await getInput('day1');
    expect(part2(input)).toBe(199357);
  });

  test('part2 with example input', () => {
    expect(part2(EXAMPLE_INPUT)).toBe(45000);
  });
});

import { part1, part2 } from '.';
import { getInput } from '../utilities/getInput';

const EXAMPLE_INPUT = `[1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]`;

describe('day13', () => {
  test('part1', async () => {
    const input = await getInput('day13');
    expect(part1(input)).toBe(0);
  });

  test('part1 with example input', () => {
    expect(part1(EXAMPLE_INPUT)).toBe(0);
  });

  test('part2', async () => {
    const input = await getInput('day13');
    expect(part2(input)).toBe(0);
  });

  test('part2 with example input', () => {
    expect(part2(EXAMPLE_INPUT)).toBe(0);
  });
});

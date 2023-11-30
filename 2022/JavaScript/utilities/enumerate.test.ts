import { describe, expect, test } from '@jest/globals';
import { enumerate } from './enumerate';

describe('enumerate', () => {
  test('enumerates', async () => {
    const array = [0, 1, 2, 3, 4, 5, 6];
    expect(enumerate(array)).toEqual([
      { index: 0, element: 0 },
      { index: 1, element: 1 },
      { index: 2, element: 2 },
      { index: 3, element: 3 },
      { index: 4, element: 4 },
      { index: 5, element: 5 },
      { index: 6, element: 6 },
    ]);
  });
});

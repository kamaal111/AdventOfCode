import { describe, expect, test } from '@jest/globals';
import { striding } from './striding';

describe('striding', () => {
  test('strides', async () => {
    const array = [0, 1, 2, 3, 4, 5, 6];
    expect(striding(array, 3)).toEqual([0, 3, 6]);
    expect(striding(array, 2)).toEqual([0, 2, 4, 6]);
    expect(striding(array, 1)).toEqual(array);
  });
});

export function compactMap<T, R>(
  array: T[],
  predicate: (value: T) => R | null | undefined,
) {
  const newArray: R[] = [];
  array.forEach((item) => {
    const transformedItem = predicate(item);
    if (transformedItem != null) {
      newArray.push(transformedItem);
    }
  });
  return newArray;
}

export function zip<T1, T2>(array1: T1[], array2: T2[]): Array<[T1, T2]> {
  if (array1.length >= array2.length) {
    return array2.map((item, index) => [array1[index], item]);
  }

  return array1.map((item, index) => [item, array2[index]]);
}

export function uniques<T>(array: T[]): T[] {
  return [...new Set(array)];
}

export function enumerate<T>(array: T[]): Array<{ index: number; element: T }> {
  return array.map((element, index) => ({ index, element }));
}

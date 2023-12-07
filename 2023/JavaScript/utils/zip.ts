export function zip<T1, T2>(array1: T1[], array2: T2[]): Array<[T1, T2]> {
  if (array1.length >= array2.length) {
    return array2.map((item, index) => [array1[index], item]);
  }

  return array1.map((item, index) => [item, array2[index]]);
}

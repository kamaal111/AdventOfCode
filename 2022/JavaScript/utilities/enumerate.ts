export function enumerate<T>(array: T[]): { index: number; element: T }[] {
  return array.map((element, index) => ({ index, element }));
}

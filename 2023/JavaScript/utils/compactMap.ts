export function compactMap<T, R>(
  array: T[],
  predicate: (value: T) => R | null | undefined,
) {
  const newArray: R[] = [];
  for (const item of array) {
    const transformedItem = predicate(item);
    if (transformedItem != null) {
      newArray.push(transformedItem);
    }
  }
  return newArray;
}

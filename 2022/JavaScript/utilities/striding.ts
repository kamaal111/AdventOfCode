export function striding<T>(array: T[], stride: number): T[] {
  const length = array.length;
  const amountOfItems = Math.ceil(length / stride);
  let newArray: T[] = [];
  for (let index = 0; index < amountOfItems; index += 1) {
    const element = array[index * stride];
    newArray.push(element);
  }
  return newArray;
}

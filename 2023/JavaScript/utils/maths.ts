function greatestCommonDivisor(a: number, b: number) {
  return b === 0 ? a : greatestCommonDivisor(b, a % b);
}

export function leastCommonMultiple(a: number, b: number) {
  return (a * b) / greatestCommonDivisor(a, b);
}

export function min(array: number[]) {
  return Math.min(...array);
}

export function sum(array: number[]) {
  return array.reduce((sum, item) => sum + item, 0);
}

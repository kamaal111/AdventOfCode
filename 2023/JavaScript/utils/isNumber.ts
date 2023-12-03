function isNumber(value?: string): boolean {
  if (value == null) return false;
  return !Number.isNaN(Number(value));
}

export default isNumber;

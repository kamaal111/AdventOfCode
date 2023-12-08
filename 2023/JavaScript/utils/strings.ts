export function isNumber(value?: string): boolean {
  if (value == null || value.length === 0) return false;
  return !Number.isNaN(Number(value));
}

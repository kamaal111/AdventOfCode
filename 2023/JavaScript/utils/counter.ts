export class Counter<T extends string | number | symbol> {
  private readonly container: Partial<Record<T, number>>;

  constructor(items: T[]) {
    const container: Partial<Record<T, number>> = {};
    for (const value of items) {
      container[value] = (container[value] ?? 0) + 1;
    }
    this.container = container;
  }

  get values(): number[] {
    return Object.values(this.container);
  }

  get = (key: T) => {
    return this.container[key] ?? 0;
  };
}

export interface MatrixElement<T> {
  value: T;
  row: number;
  column: number;
}

class Matrix<T> {
  elements: Array<Array<MatrixElement<T>>>;

  constructor(elements: Array<Array<MatrixElement<T>>>) {
    this.elements = elements;
  }

  getNeighbors = (
    row: number,
    column: number,
    maxDistance: number = 1,
  ): Array<MatrixElement<T>> => {
    if (maxDistance < 1) return [];

    const neighbors: Array<MatrixElement<T>> = [];
    for (let i = -1; i <= maxDistance; i += 1) {
      for (let j = -1; j <= maxDistance; j += 1) {
        if (i === 0 && j === 0) continue;

        const cell = this.get(row + i, column + j);
        if (cell?.value == null) continue;

        neighbors.push(cell);
      }
    }
    return neighbors;
  };

  get = (row: number, column: number): MatrixElement<T> | undefined => {
    return this.elements[row]?.[column];
  };

  static fromStringCharacters(lines: string[]): Matrix<string> {
    const cells: Array<Array<MatrixElement<string>>> = [];
    for (let rowIndex = 0; rowIndex < lines.length; rowIndex += 1) {
      const row: Array<MatrixElement<string>> = [];
      for (
        let columnIndex = 0;
        columnIndex < lines[rowIndex].length;
        columnIndex += 1
      ) {
        const value = lines[rowIndex][columnIndex];
        row.push({ value, row: rowIndex, column: columnIndex });
      }
      cells.push(row);
    }
    return new Matrix(cells);
  }
}

export default Matrix;

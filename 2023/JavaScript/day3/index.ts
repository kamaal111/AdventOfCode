import Matrix, { type MatrixElement } from "../models/matrix";
import { compactMap } from "../utils/arrays";
import { isNumber } from "../utils/strings";
import { sum } from "../utils/maths";

export function part1(input: string): number {
  const engineSchematic = Matrix.fromStringCharacters(input.split("\n"));
  const partNumbers = engineSchematic.elements
    .flatMap((elements) => {
      const { groupedNumbers, foundPartNumbers } = elements.reduce<{
        groupedNumbers: Array<MatrixElement<string>>;
        foundPartNumbers: Array<Array<MatrixElement<string>>>;
      }>(
        (acc, element) => {
          if (isNumber(element.value)) {
            return {
              ...acc,
              groupedNumbers: [...acc.groupedNumbers, element],
            };
          }

          if (!checkIfHasAdjacentSymbol(acc.groupedNumbers, engineSchematic)) {
            return { ...acc, groupedNumbers: [] };
          }

          return {
            foundPartNumbers: [...acc.foundPartNumbers, acc.groupedNumbers],
            groupedNumbers: [],
          };
        },
        { groupedNumbers: [], foundPartNumbers: [] },
      );

      if (checkIfHasAdjacentSymbol(groupedNumbers, engineSchematic)) {
        foundPartNumbers.push(groupedNumbers);
      }

      return foundPartNumbers;
    })
    .map((items) => Number(items.map(({ value }) => value).join("")));
  return sum(partNumbers);
}

export function part2(input: string): number {
  const engineSchematic = Matrix.fromStringCharacters(input.split("\n"));
  const products = compactMap(engineSchematic.elements.flat(), (cell) => {
    if (cell?.value !== "*") return null;

    const gearItems = findGearItems(cell, engineSchematic);
    if (gearItems.length !== 2) return null;

    const gearItemNumbers = gearItems.map((items) => {
      return Number(items.map(({ value }) => value).join(""));
    });
    return gearItemNumbers[0] * gearItemNumbers[1];
  });
  return sum(products);
}

function checkIfHasAdjacentSymbol(
  groupedNumbers: Array<MatrixElement<string>>,
  engineSchematic: Matrix<string>,
): boolean {
  return groupedNumbers.some((number) => {
    return engineSchematic
      .getNeighbors(number.row, number.column)
      .some((neighbor) => {
        return neighbor.value !== "." && !isNumber(neighbor.value);
      });
  });
}

function cellIsIncluded(
  cell: MatrixElement<string>,
  cells: Array<MatrixElement<string>>,
): boolean {
  return cells.some(({ column, row }) => {
    return column === cell.column && row === cell.row;
  });
}

function groupNumbers(
  cell: MatrixElement<string>,
  engineSchematic: Matrix<string>,
): Array<MatrixElement<string>> {
  const leftCells: Array<MatrixElement<string>> = [];
  let currentCell: MatrixElement<string> | undefined = cell;
  while (isNumber(currentCell.value)) {
    leftCells.push(currentCell);

    const nextCell = engineSchematic.get(
      currentCell.row,
      currentCell.column - 1,
    );
    if (nextCell == null || !isNumber(nextCell.value)) break;
    currentCell = nextCell;
  }

  const items = leftCells.reverse();
  if (isNumber(currentCell?.value) && !cellIsIncluded(currentCell, items)) {
    items.push(currentCell);
  }

  currentCell = engineSchematic.get(cell.row, cell.column + 1);
  while (currentCell != null && isNumber(currentCell?.value)) {
    items.push(currentCell);
    const nextCell = engineSchematic.get(
      currentCell.row,
      currentCell.column + 1,
    );
    if (nextCell == null || !isNumber(nextCell.value)) break;
    currentCell = nextCell;
  }

  if (
    currentCell != null &&
    isNumber(currentCell.value) &&
    !cellIsIncluded(currentCell, items)
  ) {
    items.push(currentCell);
  }

  return items;
}

function findGearItems(
  gearSymbol: MatrixElement<string>,
  engineSchematic: Matrix<string>,
): Array<Array<MatrixElement<string>>> {
  return engineSchematic
    .getNeighbors(gearSymbol.row, gearSymbol.column)
    .reduce<Array<Array<MatrixElement<string>>>>((gearItems, cell) => {
      if (
        !isNumber(cell.value) ||
        gearItems.some((row) => cellIsIncluded(cell, row))
      ) {
        return gearItems;
      }

      return [...gearItems, groupNumbers(cell, engineSchematic)];
    }, []);
}

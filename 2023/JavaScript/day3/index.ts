interface Coordinates {
  x: number;
  y: number;
}

interface EngineSchematicCell {
  value: string;
  coordinates: Coordinates;
}

type EngineSchematic = EngineSchematicCell[][];

export function part1(input: string): number {
  const engineSchematic = parseEngineSchematic(input);
  const partNumbersValues: EngineSchematicCell[][] = [];
  for (const line of engineSchematic) {
    let groupedNumbers: EngineSchematicCell[] = [];
    for (const item of line) {
      if (isNumber(item.value)) {
        groupedNumbers.push({
          value: item.value,
          coordinates: item.coordinates,
        });
      } else {
        const hasAdjacentSymbol = checkIfHasAdjacentSymbol(
          groupedNumbers,
          engineSchematic,
        );
        if (hasAdjacentSymbol) {
          partNumbersValues.push(groupedNumbers);
        }

        groupedNumbers = [];
      }
    }

    if (groupedNumbers.length > 0) {
      const hasAdjacentSymbol = checkIfHasAdjacentSymbol(
        groupedNumbers,
        engineSchematic,
      );
      if (hasAdjacentSymbol) {
        partNumbersValues.push(groupedNumbers);
      }
    }
  }

  const partNumbers = partNumbersValues.map((items) =>
    Number(items.map(({ value }) => value).join("")),
  );
  return partNumbers.reduce((sum, number) => sum + number, 0);
}

export function part2(input: string): number {
  const engineSchematic = parseEngineSchematic(input);
  let sum = 0;
  for (let index = 0; index < engineSchematic.length; index += 1) {
    const line = engineSchematic[index];
    for (const item of line) {
      if (item.value === "*") {
        const gearItems = findGearItems(item, engineSchematic);
        if (gearItems.length !== 2) continue;

        const gearItemNumbers = gearItems.map((items) =>
          Number(items.map(({ value }) => value).join("")),
        );
        sum += gearItemNumbers[0] * gearItemNumbers[1];
      }
    }
  }

  return sum;
}

function groupNumbers(
  cell: EngineSchematicCell,
  engineSchematic: EngineSchematic,
): EngineSchematicCell[] {
  const leftCells: EngineSchematicCell[] = [];
  let currentCell = cell;
  while (isNumber(currentCell.value)) {
    if (!isNumber(currentCell.value)) break;

    leftCells.push(currentCell);
    const nextCell =
      engineSchematic[currentCell.coordinates.x]?.[
        currentCell.coordinates.y - 1
      ];
    if (nextCell == null) break;
    currentCell = nextCell;
  }

  const items: EngineSchematicCell[] = leftCells.reverse();
  if (isNumber(currentCell?.value)) {
    const currentCellIsInItems = items
      .map(({ coordinates }) => JSON.stringify(coordinates))
      .includes(JSON.stringify(currentCell.coordinates));
    if (!currentCellIsInItems) items.push(currentCell);
  }

  currentCell = engineSchematic[cell.coordinates.x][cell.coordinates.y + 1];
  if (!isNumber(currentCell?.value)) return items;

  while (isNumber(currentCell.value)) {
    if (!isNumber(currentCell.value)) break;

    items.push(currentCell);
    const nextCell =
      engineSchematic[currentCell.coordinates.x]?.[
        currentCell.coordinates.y + 1
      ];
    if (nextCell == null) break;
    currentCell = nextCell;
  }

  if (isNumber(currentCell?.value)) {
    const currentCellIsInItems = items
      .map(({ coordinates }) => JSON.stringify(coordinates))
      .includes(JSON.stringify(currentCell.coordinates));
    if (!currentCellIsInItems) items.push(currentCell);
  }

  return items;
}

function findGearItems(
  gearSymbol: EngineSchematicCell,
  engineSchematic: EngineSchematic,
): EngineSchematicCell[][] {
  const gearItems: EngineSchematicCell[][] = [];

  function wasAlreadyFound(cell: EngineSchematicCell): boolean {
    return gearItems
      .flatMap((item) =>
        item.map(({ coordinates }) => JSON.stringify(coordinates)),
      )
      .includes(JSON.stringify(cell.coordinates));
  }

  const { x, y } = gearSymbol.coordinates;
  for (let j = -1; j <= 1; j += 1) {
    for (let i = -1; i <= 1; i += 1) {
      const cell = engineSchematic[x + j]?.[y + i];

      if (
        cell?.value === null ||
        !isNumber(cell.value) ||
        wasAlreadyFound(cell)
      ) {
        continue;
      }

      const groupedNumbers = groupNumbers(cell, engineSchematic);
      gearItems.push(groupedNumbers);
    }
  }
  return gearItems;
}

function checkIfHasAdjacentSymbol(
  group: EngineSchematicCell[],
  engineSchematic: EngineSchematic,
): boolean {
  function itemIsASymbol(item?: EngineSchematicCell): boolean {
    if (item == null) return false;

    return item.value !== "." && !isNumber(item.value);
  }

  for (const item of group) {
    const { x, y } = item.coordinates;
    for (let j = -1; j <= 1; j += 1) {
      for (let i = -1; i <= 1; i += 1) {
        const cell = engineSchematic[x + j]?.[y + i];
        if (!itemIsASymbol(cell)) continue;
        return true;
      }
    }
  }
  return false;
}

function parseEngineSchematic(input: string): EngineSchematic {
  const engineSchematic: EngineSchematic = [];
  const lines = input.split("\n");
  for (let x = 0; x < lines.length; x += 1) {
    const line = lines[x].split("");
    const lineItems: EngineSchematicCell[] = [];
    for (let y = 0; y < line.length; y += 1) {
      const item = line[y];
      lineItems.push({ value: item, coordinates: { x, y } });
    }
    engineSchematic.push(lineItems);
  }

  return engineSchematic;
}

function isNumber(value?: string): boolean {
  if (value == null) return false;
  return !Number.isNaN(Number(value));
}

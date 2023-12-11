import Matrix, { type MatrixElement } from "../models/matrix";

const DIRECTIONS = ["up", "down", "left", "right"] as const;

type TileTypes = "|" | "-" | "L" | "J" | "7" | "F" | "." | "S";
type Directions = (typeof DIRECTIONS)[number];

export function part1(input: string) {
  const maze = parseInput(input);
  const start = maze.elements.flat().find((tile) => tile.value === "S")!;
  const { iterations } = travelThroughMaze(start, maze)!;
  return iterations / 2;
}

export function part2(input: string) {
  const maze = parseInput(input);
  const tiles = maze.elements.flat();
  const start = tiles.find((tile) => tile.value === "S")!;
  const path = travelThroughMaze(start, maze)!.path.map((item) => {
    const [row, column] = item.split("-");
    return { row: Number(row), column: Number(column) };
  });
  // Loop items
  tiles.filter((tile) => {
    if (tile.value === ".") return false;
    for (const { row, column } of path) {
      if (tile.row === row && tile.column === column) {
        return true;
      }
    }
    return false;
  });
  return 0;
}

function travelThroughMaze(
  tile: MatrixElement<TileTypes>,
  maze: Matrix<TileTypes>,
) {
  for (let direction of DIRECTIONS) {
    const elementKey = makeElementHashKey(tile);
    const traveling = [elementKey];
    let currentTile = tile;
    let iterations = 0;
    while (true) {
      const next = getNextTile(currentTile, maze, direction);
      // No connection
      if (next?.nextTile == null) break;

      const nextKey = makeElementHashKey(next.nextTile);

      iterations += 1;
      if (traveling.includes(nextKey)) return { iterations, path: traveling };

      traveling.push(nextKey);
      currentTile = next.nextTile;
      direction = next.direction;
    }
  }

  throw new Error("No loop found");
}

function getNextTile(
  tile: MatrixElement<TileTypes>,
  maze: Matrix<TileTypes>,
  direction: Directions,
):
  | { direction: Directions; nextTile: MatrixElement<TileTypes> | undefined }
  | undefined {
  if (tile.value === "S") {
    if (direction === "down") {
      return { nextTile: maze.get(tile.row + 1, tile.column), direction };
    }
    if (direction === "up") {
      return { nextTile: maze.get(tile.row - 1, tile.column), direction };
    }
    if (direction === "left") {
      return { nextTile: maze.get(tile.row, tile.column - 1), direction };
    }
    return { nextTile: maze.get(tile.row, tile.column + 1), direction };
  }

  if (tile.value === "F") {
    if (direction === "up") {
      // Coming from below and going right
      return {
        nextTile: maze.get(tile.row, tile.column + 1),
        direction: "right",
      };
    } else if (direction === "left") {
      // Coming from right and going down
      return {
        nextTile: maze.get(tile.row + 1, tile.column),
        direction: "down",
      };
    }
  }

  if (tile.value === "-") {
    if (direction === "right") {
      // Coming from left and going right
      return {
        nextTile: maze.get(tile.row, tile.column + 1),
        direction: "right",
      };
    } else if (direction === "left") {
      // Coming from right and going left
      return { nextTile: maze.get(tile.row, tile.column - 1), direction };
    }
  }

  if (tile.value === "7") {
    if (direction === "right") {
      // Coming from left and going down
      return {
        nextTile: maze.get(tile.row + 1, tile.column),
        direction: "down",
      };
    } else if (direction === "up") {
      // Coming from below and going left
      return {
        nextTile: maze.get(tile.row, tile.column - 1),
        direction: "left",
      };
    }
  }

  if (tile.value === "|") {
    if (direction === "down") {
      // Coming from up and going down
      return {
        nextTile: maze.get(tile.row + 1, tile.column),
        direction: "down",
      };
    } else if (direction === "up") {
      // Coming from down and going up
      return { nextTile: maze.get(tile.row - 1, tile.column), direction };
    }
  }

  if (tile.value === "J") {
    if (direction === "down") {
      // Coming from up and going left
      return {
        nextTile: maze.get(tile.row, tile.column - 1),
        direction: "left",
      };
    } else if (direction === "right") {
      // Coming from left and going up
      return { nextTile: maze.get(tile.row - 1, tile.column), direction: "up" };
    }
  }

  if (tile.value === "L") {
    if (direction === "down") {
      // Coming from up and going right
      return {
        nextTile: maze.get(tile.row, tile.column + 1),
        direction: "right",
      };
    } else if (direction === "left") {
      // Coming from right and going up
      return { nextTile: maze.get(tile.row - 1, tile.column), direction: "up" };
    }
  }
}

function makeElementHashKey(element: MatrixElement<TileTypes>) {
  return `${element.row}-${element.column}-${element.value}`;
}

function parseInput(input: string) {
  return Matrix.fromStringCharacters(
    input.split("\n").filter((line) => line.length > 0),
  ) as Matrix<TileTypes>;
}

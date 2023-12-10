import Matrix, { type MatrixElement } from "../models/matrix";

type TileTypes = "|" | "-" | "L" | "J" | "7" | "F" | ".";
type Directions = "up" | "down" | "left" | "right";

export function part1(input: string) {
  const maze = parseInput(input);
  const iterations: number[] = [];
  for (const element of maze.elements.flat()) {
    const journey = travelThroughMaze(element, maze);
    if (journey == null) continue;

    iterations.push(journey.iterations);
  }
  return Math.max(...iterations) / 2;
}

export function part2(input: string) {
  return 0;
}

function travelThroughMaze(
  tile: MatrixElement<TileTypes>,
  maze: Matrix<TileTypes>,
) {
  if (tile.value === ".") return null;

  const elementKey = makeElementHashKey(tile);
  const traveling = [elementKey];
  console.log("traveling[0]", traveling[0]);
  let currentTile = tile;
  let direction: Directions | undefined;
  let iterations = 0;
  while (true) {
    const next = getNextTile(currentTile, maze, direction);
    // No connection
    if (next?.nextTile == null) break;

    const nextKey = makeElementHashKey(next.nextTile);

    iterations += 1;
    if (traveling.includes(nextKey)) {
      return { iterations, path: traveling };
    }
    traveling.push(nextKey);
    currentTile = next.nextTile;
    direction = next.direction;
  }

  return null;
}

function getNextTile(
  tile: MatrixElement<TileTypes>,
  maze: Matrix<TileTypes>,
  direction: Directions | undefined,
):
  | { direction: Directions; nextTile: MatrixElement<TileTypes> | undefined }
  | undefined {
  if (tile.value === "F") {
    if (direction == null || direction === "up") {
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
    if (direction == null || direction === "right") {
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
    if (direction == null || direction === "right") {
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
    if (direction == null || direction === "down") {
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
    if (direction == null || direction === "down") {
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
    if (direction == null || direction === "down") {
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

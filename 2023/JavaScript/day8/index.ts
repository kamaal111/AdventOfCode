import { uniques } from "../utils/arrays";
import { leastCommonMultiple } from "../utils/maths";

export function part1(input: string) {
  const { instructions, coordinates } = parseInput(input);
  let steps = 0;
  let currentCoordinate = "AAA";
  const instructionsSize = instructions.length;
  while (currentCoordinate !== "ZZZ") {
    const instruction = instructions[steps % instructionsSize];
    currentCoordinate = coordinates[currentCoordinate][instruction];
    steps += 1;
  }
  return steps;
}

export function part2(input: string) {
  const { instructions, coordinates } = parseInput(input);
  let steps = 0;
  const currentCoordinates = Object.keys(coordinates)
    .filter((key) => key.endsWith("A"))
    .reduce<Record<string, { steps: number; value: string }>>(
      (acc, current) => {
        return { ...acc, [current]: { value: current, steps: 0 } };
      },
      {},
    );
  const instructionsSize = instructions.length;
  while (
    Object.values(currentCoordinates).some(
      (coordinate) => !coordinate.value.endsWith("Z"),
    )
  ) {
    const instruction = instructions[steps % instructionsSize];
    steps += 1;
    Object.entries(currentCoordinates)
      .filter(([, value]) => !value.value.endsWith("Z"))
      .forEach(([key, { value }]) => {
        currentCoordinates[key] = {
          value: coordinates[value][instruction],
          steps,
        };
      });
  }

  const [firstSteps, ...coordinateSteps] = uniques(
    Object.values(currentCoordinates).map((value) => value.steps),
  );
  return coordinateSteps.reduce(leastCommonMultiple, firstSteps);
}

function parseInput(input: string) {
  const [rawInstructions, ...rest] = input.split("\n");
  const instructions = rawInstructions.split("").map((instruction) => {
    if (instruction === "L") return "left";
    return "right";
  });
  const coordinates = rest
    .slice(1)
    .reduce<Record<string, Record<(typeof instructions)[number], string>>>(
      (coordinates, value) => {
        const [key, nextCoordinates] = value.split(" = ");
        const [left, right] = nextCoordinates
          .split(", ")
          .map((coordinate) => coordinate.replace("(", "").replace(")", ""));
        return { ...coordinates, [key]: { left, right } };
      },
      {},
    );

  return { instructions, coordinates };
}

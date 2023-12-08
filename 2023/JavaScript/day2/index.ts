import { sum } from "../utils/maths";

interface CubeSubset {
  red: number;
  blue: number;
  green: number;
}

const possibleConfiguration = { red: 12, green: 13, blue: 14 };

export function part1(input: string): number {
  const possibleIDs = Object.entries(makeSets(input))
    .filter(([_, cubeSubsets]) => {
      return cubeSubsets.every((cubeSubset) => {
        return Object.entries(cubeSubset).every(
          ([key, value]) => value <= possibleConfiguration[key],
        );
      });
    })
    .map(([id]) => Number(id));
  return sum(possibleIDs);
}

export function part2(input: string): number {
  const products = Object.values(makeSets(input)).map((cubeSet) => {
    const { red, green, blue } = cubeSet.reduce(
      (highestPossibleSet, cubeSubsets) => {
        const newHighestPossibleSet = highestPossibleSet;
        for (const [key, value] of Object.entries(newHighestPossibleSet)) {
          const cubeSubsetValue = cubeSubsets[key];
          if (cubeSubsetValue > value) {
            newHighestPossibleSet[key] = cubeSubsetValue;
          }
        }
        return newHighestPossibleSet;
      },
      { red: 0, green: 0, blue: 0 },
    );
    return red * green * blue;
  });
  return sum(products);
}

function makeSets(input: string): Record<string, CubeSubset[]> {
  return input.split("\n").reduce((sets, line, index) => {
    const subsets = line
      .split("Game ")
      .at(-1)
      ?.split(": ")
      .at(1)
      ?.split("; ")
      .map((subsetLine) => {
        return subsetLine
          .split(", ")
          .map((cube) => cube.split(" "))
          .reduce(
            (subset, [amount, color]) => {
              return { ...subset, [color]: Number(amount) };
            },
            { red: 0, green: 0, blue: 0 },
          );
      });
    if (subsets == null) return sets;

    return { ...sets, [String(index + 1)]: subsets };
  }, {});
}

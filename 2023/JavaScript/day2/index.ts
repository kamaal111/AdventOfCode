interface CubeSubset {
  red: number;
  blue: number;
  green: number;
}

const possibleConfiguration = { red: 12, green: 13, blue: 14 };

export function part1(input: string): number {
  let sum = 0;
  const cubeSets = makeSets(input);
  for (const [id, cubeSubesets] of Object.entries(cubeSets)) {
    const cubeSubsetsConfigurationsArePossible = cubeSubesets.every(
      (cubeSubeset) => {
        return Object.entries(cubeSubeset).every(
          ([key, value]) => value <= possibleConfiguration[key],
        );
      },
    );
    if (cubeSubsetsConfigurationsArePossible) {
      sum += Number(id);
    }
  }

  return sum;
}

export function part2(input: string): number {
  let sum = 0;
  for (const [, cubeSet] of Object.entries(makeSets(input))) {
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

    sum += red * green * blue;
  }
  return sum;
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

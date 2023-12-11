import Matrix, { type MatrixElement } from "../models/matrix";
import { sum } from "../utils/maths";

type Cosmos = "." | "#";

interface GalaxyPair {
  first: MatrixElement<Cosmos>;
  last: MatrixElement<Cosmos>;
}

export function part1(input: string) {
  const cosmos = parseInput(input);
  return sum(makePairs(cosmos).map(calculateLengthBetweenGalaxies));
}

export function part2(input: string) {
  return 0;
}

function calculateLengthBetweenGalaxies(pair: GalaxyPair) {
  return 0;
}

function makePairs(cosmos: Matrix<Cosmos>): GalaxyPair[] {
  const galaxies = cosmos.elements.flat().filter((item) => item.value === "#");
  const pairs = new Set<string>();
  for (let x = 0; x < galaxies.length - 1; x += 1) {
    for (let y = 1; y < galaxies.length; y += 1) {
      if (x === y) continue;

      const first = Math.min(x, y);
      const last = Math.max(x, y);
      pairs.add(`${first}-${last}`);
    }
  }
  return [...pairs].map((pairsKey) => {
    const [first, last] = pairsKey.split("-").map((index) => Number(index));
    return { first: galaxies[first], last: galaxies[last] };
  });
}

function parseInput(input: string) {
  return Matrix.fromStringCharacters(input.split("\n") as Cosmos[]);
}

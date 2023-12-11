import Matrix from "../models/matrix";

type Cosmos = "." | "#";

export function part1(input: string) {
  const cosmos = parseInput(input);
  makePairs(cosmos);

  return 0;
}

export function part2(input: string) {
  return 0;
}

function makePairs(cosmos: Matrix<Cosmos>) {
  const galaxies = cosmos.elements.flat().filter((item) => item.value === "#");
  for (let index = 0; index < galaxies.length; index += 1) {
    const galaxy = galaxies[index];
    console.log("galaxy", galaxy);
  }
  // const pairs: Array<MatrixElement<Cosmos>> = [];
}

function parseInput(input: string) {
  return Matrix.fromStringCharacters(input.split("\n") as Cosmos[]);
}

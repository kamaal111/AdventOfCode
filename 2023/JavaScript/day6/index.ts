import isNumber from "../utils/isNumber";

export function part1(input: string) {
  const { times, distances } = parseInput(input);
  return times
    .map((time, index) => calculateWaysToWin(time, distances[index]))
    .reduce((acc, value) => acc * value, 1);
}

// Brute force in 48 seconds
export function part2(input: string) {
  const { times, distances } = parseInput(input);
  const time = Number(times.join(""));
  const distance = Number(distances.join(""));
  return calculateWaysToWin(time, distance);
}

function calculateWaysToWin(time: number, distance: number) {
  const minimumHoldDownTimeToWin = getMinimumHoldDownTimeToWin(time, distance);
  const maximumHoldDownTimeToWin = getMaximumHoldDownTimeToWin(
    minimumHoldDownTimeToWin,
    time,
    distance,
  );
  return maximumHoldDownTimeToWin - minimumHoldDownTimeToWin + 1;
}

function getMaximumHoldDownTimeToWin(
  minimumTime: number,
  time: number,
  distance: number,
) {
  for (let index = time; index > minimumTime; index -= 1) {
    const distanceTraveled = calculateDistanceTraveled(time, index);
    console.log(`going from ${index} to ${minimumTime}`);
    if (distanceTraveled > distance) return index;
  }

  throw new Error("No maximum found");
}

function getMinimumHoldDownTimeToWin(time: number, distance: number) {
  for (let index = 1; index < time; index += 1) {
    const distanceTraveled = calculateDistanceTraveled(time, index);
    console.log(`going from ${index} to ${time}`);
    if (distanceTraveled > distance) return index;
  }

  throw new Error("No minimum found");
}

function calculateDistanceTraveled(totalTime: number, holdDown: number) {
  return holdDown * (totalTime - holdDown);
}

function parseInput(input: string) {
  const [times, distances] = input.split("\n").map((line) =>
    line
      .split(":")[1]
      .split(" ")
      .filter((value) => isNumber(value))
      .map((value) => Number(value)),
  );
  return { times, distances };
}

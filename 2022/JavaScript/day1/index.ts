export function part1(input: string): number {
  let currentStreak = 0;
  let highestCalories = 0;
  for (const line of input.split('\n')) {
    if (line === '') {
      if (currentStreak > highestCalories) {
        highestCalories = currentStreak;
      }
      currentStreak = 0;
    } else {
      currentStreak += Number(line);
    }
  }

  if (currentStreak != 0 && currentStreak > highestCalories) {
    highestCalories = currentStreak;
  }

  return highestCalories;
}

export function part2(input: string): number {
  let currentStreak = 0;
  let highestCalories = [0, 0, 0];
  for (const line of input.split('\n')) {
    if (line === '') {
      if (currentStreak > highestCalories[2]) {
        highestCalories = newHighestCalories(highestCalories, currentStreak);
      }
      currentStreak = 0;
    } else {
      currentStreak += Number(line);
    }
  }

  if (currentStreak != 0 && currentStreak > highestCalories[2]) {
    highestCalories = newHighestCalories(highestCalories, currentStreak);
  }

  return highestCalories.reduce((acc, calories) => acc + calories, 0);
}

function newHighestCalories(
  previousHighestCalories: number[],
  currentStreak: number,
) {
  return previousHighestCalories
    .concat([currentStreak])
    .sort((a, b) => {
      if (a < b) {
        return 1;
      }

      if (a > b) {
        return -1;
      }

      return 0;
    })
    .slice(0, -1);
}

import isNumber from "../utils/isNumber";
import { sum } from "../utils/sum";

export function part1(input: string): number {
  const points = parseGames(input).map((game) => {
    const { winningNumbers, myNumbers } = game.numbers;
    const points = myNumbers
      .filter((number) => winningNumbers.includes(number))
      .reduce((points, _doubles) => {
        if (points === 0) return 1;
        return points * 2;
      }, 0);
    return points;
  });
  return sum(points);
}

export function part2(input: string): number {
  const collectedCards = parseGames(input).reduce<Record<string, number>>(
    (collectedCards, game) => {
      const newCollectedCards = { ...collectedCards };
      if (newCollectedCards[game.game] == null) {
        newCollectedCards[game.game] = 1;
      } else {
        newCollectedCards[game.game] += 1;
      }

      const { winningNumbers, myNumbers } = game.numbers;
      const tries = newCollectedCards[game.game];
      myNumbers
        .filter((number) => winningNumbers.includes(number))
        .forEach((_, index) => {
          const cardWon = index + 1 + Number(game.game);
          if (newCollectedCards[String(cardWon)] == null) {
            newCollectedCards[String(cardWon)] = tries;
          } else {
            newCollectedCards[String(cardWon)] += tries;
          }
        });
      return newCollectedCards;
    },
    {},
  );
  return sum(Object.values(collectedCards));
}

function parseGames(input: string): Array<{
  game: string;
  numbers: {
    winningNumbers: number[];
    myNumbers: number[];
  };
}> {
  return input.split("\n").map((line, index) => {
    const [winningNumbers, myNumbers] = line
      .split(": ")[1]
      .split(" | ")
      .map((numbers) => {
        return numbers
          .split(" ")
          .filter((number) => isNumber(number))
          .map((number) => Number(number));
      });
    return { game: String(index + 1), numbers: { winningNumbers, myNumbers } };
  });
}

import { Counter } from "../utils/counter";
import { zip } from "../utils/arrays";

const CARDS_VALUES = [
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "T",
  "J",
  "Q",
  "K",
  "A",
];
const CARD_VALUES_WITH_JOKER = [
  "J",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "T",
  "Q",
  "K",
  "A",
];

const CARDS_TYPES = {
  FIVE_OF_A_KIND: 1,
  FOUR_OF_A_KIND: 2,
  FULL_HOUSE: 3,
  THREE_OF_A_KIND: 4,
  TWO_PAIR: 5,
  ONE_PAIR: 6,
  HIGH_CARD: 7,
} as const;

type CardType = (typeof CARDS_TYPES)[keyof typeof CARDS_TYPES];

export function part1(input: string) {
  return countWinnings(sortHands(parseInput(input)).map(({ bid }) => bid));
}

export function part2(input: string) {
  return countWinnings(
    sortHands(parseInput(input), true).map(({ bid }) => bid),
  );
}

function countWinnings(bids: number[]) {
  return bids.reduce((winnings, bid, index) => {
    return winnings + bid * (index + 1);
  }, 0);
}

export function typeHand(hand: string[], withJokers: boolean): CardType {
  const cardOccurrences = new Counter(hand);
  const occurrences = cardOccurrences.values;
  if (occurrences.length === 1) return CARDS_TYPES.FIVE_OF_A_KIND;
  const amountOfJokers = cardOccurrences.get("J");
  if (withJokers && amountOfJokers > 0) {
    return typeHandWithJoker(occurrences, amountOfJokers);
  }

  if (occurrences.length === 2) {
    if (occurrences.includes(4)) return CARDS_TYPES.FOUR_OF_A_KIND;
    return CARDS_TYPES.FULL_HOUSE;
  }
  if (occurrences.length === 3) {
    if (occurrences.includes(3)) return CARDS_TYPES.THREE_OF_A_KIND;
    if (occurrences.includes(2)) return CARDS_TYPES.TWO_PAIR;
  }

  if (occurrences.length === 4) return CARDS_TYPES.ONE_PAIR;
  return CARDS_TYPES.HIGH_CARD;
}

function typeHandWithJoker(occurrences: number[], jokers: number): CardType {
  if (occurrences.length === 2) {
    if (occurrences.includes(4)) return CARDS_TYPES.FIVE_OF_A_KIND;
    if (jokers === 1) return CARDS_TYPES.FOUR_OF_A_KIND;
    if (jokers > 1) return CARDS_TYPES.FIVE_OF_A_KIND;
    return CARDS_TYPES.FULL_HOUSE;
  }

  if (occurrences.length === 3) {
    if (occurrences.includes(3)) return CARDS_TYPES.FOUR_OF_A_KIND;
    if (occurrences.includes(2)) {
      if (jokers === 1) return CARDS_TYPES.FULL_HOUSE;
      return CARDS_TYPES.FOUR_OF_A_KIND;
    }
  }

  if (occurrences.length === 4) return CARDS_TYPES.THREE_OF_A_KIND;
  return CARDS_TYPES.ONE_PAIR;
}

function sortHands(
  hands: Array<{
    hand: string[];
    bid: number;
  }>,
  withJokers: boolean = false,
) {
  const values = (withJokers ? CARD_VALUES_WITH_JOKER : CARDS_VALUES).reduce<
    Record<string, number>
  >((mapping, card, index) => {
    return { ...mapping, [card]: index };
  }, {});

  return hands
    .map(({ hand, bid }) => {
      const score = hand.map((card) => values[card]);
      const type = typeHand(hand, withJokers);
      return { score, type, bid };
    })
    .toSorted((a, b) => {
      if (a.type > b.type) return -1;
      if (a.type < b.type) return 1;
      const [aScore, bScore] = zip(a.score, b.score).find(([a, b]) => a !== b)!;
      if (aScore > bScore) return 1;
      if (aScore < bScore) return -1;
      return 0;
    });
}

function parseInput(input: string) {
  return input.split("\n").map((value) => {
    const [hand, bid] = value.split(" ");
    return { hand: hand.split(""), bid: Number(bid) };
  });
}

const CARDS = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"];
const CARDS_VALUES: Record<string, number> = CARDS.reduce(
  (mapping, card, index) => {
    return { ...mapping, [card]: index };
  },
  {},
);

export const CARDS_TYPES = {
  FIVE_OF_A_KIND: 0,
  FOUR_OF_A_KIND: 1,
  FULL_HOUSE: 2,
  THREE_OF_A_KIND: 3,
  TWO_PAIR: 4,
  ONE_PAIR: 5,
  HIGH_CARD: 6,
} as const;

export function part1(input: string) {
  return countWinnings(sortHands(parseInput(input)));
}

export function part2(input: string) {
  return countWinnings(sortHands(parseInput(input), true));
}

function countWinnings(
  hands: Array<{
    type: number;
    hand: string[];
    bid: number;
    score: number[];
  }>,
) {
  return hands.reduce((winnings, hand, index) => {
    return winnings + hand.bid * (index + 1);
  }, 0);
}

// Five of a kind, where all five cards have the same label: AAAAA
// Four of a kind, where four cards have the same label and one card has a different label: AA8AA
// Full house, where three cards have the same label, and the remaining two cards share a different label: 23332
// Three of a kind, where three cards have the same label, and the remaining two cards are each different from any other card in the hand: TTT98
// Two pair, where two cards share one label, two other cards share a second label, and the remaining card has a third label: 23432
// One pair, where two cards share one label, and the other three cards have a different label from the pair and each other: A23A4
// High card, where all cards' labels are distinct: 23456
export function typeHand(
  handCards: { hand: string[]; bid: number },
  withJokers: boolean,
): {
  type: (typeof CARDS_TYPES)[keyof typeof CARDS_TYPES];
  hand: string[];
  bid: number;
  score: number[];
} {
  const { hand } = handCards;
  const score = hand.map((card) => CARDS_VALUES[card]);
  const cardOccurrences: Record<string, number> = {};
  for (const card of hand) {
    cardOccurrences[card] = (cardOccurrences[card] ?? 0) + 1;
  }

  const occurrences = Object.values(cardOccurrences);
  if (occurrences.length === 1) {
    return { ...handCards, type: CARDS_TYPES.FIVE_OF_A_KIND, score };
  }
  if (occurrences.length === 2) {
    if (occurrences.includes(4)) {
      return { ...handCards, type: CARDS_TYPES.FOUR_OF_A_KIND, score };
    }
    return { ...handCards, type: CARDS_TYPES.FULL_HOUSE, score };
  }
  if (occurrences.length === 3) {
    if (occurrences.includes(3)) {
      return { ...handCards, type: CARDS_TYPES.THREE_OF_A_KIND, score };
    }
    if (occurrences.includes(2)) {
      return { ...handCards, type: CARDS_TYPES.TWO_PAIR, score };
    }
  }
  if (occurrences.length === 4) {
    return { ...handCards, type: CARDS_TYPES.ONE_PAIR, score };
  }
  return { ...handCards, type: CARDS_TYPES.HIGH_CARD, score };
}

function sortHands(
  hands: Array<{
    hand: string[];
    bid: number;
  }>,
  withJokers: boolean = false,
) {
  return hands
    .map((handCards) => typeHand(handCards, withJokers))
    .toSorted((a, b) => {
      if (a.type === b.type) {
        for (let index = 0; index < a.score.length; index += 1) {
          const aScore = a.score[index];
          const bScore = b.score[index];
          if (aScore !== bScore) return aScore - bScore;
        }
      }
      return b.type - a.type;
    });
}

export function parseInput(input: string) {
  return input.split("\n").map((value) => {
    const [rawHand, rawBid] = value.split(" ");
    const bid = Number(rawBid);
    const hand = rawHand.split("");
    return { hand, bid };
  });
}

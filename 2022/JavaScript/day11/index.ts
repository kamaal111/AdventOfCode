import { enumerate } from '../utilities/enumerate';
import { striding } from '../utilities/striding';

export function part2(input: string): number {
  return keepAwayPlayInteractions(input, 10000, 1);
}

function keepAwayPlayInteractions(
  input: string,
  rounds: number,
  worryLevelDivision: number,
): number {
  const monkeys = parseMonkeys(input);

  const monkeyIDs = Object.keys(monkeys);
  let round = 0;
  while (round < rounds) {
    console.log('round', round);
    for (const monkeyID of monkeyIDs) {
      const monkey: Monkey = monkeys[monkeyID];
      monkey.itemsInspected += monkey.items.length;

      while (monkey.items.length > 0) {
        const item = monkey.items.pop()!;
        const newWorryLevel = calculateOperation(
          monkey.operation,
          item,
          worryLevelDivision,
        );
        const monkeyToThrowTo = monkeyToThrowToIndex(monkey, newWorryLevel);
        monkeys[monkeyToThrowTo].items.push(newWorryLevel);
      }
    }

    round += 1;
  }

  const mostActiveMonkeys = Object.values(monkeys)
    .sort((monkeyA, monkeyB) => {
      if (monkeyA.itemsInspected < monkeyB.itemsInspected) {
        return 1;
      }

      if (monkeyA.itemsInspected > monkeyB.itemsInspected) {
        return -1;
      }

      return 0;
    })
    .slice(0, 2);

  console.log('mostActiveMonkeys', mostActiveMonkeys);
  console.log('monkeys', monkeys);
  return mostActiveMonkeys.reduce((acc, monkey) => {
    return acc * monkey.itemsInspected;
  }, 1);
}

const zeroBigInt = BigInt(0);

function monkeyToThrowToIndex(monkey: Monkey, worryLevel: bigint): MonkeyID {
  const key = worryLevel % BigInt(monkey.testDivisibleBy) == zeroBigInt;
  return monkey.decisions[String(key)];
}

function calculateOperation(
  rawOperation: string,
  worryLevel: bigint,
  worryLevelDivision: number,
): bigint {
  if (rawOperation.includes('*')) {
    const [value1, value2] = formatOperation(rawOperation, worryLevel, '*');
    return value1 * value2;
  } else if (rawOperation.includes('+')) {
    const [value1, value2] = formatOperation(rawOperation, worryLevel, '+');
    return value1 + value2;
  }

  throw new Error("Ain't no way");
}

function formatOperation(
  rawOperation: string,
  worryLevel: bigint,
  operator: string,
): [bigint, bigint] {
  return rawOperation.split(operator).map((value) => {
    if (value.includes('old')) {
      return worryLevel;
    }

    return BigInt(value);
  }) as [bigint, bigint];
}

function parseMonkeys(input: string): { [x: MonkeyID]: Monkey } {
  const lines = input.split('\n');
  const strides = 7;

  return striding(enumerate(lines), strides)
    .map(({ index: monkeyIndex }) => {
      const monkeyID: MonkeyID = monkeyIndex / strides;
      const monkeyInfo = lines
        .slice(monkeyIndex + 1, monkeyIndex + strides - 1)
        .map((value) => value.split(':')[1]);
      const items = monkeyInfo[0].split(',').map((value) => BigInt(value));
      const operation = monkeyInfo[1].split('=')[1].trimStart();
      const remainingMonkeyInfo = monkeyInfo.slice(2, 5).map((value) => {
        const splittedValue = value.split(" ")
        return Number(splittedValue[splittedValue.length - 1])
      })
      const testDivisibleBy = remainingMonkeyInfo[0];
      const decisionTrue = remainingMonkeyInfo[1];
      const decisionFalse = remainingMonkeyInfo[2];

      return new Monkey(monkeyID, items, operation, testDivisibleBy, {
        true: decisionTrue,
        false: decisionFalse,
      });
    })
    .reduce((monkeys, monkey) => {
      const newMonkeys = monkeys;
      newMonkeys[monkey.id] = monkey;
      return newMonkeys;
    }, {});
}

type MonkeyID = number;

class Monkey {
  id: MonkeyID;
  items: bigint[];
  operation: string;
  testDivisibleBy: number;
  decisions: { true: MonkeyID; false: MonkeyID };
  itemsInspected: number;

  constructor(
    id: MonkeyID,
    items: bigint[],
    operation: string,
    testDivisibleBy: number,
    decisions: { true: MonkeyID; false: MonkeyID },
    itemsInspected = 0,
  ) {
    this.id = id;
    this.items = items;
    this.operation = operation;
    this.testDivisibleBy = testDivisibleBy;
    this.decisions = decisions;
    this.itemsInspected = itemsInspected;
  }
}

const spelledOutDigitsMap = {
  one: 1,
  two: 2,
  three: 3,
  four: 4,
  five: 5,
  six: 6,
  seven: 7,
  eight: 8,
  nine: 9,
};

const spelledOutDigits = Object.keys(spelledOutDigitsMap);

export function part1(input: string): number {
  return calibirateLines(input.split("\n"));
}

export function part2(input: string): number {
  return calibirateLines(input.split("\n").map(digitizeLine));
}

function calibirateLines(lines: string[]): number {
  return lines.reduce((sum, line) => {
    const digits: string[] = [];
    for (let index = 0; index < line.length; index += 1) {
      const character = line[index];
      if (Number.isNaN(Number(character))) continue;

      if (digits.length < 2) {
        digits.push(character);
      } else {
        digits[1] = character;
      }
    }

    if (digits.length === 0) return sum;
    if (digits.length === 1) return sum + Number(`${digits[0]}${digits[0]}`);
    return sum + Number(digits.join(""));
  }, 0);
}

function digitizeLine(line: string): string {
  const digitizedLine: string[] = [];

  for (let index = 0; index < line.length; index += 1) {
    const character = line[index];
    if (!Number.isNaN(Number(character))) {
      digitizedLine.push(character);
      continue;
    }

    const buffer = [character];
    for (
      let indexTrailing = index + 1;
      indexTrailing < line.length;
      indexTrailing += 1
    ) {
      const characterTrailing = line[indexTrailing];
      buffer.push(characterTrailing);
      const word = buffer.join("");
      if (spelledOutDigits.includes(word)) {
        digitizedLine.push(String(spelledOutDigitsMap[word]));
        break;
      }
    }
  }

  return digitizedLine.join("");
}

import fs from 'fs/promises';

let _inputs: { [x: string]: string | undefined } = {};

export async function getInput(day: string): Promise<string> {
  const cachedInput = _inputs[day];
  if (cachedInput != null) {
    return cachedInput;
  }

  const input = await fs.readFile(
    `2022/Swift/Sources/AOC2022/Inputs/${day}.txt`,
    'utf-8',
  );
  _inputs[day] = input.toString();

  return _inputs[day]!;
}

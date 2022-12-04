export function part1(input: string): number {
  return amountOfOverlappingSchedules(
    input,
    (firstSchedule, secondSchedule) => {
      return (
        (firstSchedule.includes(secondSchedule[0]) &&
          firstSchedule.includes(secondSchedule.at(-1)!)) ||
        (secondSchedule.includes(firstSchedule[0]) &&
          secondSchedule.includes(firstSchedule.at(-1)!))
      );
    },
  );
}

export function part2(input: string): number {
  return amountOfOverlappingSchedules(
    input,
    (firstSchedule, secondSchedule) => {
      return (
        firstSchedule.includes(secondSchedule[0]) ||
        firstSchedule.includes(secondSchedule.at(-1)!) ||
        secondSchedule.includes(firstSchedule[0]) ||
        secondSchedule.includes(firstSchedule.at(-1)!)
      );
    },
  );
}

function amountOfOverlappingSchedules(
  input: string,
  predicate: (firstSchedule: number[], secondSchedule: number[]) => boolean,
): number {
  let overlappingSchedules = 0;
  for (const schedulePairs of input.split('\n')) {
    if (!schedulePairs.includes('-') || !schedulePairs.includes(',')) {
      continue;
    }

    const [firstSchedule, secondSchedule] = parseSchedulePairs(schedulePairs);
    if (predicate(firstSchedule, secondSchedule)) {
      overlappingSchedules += 1;
    }
  }
  return overlappingSchedules;
}

function parseSchedulePairs(rawSchedulePairs: string): [number[], number[]] {
  const schedules = rawSchedulePairs.split(',');
  return [parseSchedule(schedules[0]), parseSchedule(schedules[1])];
}

function parseSchedule(rawSchedule: string): number[] {
  const schedule = rawSchedule.split('-').map((value) => Number(value));
  const scheduleRange = [...Array(schedule[1] - schedule[0] + 1)].map(
    (_, index) => schedule[0] + index,
  );
  return scheduleRange;
}

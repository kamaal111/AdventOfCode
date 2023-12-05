const MAP_KEYS = [
  "seed-to-soil",
  "soil-to-fertilizer",
  "fertilizer-to-water",
  "water-to-light",
  "light-to-temperature",
  "temperature-to-humidity",
  "humidity-to-location",
] as const;

type MapKeys = (typeof MAP_KEYS)[number];

type Maps = Record<
  MapKeys,
  Array<{
    destinationRange: number;
    sourceRangeStart: number;
    rangeLength: number;
  }>
>;

export function part1(input: string) {
  const { seeds, maps } = parseInput(input);
  let current = seeds;
  for (const mapKey of MAP_KEYS) {
    current = current.map((value) => mapping(value, maps, mapKey));
  }
  return Math.min(...current);
}

export function part2(input: string) {
  const { seeds, maps } = parseInput(input);
  return 0;
}

export function mapping(value: number, maps: Maps, key: MapKeys) {
  for (const { destinationRange, sourceRangeStart, rangeLength } of maps[key]) {
    if (value >= sourceRangeStart && value < sourceRangeStart + rangeLength) {
      return destinationRange + value - sourceRangeStart;
    }
  }

  return value;
}

export function parseInput(input: string) {
  const [seeds, ...lines] = input.split("\n");
  const { maps } = lines.reduce<{
    maps: Maps;
    keys: MapKeys[];
  }>(
    (acc, line) => {
      if (line.length === 0) return acc;

      if (line.includes(" map:")) {
        const key = line.split(" map:")[0] as MapKeys;
        return { ...acc, keys: [...acc.keys, key] };
      }

      const key = acc.keys.at(-1)!;
      const [destinationRange, sourceRangeStart, rangeLength] = line
        .split(" ")
        .map((value) => Number(value));
      const maps = { ...acc.maps };
      maps[key].push({
        destinationRange,
        sourceRangeStart,
        rangeLength,
      });
      return { ...acc, maps };
    },
    {
      maps: MAP_KEYS.reduce((maps, key) => {
        return { ...maps, [key]: [] };
      }, {}) as Maps,
      keys: [],
    },
  );

  return {
    seeds: seeds
      .split(" ")
      .slice(1)
      .map((value) => Number(value)),
    maps,
  };
}

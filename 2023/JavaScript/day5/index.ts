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

// Brute force done in 8.5 minutes
export function part2(input: string) {
  const { seeds, maps } = parseInput(input);
  let lowestLocation = Number.MAX_SAFE_INTEGER;
  makeSeedPairs(seeds).forEach((seedPair, index, seedPairs) => {
    console.log(
      `processing ${index + 1}/${seedPairs.length} with ${
        seedPair.range
      } seeds`,
    );

    for (let index = 0; index < seedPair.range; index += 1) {
      let current = seedPair.start + index;
      for (const mapKey of MAP_KEYS) {
        current = mapping(current, maps, mapKey);
      }

      if (index % 500_000 === 0) {
        console.log(
          `location found ${seedPair.start + index}/${
            seedPair.start + seedPair.range
          }`,
        );
      }
      lowestLocation = Math.min(lowestLocation, current);
    }
  });
  return lowestLocation;
}

function makeSeedPairs(seeds: number[]) {
  return seeds.reduce<Array<{ start: number; range: number }>>(
    (pairs, seed, index) => {
      if (index % 2 === 0) return [...pairs, { start: seed, range: 0 }];
      const newPairs = pairs;
      newPairs[newPairs.length - 1].range = seed;
      return newPairs;
    },
    [],
  );
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

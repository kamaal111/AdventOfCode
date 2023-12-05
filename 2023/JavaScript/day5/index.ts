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
  const locations = MAP_KEYS.reduce((current, mapKey) => {
    return current.map((value) => mapping(value, maps, mapKey));
  }, seeds);
  return Math.min(...locations);
}

// Brute force done in 8.5 minutes
export function part2(input: string) {
  const { seeds, maps } = parseInput(input);
  return makeSeedPairs(seeds).reduce(
    (lowestLocation, seedPair, index, seedPairs) => {
      console.log(
        `processing ${index + 1}/${seedPairs.length} with ${
          seedPair.range
        } seeds`,
      );
      let newLowestLocation = lowestLocation;
      for (let index = 0; index < seedPair.range; index += 1) {
        const current = MAP_KEYS.reduce((current, mapKey) => {
          return mapping(current, maps, mapKey);
        }, seedPair.start + index);

        if (index % 500_000 === 0) {
          console.log(
            `location found ${seedPair.start + index}/${
              seedPair.start + seedPair.range
            }`,
          );
        }
        if (current < newLowestLocation) {
          newLowestLocation = current;
        }
      }
      return newLowestLocation;
    },
    Number.MAX_SAFE_INTEGER,
  );
}

function makeSeedPairs(seeds: number[]) {
  return seeds.reduce<Array<{ start: number; range: number }>>(
    (pairs, seed, index) => {
      if (index % 2 === 0) {
        return [...pairs, { start: seed, range: 0 }];
      }

      const newPairs = [...pairs];
      newPairs[newPairs.length - 1].range = seed;
      return newPairs;
    },
    [],
  );
}

export function mapping(value: number, maps: Maps, key: MapKeys) {
  const mappingFound = maps[key].find(({ sourceRangeStart, rangeLength }) => {
    return value >= sourceRangeStart && value < sourceRangeStart + rangeLength;
  });
  if (mappingFound == null) return value;
  const { destinationRange, sourceRangeStart } = mappingFound;

  return destinationRange + value - sourceRangeStart;
}

export function parseInput(input: string) {
  const [rawSeeds, ...lines] = input.split("\n");
  const seeds = rawSeeds
    .split(" ")
    .slice(1)
    .map((value) => Number(value));
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

      const key = acc.keys.at(-1);
      if (key == null) return acc;

      const [destinationRange, sourceRangeStart, rangeLength] = line
        .split(" ")
        .map((value) => Number(value));
      const maps = { ...acc.maps };
      maps[key].push({ destinationRange, sourceRangeStart, rangeLength });
      return { ...acc, maps };
    },
    {
      maps: MAP_KEYS.reduce((maps, key) => {
        return { ...maps, [key]: [] };
      }, {}) as Maps,
      keys: [],
    },
  );

  return { seeds, maps };
}

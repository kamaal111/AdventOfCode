type MapKeys =
  | "seed-to-soil"
  | "soil-to-fertilizer"
  | "fertilizer-to-water"
  | "water-to-light"
  | "light-to-temperature"
  | "temperature-to-humidity"
  | "humidity-to-location";

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
  const soils = seeds.map((seed) => mapping(seed, maps, "seed-to-soil"));
  console.log("soils", soils);
  const fertilizers = soils.map((soil) =>
    mapping(soil, maps, "soil-to-fertilizer"),
  );
  console.log("fertilizers", fertilizers);
  return 0;
}

export function part2(input: string) {
  return 0;
}

export function mapping(value: number, maps: Maps, key: MapKeys) {
  for (const { destinationRange, sourceRangeStart, rangeLength } of maps[key]) {
    const destinationRangeEnd = destinationRange + rangeLength - 1;
    if (value >= destinationRange && value <= destinationRangeEnd) {
      const diff = Math.abs(
        value - value - destinationRange + sourceRangeStart,
      );
      const newValue = value + diff;
      return newValue;
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
      maps: {
        "seed-to-soil": [],
        "soil-to-fertilizer": [],
        "fertilizer-to-water": [],
        "water-to-light": [],
        "light-to-temperature": [],
        "temperature-to-humidity": [],
        "humidity-to-location": [],
      },
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

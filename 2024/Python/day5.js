const fs = require("fs/promises");

const EXAMPLE = [
  [75, 97, 47, 61, 53],
  [61, 13, 29],
  [97, 13, 75, 29, 47],
];

// def map_rules(data: PrinterData):
//     mapped_rules: dict[str, dict[str, list[PrinterPageOrderRule]]] = {"X": {}, "Y": {}}
//     for rule in data.page_order_rules:
//         try:
//             mapped_rules["X"][str(rule.X)].append(rule)
//         except KeyError:
//             mapped_rules["X"][str(rule.X)] = [rule]

//         try:
//             mapped_rules["Y"][str(rule.Y)].append(rule)
//         except KeyError:
//             mapped_rules["Y"][str(rule.Y)] = [rule]

//     return mapped_rules

async function main() {
  const data = (await fs.readFile("2024/Data/day5-invalids.txt")).toString();
  console.log("data", data);
  // EXAMPLE.sort((a, b) => )
}

main();

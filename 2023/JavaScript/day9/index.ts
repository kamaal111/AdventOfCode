import { sum } from "../utils/maths";

export function part1(input: string) {
  return sum(
    parseInput(input).map((historyLine) => {
      return getPredictedHistoryOnTheRight(makeTreeForHistoryLine(historyLine));
    }),
  );
}

export function part2(input: string) {
  return sum(
    parseInput(input).map((historyLine) => {
      return getPredictedHistoryOnTheLeft(makeTreeForHistoryLine(historyLine));
    }),
  );
}

export class TreeNode<T> {
  value: T;
  left?: TreeNode<T>;
  right?: TreeNode<T>;

  constructor(value: T, left?: TreeNode<T>, right?: TreeNode<T>) {
    this.value = value;
    this.left = left;
    this.right = right;
  }
}

export function getPredictedHistoryOnTheLeft(
  historyLineTree: Array<TreeNode<number>>,
) {
  let comparisonNode = historyLineTree.at(0);
  let currentPredictedValue = 0;
  while (comparisonNode != null) {
    const newValue = comparisonNode.value - currentPredictedValue;
    comparisonNode = comparisonNode.left;
    currentPredictedValue = newValue;
  }
  return currentPredictedValue;
}

function getPredictedHistoryOnTheRight(
  historyLineTree: Array<TreeNode<number>>,
) {
  let comparisonNode = historyLineTree.at(-1);
  let currentPredictedValue = 0;
  while (comparisonNode != null) {
    const newValue = currentPredictedValue + comparisonNode.value;
    comparisonNode = comparisonNode.right;
    currentPredictedValue = newValue;
  }
  return currentPredictedValue;
}

export function makeTreeForHistoryLine(historyLine: Array<TreeNode<number>>) {
  let allValuesAreEndWithZero = false;
  let currentNodes = historyLine;
  while (!allValuesAreEndWithZero) {
    const newNodes: Array<TreeNode<number>> = [];
    for (let index = 1; index < currentNodes.length; index += 1) {
      const node = currentNodes[index];
      const previousNode = currentNodes[index - 1];
      const difference = node.value - previousNode.value;
      const newNode = new TreeNode(difference, previousNode, node);
      newNodes.push(newNode);
    }
    currentNodes = newNodes;
    allValuesAreEndWithZero =
      newNodes.length === 0 ? true : newNodes.every((node) => node.value === 0);
  }

  return currentNodes;
}

export function parseInput(input: string) {
  return input
    .split("\n")
    .map((line) => line.split(" ").map((value) => new TreeNode(Number(value))));
}

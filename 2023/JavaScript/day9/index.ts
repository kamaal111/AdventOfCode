import { TreeNode } from "../models/treeNode";
import { sum } from "../utils/maths";

export function part1(input: string) {
  return sum(parseInput(input).map(getPredictedHistoryOnTheRight));
}

export function part2(input: string) {
  return sum(parseInput(input).map(getPredictedHistoryOnTheLeft));
}

export function getPredictedHistoryOnTheLeft(
  historyLineTree: Array<TreeNode<number>>,
) {
  let comparisonNode = historyLineTree[0];
  let currentPredictedValue = 0;
  while (true) {
    const newValue = comparisonNode.value - currentPredictedValue;
    if (comparisonNode.left == null) return newValue;

    comparisonNode = comparisonNode.left;
    currentPredictedValue = newValue;
  }
}

function getPredictedHistoryOnTheRight(
  historyLineTree: Array<TreeNode<number>>,
) {
  let comparisonNode = historyLineTree.at(-1)!;
  let currentPredictedValue = 0;
  while (true) {
    const newValue = currentPredictedValue + comparisonNode.value;
    if (comparisonNode.right == null) return newValue;

    comparisonNode = comparisonNode.right;
    currentPredictedValue = newValue;
  }
}

export function makeTreeForHistoryLine(historyLine: Array<TreeNode<number>>) {
  let currentNodes = historyLine;
  while (
    currentNodes.length > 1 &&
    currentNodes.some((node) => node.value !== 0)
  ) {
    const newNodes: Array<TreeNode<number>> = [];
    for (let index = 1; index < currentNodes.length; index += 1) {
      const node = currentNodes[index];
      const previousNode = currentNodes[index - 1];
      const difference = node.value - previousNode.value;
      const newNode = new TreeNode(difference, previousNode, node);
      newNodes.push(newNode);
    }
    currentNodes = newNodes;
  }

  return currentNodes;
}

export function parseInput(input: string) {
  return input.split("\n").map((line) => {
    const nodes = line.split(" ").map((value) => new TreeNode(Number(value)));
    return makeTreeForHistoryLine(nodes);
  });
}

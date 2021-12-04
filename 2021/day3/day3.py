from typing import List


def run(input: str):
    print(f"Day 3 Part 1: {part1(input)}")
    print(f"Day 3 Part 2: {part2(input)}")  # 793873


def part2(input: str):
    lines = input.splitlines()

    oxygen = get_oxygen(lines)
    scrubber = get_scrubber(lines)

    return int(oxygen, 2) * int(scrubber, 2)


def get_scrubber(lines: List[str]):
    bit_criteria = lines

    length_of_first_line = len(lines[0])
    for i in range(length_of_first_line):
        zeros = 0
        zeros_bitcriteria: List[str] = []
        ones = 0
        ones_bitcriteria: List[str] = []

        for criteria in bit_criteria:
            if criteria[i] == "0":
                zeros += 1
                zeros_bitcriteria.append(criteria)
            else:
                ones += 1
                ones_bitcriteria.append(criteria)

        if zeros <= ones:
            bit_criteria = zeros_bitcriteria
        elif ones < zeros:
            bit_criteria = ones_bitcriteria

        if len(bit_criteria) <= 1:
            return bit_criteria[0]

    return ""


def get_oxygen(lines: List[str]):
    bit_criteria = lines

    oxygen = ""

    length_of_first_line = len(lines[0])
    for i in range(length_of_first_line):
        zeros = 0
        zeros_bitcriteria: List[str] = []
        ones = 0
        ones_bitcriteria: List[str] = []

        for criteria in bit_criteria:
            if criteria[i] == "0":
                zeros += 1
                zeros_bitcriteria.append(criteria)
            else:
                ones += 1
                ones_bitcriteria.append(criteria)

        if zeros > ones:
            oxygen += "0"
            bit_criteria = zeros_bitcriteria
        elif ones >= zeros:
            oxygen += "1"
            bit_criteria = ones_bitcriteria

        if len(bit_criteria) <= 1:
            return bit_criteria[0]

    return oxygen


def part1(input: str):
    lines = input.splitlines()

    gamma_rate = ""
    epsilon_rate = ""

    length_of_first_line = len(lines[0])
    for i in range(length_of_first_line):
        zeros = 0
        ones = 0

        for line in lines:
            if line[i] == "0":
                zeros += 1
            else:
                ones += 1

        if zeros > ones:
            gamma_rate += "0"
            epsilon_rate += "1"
        elif ones > zeros:
            gamma_rate += "1"
            epsilon_rate += "0"

    return int(gamma_rate, 2) * int(epsilon_rate, 2)

# day2.py


def run(input: str):
    print(f"Day 3 Part 1: {part1(input)}")
    print(f"Day 3 Part 2: {part2(input)}")


def part2(input: str):
    return 0


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

# day2.py


def run(input: str):
    print(f"Day 2 Part 1: {part1(input)}")
    print(f"Day 2 Part 2: {part2(input)}")


def part2(input: str):
    lines = input.splitlines()

    depth = 0
    horizontal = 0
    aim = 0

    for line in lines:
        splitted_command = line.split(" ")

        command = splitted_command[0]
        position = int(splitted_command[1])

        if command == "up":
            aim -= position
        elif command == "down":
            aim += position
        elif command == "forward":
            horizontal += position
            depth += position * aim

    return depth * horizontal


def part1(input: str):
    lines = input.splitlines()

    depth = 0
    horizontal = 0

    for line in lines:
        splitted_command = line.split(" ")

        command = splitted_command[0]
        position = int(splitted_command[1])

        if command == "up":
            depth -= position
        elif command == "down":
            depth += position
        elif command == "forward":
            horizontal += position

    return depth * horizontal

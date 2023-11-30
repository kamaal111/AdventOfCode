# day1.py


def run(input: str):
    print(f"Day 1 Part 1: {part1(input)}")
    print(f"Day 1 Part 2: {part2(input)}")


def part2(input: str):
    increases = 0

    lines = input.splitlines()
    for (line_number, line) in enumerate(lines):
        int_line = int(line)

        if (line_number + 3) < len(lines):
            first_sum = int_line
            second_sum = 0

            for i in range(0, 3):
                next_line = int(lines[line_number + i + 1])

                if i < 2:
                    first_sum += next_line

                second_sum += next_line

            if second_sum > first_sum:
                increases += 1

    return increases


def part1(input: str):
    increases = 0

    lines = input.splitlines()
    for (line_number, line) in enumerate(lines):
        int_line = int(line)

        if (line_number + 1) < len(lines):
            next_int = int(lines[line_number + 1])

            if int_line < next_int:
                increases += 1

    return increases

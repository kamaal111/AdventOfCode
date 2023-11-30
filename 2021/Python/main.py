import time


import day1
import day2
import day3
import day4
import day5
from utils.utils import get_input_string


if __name__ == "__main__":
    start = time.time()

    input_string = get_input_string("../Swift/Sources/AOC2021/Inputs/day1.txt")
    day1.run(input_string)
    input_string = get_input_string("../Swift/Sources/AOC2021/Inputs/day2.txt")
    day2.run(input_string)
    input_string = get_input_string("../Swift/Sources/AOC2021/Inputs/day3.txt")
    day3.run(input_string)
    input_string = get_input_string("../Swift/Sources/AOC2021/Inputs/day4.txt")
    day4.run(input_string)
    input_string = get_input_string("../Swift/Sources/AOC2021/Inputs/day5.txt")
    day5.run(input_string)

    elapsed = time.time()
    print(f"Time: {(elapsed - start) * 1000}ms")

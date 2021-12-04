import time

from day1 import day1
from day2 import day2
from day3 import day3
from day4 import day4
from utils.utils import get_input_string


def main():
    input_string = get_input_string("day1/input.txt")
    day1.run(input_string)
    input_string = get_input_string("day2/input.txt")
    day2.run(input_string)
    input_string = get_input_string("day3/input.txt")
    day3.run(input_string)
    input_string = get_input_string("day4/input.txt")
    day4.run(input_string) # 54444

if __name__ == "__main__":
    start = time.time()

    main()

    elapsed = time.time()
    print(f"Time: {(elapsed - start) * 1000}ms")

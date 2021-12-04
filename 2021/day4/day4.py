from typing import List


example_input = """7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7"""


def run(input: str):
    print(f"Day 4 Part 1: {part1(input)}")


def part1(input: str):
    lines = input.splitlines()
    plays = lines[0].split(",")

    boards: List[str] = []
    unmarked_boards: List[str] = []

    for line in lines[1:]:
        if line == "":
            continue

        if len(boards) > 0 and len(boards[-1]) < (5 * 5):
            for piece in line.split():
                boards[-1].append(piece)
                unmarked_boards[-1].append(piece)
        else:
            boards.append(line.split())
            unmarked_boards.append(line.split())

    for play in plays:
        for board in boards:
            for i in range(len(board)):
                if board[i] == play:
                    board[i] = "X"

        for board in boards:
            if evaluate_board(board):
                sum_unmarked = 0
                for piece in board:
                    if piece != "X":
                        sum_unmarked += int(piece)

                return sum_unmarked * int(play)

    return 0


def evaluate_board(board: List[str]) -> bool:
    x_count = board.count("X")

    if x_count >= 5:
        rows = []
        columns = []
        diagonals = []

        for i in range(5):
            row = []
            column = []

            for j in range(5):
                row.append(board[i * 5 + j])
                column.append(board[j * 5 + i])

            rows.append(row)
            columns.append(column)

        diagonals.append([board[0], board[6], board[12], board[18], board[24]])
        diagonals.append([board[4], board[8], board[12], board[16], board[20]])

        for row in rows:
            x_count_row = row.count("X")
            if x_count_row == 5:
                return True

        # print(f"{diagonals=}")
        # for diagonal in diagonals:
        #     x_count_diagonal = diagonal.count("X")
        #     if x_count_diagonal == 5:
        #         print(f"{diagonal=}")
        #         return True

        for column in columns:
            x_count_column = column.count("X")
            if x_count_column == 5:
                return True

    return False

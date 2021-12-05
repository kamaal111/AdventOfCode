from typing import List


example_input = """0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2"""


STARTING_PLOT = "."
FIRST_PLOT = "1"
SECOND_PLOT = "2"


def run(input: str):
    print(f"Day 5 Part 1: {part1(input)}")
    print(f"Day 5 Part 2: {part2(input)}")


def part2(input: str):
    lines = input.splitlines()

    grid_size = 0
    for line in lines:
        for item in line.split("->"):
            for coordinate in make_coordinates(item):
                grid_size = max(grid_size, coordinate)

    grid_size += 1

    plots: List[str] = []
    for _ in range((grid_size * grid_size) - 1):
        plots.append(STARTING_PLOT)

    diagonal_tries: List[List[int]] = []

    for line in lines:
        coordinates = line.split("->")
        first_coordinate = make_coordinates(coordinates[0])
        second_coordinate = make_coordinates(coordinates[1])

        if first_coordinate[0] == second_coordinate[0]: # vertical
            if first_coordinate[1] > second_coordinate[1]:
                minimum = second_coordinate[1]
                maximum = first_coordinate[1]
            else:
                minimum = first_coordinate[1]
                maximum = second_coordinate[1]

            for i in range(minimum, maximum + 1):
                plot_index = (i * grid_size + first_coordinate[0]) + 1

                if plots[plot_index] == STARTING_PLOT:
                    plots[plot_index] = FIRST_PLOT
                elif plots[plot_index] == FIRST_PLOT:
                    plots[plot_index] = SECOND_PLOT
            
        elif first_coordinate[1] == second_coordinate[1]: # horizontal
            if first_coordinate[0] > second_coordinate[0]:
                minimum = second_coordinate[0]
                maximum = first_coordinate[0]
            else:
                minimum = first_coordinate[0]
                maximum = second_coordinate[0]

            for i in range(minimum, maximum + 1):
                plot_index = (first_coordinate[1] * grid_size + i) + 1

                if plots[plot_index] == STARTING_PLOT:
                    plots[plot_index] = FIRST_PLOT
                elif plots[plot_index] == FIRST_PLOT:
                    plots[plot_index] = SECOND_PLOT

        else: # diagonal
            # if first_coordinate[0] > second_coordinate[0]:
            #     minimum = second_coordinate[0]
            #     maximum = first_coordinate[0]
            # else:
            #     minimum = first_coordinate[0]
            #     maximum = second_coordinate[0]
            if first_coordinate[0] > second_coordinate[0]:
                minimum_x = second_coordinate[0]
                maximum_x = first_coordinate[0]
            else:
                minimum_x = first_coordinate[0]
                maximum_x = second_coordinate[0]

            if first_coordinate[1] > second_coordinate[1]:
                minimum_y = second_coordinate[1]
                maximum_y = first_coordinate[1]
            else:
                minimum_y = first_coordinate[1]
                maximum_y = second_coordinate[1]

            foundTry = False
            for diagonal_try in diagonal_tries:
                if diagonal_try[0] == minimum_x and diagonal_try[1] == maximum_x:
                    foundTry = True
                if diagonal_try[0] == minimum_y and diagonal_try[1] == maximum_y:
                    foundTry = True

            if foundTry:
                continue

            if minimum_x > maximum_x:
                minimum_x, maximum_x = maximum_x, minimum_x

            if minimum_y > maximum_y:
                minimum_y, maximum_y = maximum_y, minimum_y

            if minimum_x > minimum_y:
                diagonal_tries.append([minimum_x, maximum_x])
                for i in range(minimum_x, maximum_x + 1):
                    plot_index = (i * grid_size + i) + 1

                    if plots[plot_index] == STARTING_PLOT:
                        plots[plot_index] = FIRST_PLOT
                    elif plots[plot_index] == FIRST_PLOT:
                        plots[plot_index] = SECOND_PLOT
            else:
                diagonal_tries.append([minimum_y, maximum_y])
                for i in range(minimum_y, maximum_y + 1):
                    plot_index = (i * grid_size + i) + 1

                    if plots[plot_index] == STARTING_PLOT:
                        plots[plot_index] = FIRST_PLOT
                    elif plots[plot_index] == FIRST_PLOT:
                        plots[plot_index] = SECOND_PLOT

    too_many_overlaps = 0
    ordered_plots: List[List[str]] = []
    for plot in plots:
        if len(ordered_plots) == 0:
            ordered_plots.append([plot])
        
        last_ordered_plot = ordered_plots[-1]
        if len(last_ordered_plot) < grid_size:
            last_ordered_plot.append(plot)
            ordered_plots[-1] = last_ordered_plot
        else:
            ordered_plots.append([plot])

        if plot == SECOND_PLOT:
            too_many_overlaps += 1

    # for ordered_plot in ordered_plots:
    #     print(ordered_plot)

    return too_many_overlaps


def part1(input: str):
    lines = input.splitlines()

    grid_size = 0
    for line in lines:
        for item in line.split("->"):
            for coordinate in make_coordinates(item):
                grid_size = max(grid_size, coordinate)

    grid_size += 1

    plots: List[str] = []
    for _ in range(grid_size * grid_size):
        plots.append(STARTING_PLOT)


    for line in lines:
        coordinates = line.split("->")
        first_coordinate = make_coordinates(coordinates[0])
        second_coordinate = make_coordinates(coordinates[1])

        if first_coordinate[0] == second_coordinate[0]: # vertical
            if first_coordinate[1] > second_coordinate[1]:
                minimum = second_coordinate[1]
                maximum = first_coordinate[1]
            else:
                minimum = first_coordinate[1]
                maximum = second_coordinate[1]

            for i in range(minimum, maximum + 1):
                plot_index = (i * grid_size + first_coordinate[0]) + 1

                if plots[plot_index] == STARTING_PLOT:
                    plots[plot_index] = FIRST_PLOT
                elif plots[plot_index] == FIRST_PLOT:
                    plots[plot_index] = SECOND_PLOT
            
        elif first_coordinate[1] == second_coordinate[1]: # horizontal
            if first_coordinate[0] > second_coordinate[0]:
                minimum = second_coordinate[0]
                maximum = first_coordinate[0]
            else:
                minimum = first_coordinate[0]
                maximum = second_coordinate[0]

            for i in range(minimum, maximum + 1):
                plot_index = (first_coordinate[1] * grid_size + i) + 1

                if plots[plot_index] == STARTING_PLOT:
                    plots[plot_index] = FIRST_PLOT
                elif plots[plot_index] == FIRST_PLOT:
                    plots[plot_index] = SECOND_PLOT


    too_many_overlaps = 0
    ordered_plots: List[List[str]] = []
    for plot in plots:
        if len(ordered_plots) == 0:
            ordered_plots.append([plot])
        
        last_ordered_plot = ordered_plots[-1]
        if len(last_ordered_plot) < grid_size:
            last_ordered_plot.append(plot)
            ordered_plots[-1] = last_ordered_plot
        else:
            ordered_plots.append([plot])

        if plot == SECOND_PLOT:
            too_many_overlaps += 1

    # for ordered_plot in ordered_plots:
    #     print(ordered_plot)

    return too_many_overlaps


def make_coordinates(coordinates: str):
    coordinate: List[int] = []
    for number in coordinates.split(","):
        coordinate.append(int(number))
    return coordinate


print(part2(example_input))
print(part2(example_input) == 12)
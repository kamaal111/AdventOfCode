fn part1(input: String) -> i32 {
    let mut highest_calories = 0;
    let mut current_streak = 0;
    for line in input.split("\n") {
        if line.is_empty() {
            if current_streak > highest_calories {
                highest_calories = current_streak;
            }
            current_streak = 0;
        } else {
            let calories: i32 = line.parse().unwrap();
            current_streak += calories;
        }
    }

    if current_streak != 0 && current_streak > highest_calories {
        return current_streak;
    }

    return highest_calories;
}

fn part2(input: String) -> i32 {
    let mut highest_calories = vec![0; 3];
    let mut current_streak = 0;
    for line in input.split("\n") {
        if line.is_empty() {
            if current_streak > highest_calories[0] {
                highest_calories.push(current_streak);
                highest_calories.sort();
                highest_calories.remove(0);
            }
            current_streak = 0;
        } else {
            let calories: i32 = line.parse().unwrap();
            current_streak += calories;
        }
    }

    if current_streak != 0 && current_streak > highest_calories[0] {
        highest_calories.push(current_streak);
        highest_calories.sort();
        highest_calories.remove(0);
    }

    return highest_calories.iter().sum();
}

#[cfg(test)]
mod tests {
    const FILE_PATH: &'static str = "../../Packages/AOC2022/Sources/AOC2022/Inputs/day1.txt";

    #[test]
    fn part1_works() {
        use std::fs;

        let input = fs::read_to_string(FILE_PATH).expect("Could not read file");
        let result = super::part1(input);
        assert_eq!(result, 67450);
    }

    #[test]
    fn part2_works() {
        use std::fs;

        let input = fs::read_to_string(FILE_PATH).expect("Could not read file");
        let result = super::part2(input);
        assert_eq!(result, 199357);
    }
}

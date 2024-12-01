use std::collections::HashMap;

fn prepare(input: String) -> (Vec<i32>, Vec<i32>) {
    let lines = input.split("\n").filter(|line| line.len() > 0).map(|line| {
        line.split_whitespace()
            .map(|item| item.parse::<i32>().unwrap())
    });
    let mut left = Vec::<i32>::new();
    let mut right = Vec::<i32>::new();
    for line in lines {
        let items = line.collect::<Vec<i32>>();
        left.push(items[0]);
        right.push(items[1]);
    }

    left.sort();
    right.sort();

    return (left, right);
}

fn part1(input: String) -> i32 {
    let (left, right) = prepare(input);

    left.iter()
        .zip(right)
        .map(|(left_item, right_item)| (left_item - right_item).abs())
        .sum()
}

fn part2(input: String) -> i32 {
    let (left, right) = prepare(input);
    let mut right_counts = HashMap::<i32, i32>::new();
    right.iter().for_each(|right_item| {
        let new_right_count = match right_counts.get(&right_item) {
            Some(right_count) => right_count + 1,
            None => 1,
        };
        right_counts.insert(*right_item, new_right_count);
    });

    left.iter()
        .map(|left_item| match right_counts.get(&left_item) {
            Some(right_count) => right_count * left_item,
            None => 0,
        })
        .sum()
}

#[path = "./utils/get_input.rs"]
mod get_input;

#[cfg(test)]
mod tests {
    use super::get_input::get_input;

    const NAME: &'static str = "day1";

    const EXAMPLE: &'static str = "
3   4
4   3
2   5
1   3
3   9
3   3
";

    #[test]
    fn part1_example_works() {
        let result = super::part1(EXAMPLE.to_string());

        assert_eq!(result, 11);
    }

    #[test]
    fn part1_works() {
        let result = super::part1(get_input(NAME.to_string()));

        assert_eq!(result, 1882714);
    }

    #[test]
    fn part2_example_works() {
        let result = super::part2(EXAMPLE.to_string());

        assert_eq!(result, 31);
    }

    #[test]
    fn part2_works() {
        let result = super::part2(get_input(NAME.to_string()));

        assert_eq!(result, 19437052);
    }
}

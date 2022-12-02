use std::collections::HashMap;

fn part1(input: String) -> i32 {
    let my_strategy = HashMap::from([
        ("X", ShapePlay::Rock),
        ("Y", ShapePlay::Paper),
        ("Z", ShapePlay::Scissors),
    ]);
    let opponent_strategy = HashMap::from([
        ("A", ShapePlay::Rock),
        ("B", ShapePlay::Paper),
        ("C", ShapePlay::Scissors),
    ]);

    let mut my_score = 0;
    for line in input.split("\n") {
        let inputs: Vec<&str> = line.split(" ").collect();
        if inputs.len() < 2 {
            continue;
        }

        let my_input = my_strategy.get(inputs[1]).unwrap();
        let opponent_input = opponent_strategy.get(inputs[0]).unwrap();

        my_score += my_input.score_against_opponent(opponent_input);
    }

    return my_score;
}

fn part2(input: String) -> i32 {
    let my_strategy = HashMap::from([
        ("X", PlayDecision::Lose),
        ("Y", PlayDecision::Draw),
        ("Z", PlayDecision::Win),
    ]);
    let opponent_strategy = HashMap::from([
        ("A", ShapePlay::Rock),
        ("B", ShapePlay::Paper),
        ("C", ShapePlay::Scissors),
    ]);

    let mut my_score = 0;
    for line in input.split("\n") {
        let inputs: Vec<&str> = line.split(" ").collect();
        if inputs.len() < 2 {
            continue;
        }

        let opponent_input = opponent_strategy.get(inputs[0]).unwrap();
        let my_input = my_strategy
            .get(inputs[1])
            .unwrap()
            .shape_against_opponent(opponent_input);

        my_score += my_input.score_against_opponent(opponent_input);
    }

    return my_score;
}

#[derive(PartialEq)]
enum PlayDecision {
    Win,
    Lose,
    Draw,
}

impl PlayDecision {
    fn score(&self) -> i32 {
        match self {
            PlayDecision::Win => 6,
            PlayDecision::Lose => 0,
            PlayDecision::Draw => 3,
        }
    }

    fn shape_against_opponent(&self, opponent: &ShapePlay) -> ShapePlay {
        if self == &PlayDecision::Win {
            match opponent {
                ShapePlay::Rock => return ShapePlay::Paper,
                ShapePlay::Paper => return ShapePlay::Scissors,
                ShapePlay::Scissors => return ShapePlay::Rock,
            }
        } else if self == &PlayDecision::Lose {
            match opponent {
                ShapePlay::Rock => return ShapePlay::Scissors,
                ShapePlay::Paper => return ShapePlay::Rock,
                ShapePlay::Scissors => return ShapePlay::Paper,
            }
        }

        return opponent.clone();
    }
}

#[derive(Clone, PartialEq)]
enum ShapePlay {
    Rock,
    Paper,
    Scissors,
}

impl ShapePlay {
    fn score(&self) -> i32 {
        match self {
            ShapePlay::Rock => 1,
            ShapePlay::Paper => 2,
            ShapePlay::Scissors => 3,
        }
    }

    fn score_against_opponent(&self, opponent_input: &ShapePlay) -> i32 {
        let decision: PlayDecision;
        if self == opponent_input {
            decision = PlayDecision::Draw;
        } else if self == &ShapePlay::Rock {
            match opponent_input {
                ShapePlay::Scissors => decision = PlayDecision::Win,
                ShapePlay::Paper => decision = PlayDecision::Lose,
                _ => panic!("should have been handled"),
            }
        } else if self == &ShapePlay::Paper {
            match opponent_input {
                ShapePlay::Rock => decision = PlayDecision::Win,
                ShapePlay::Scissors => decision = PlayDecision::Lose,
                _ => panic!("should have been handled"),
            }
        } else {
            match opponent_input {
                ShapePlay::Rock => decision = PlayDecision::Lose,
                ShapePlay::Paper => decision = PlayDecision::Win,
                _ => panic!("should have been handled"),
            }
        }

        return decision.score() + self.score();
    }
}

#[cfg(test)]
mod tests {
    use std::fs;

    const FILE_PATH: &'static str = "../../Packages/AOC2022/Sources/AOC2022/Inputs/day2.txt";

    #[test]
    fn part1_works() {
        let input = fs::read_to_string(FILE_PATH).expect("Could not read file");
        let result = super::part1(input);
        assert_eq!(result, 14375);
    }

    #[test]
    fn part2_works() {
        let input = fs::read_to_string(FILE_PATH).expect("Could not read file");
        let result = super::part2(input);
        assert_eq!(result, 10274);
    }
}

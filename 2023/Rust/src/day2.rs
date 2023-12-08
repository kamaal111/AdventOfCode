fn part1(input: String) -> i32 {
    let possible_configuration = CubeSubset {
        red: 12,
        green: 13,
        blue: 14,
    };

    make_set(input)
        .iter()
        .filter(|game| {
            game.cube_subsets.iter().all(|cube_subset| {
                cube_subset.red <= possible_configuration.red
                    && cube_subset.green <= possible_configuration.green
                    && cube_subset.blue <= possible_configuration.blue
            })
        })
        .map(|game| game.id)
        .sum()
}

fn part2(input: String) -> i32 {
    make_set(input)
        .iter()
        .map(|game| {
            let highest_possible_set = game
                .cube_subsets
                .clone()
                .into_iter()
                .reduce(|highest_possible_set, cube_subset| CubeSubset {
                    red: cube_subset.red.max(highest_possible_set.red),
                    green: cube_subset.green.max(highest_possible_set.green),
                    blue: cube_subset.blue.max(highest_possible_set.blue),
                })
                .unwrap();
            highest_possible_set.red * highest_possible_set.green * highest_possible_set.blue
        })
        .sum()
}

#[derive(Clone)]
struct CubeSubset {
    red: i32,
    green: i32,
    blue: i32,
}

struct Game {
    id: i32,
    cube_subsets: Vec<CubeSubset>,
}

fn make_set(input: String) -> Vec<Game> {
    let mut games = Vec::<Game>::new();
    for line in input.split("\n") {
        let components = line
            .split("Game ")
            .last()
            .unwrap()
            .split(": ")
            .collect::<Vec<_>>();
        if components.len() < 2 {
            continue;
        }

        let cube_subsets = components
            .last()
            .unwrap()
            .split("; ")
            .map(|subset_line| {
                let mut red = 0;
                let mut green = 0;
                let mut blue = 0;
                subset_line
                    .split(", ")
                    .map(|cube| cube.split(" "))
                    .for_each(|item| {
                        let item = item.collect::<Vec<_>>();
                        let amount = item.first().unwrap().parse().unwrap();
                        match item.last().unwrap().to_owned() {
                            "red" => red = amount,
                            "green" => green = amount,
                            "blue" => blue = amount,
                            _ => panic!(),
                        }
                    });
                CubeSubset { red, green, blue }
            })
            .collect();

        let game = Game {
            id: components[0].parse().unwrap(),
            cube_subsets,
        };
        games.push(game);
    }

    return games;
}

#[path = "./utils/get_input.rs"]
mod get_input;

#[cfg(test)]
mod tests {
    use super::get_input::get_input;

    const NAME: &'static str = "day2";

    #[test]
    fn part1_works() {
        let result = super::part1(get_input(NAME.to_string()));
        assert_eq!(result, 2331);
    }

    #[test]
    fn part2_works() {
        let result = super::part2(get_input(NAME.to_string()));
        assert_eq!(result, 71585);
    }
}

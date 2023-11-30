fn part1(input: String) -> i32 {
    return get_message_marker(input, 4);
}

fn part2(input: String) -> i32 {
    return get_message_marker(input, 14);
}

fn get_message_marker(input: String, start_marker: usize) -> i32 {
    let signal = input;
    let signal_length = signal.len();
    for i in 0..signal_length {
        if i > (signal_length - start_marker) {
            break;
        }

        let packet = unique(&signal[i..(i + start_marker)].chars());
        if packet.len() == start_marker {
            return (i + start_marker).try_into().unwrap();
        }
    }

    return i32::MAX;
}

fn unique(characters: &std::str::Chars) -> Vec<char> {
    let mut unique_characters: Vec<char> = Vec::new();
    for character in characters.clone() {
        if !unique_characters.contains(&character) {
            unique_characters.push(character)
        }
    }

    return unique_characters;
}

#[cfg(test)]
mod tests {
    use std::fs;

    const FILE_PATH: &'static str = "../../Swift/AOC2022/Sources/AOC2022/Inputs/day6.txt";

    #[test]
    fn part1_works() {
        let input = fs::read_to_string(FILE_PATH).expect("Could not read file");
        let result = super::part1(input);
        assert_eq!(result, 1647);
    }

    #[test]
    fn part2_works() {
        let input = fs::read_to_string(FILE_PATH).expect("Could not read file");
        let result = super::part2(input);
        assert_eq!(result, 2447);
    }
}

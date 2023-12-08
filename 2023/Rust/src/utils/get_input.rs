use std::fs;

pub fn get_input(name: String) -> String {
    let file_path = format!("../Swift/Sources/AOC2023/Inputs/{}.txt", name);
    fs::read_to_string(file_path).unwrap()
}

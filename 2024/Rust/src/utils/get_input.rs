use std::fs;

pub fn get_input(name: String) -> String {
    let file_path = format!("../Data/{}.txt", name);
    fs::read_to_string(file_path).unwrap()
}

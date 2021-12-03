def get_input_string(file_path: str) -> str:
    with open(file_path) as data:
        return data.read()

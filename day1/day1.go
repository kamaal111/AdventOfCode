package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"strconv"
	"strings"
)

func main() {
	inputFileBytes, err := ioutil.ReadFile("./input.txt")
	if err != nil {
		log.Fatal(err)
	}

	var increases = 0
	lines := strings.Split(string(inputFileBytes), "\n")
	for lineNumber, line := range lines {
		intLine, err := strconv.Atoi(line)
		if err != nil {
			log.Fatal(err)
		}
		if lineNumber+1 < len(lines) {
			nextLine, err := strconv.Atoi(lines[lineNumber+1])
			if err != nil {
				log.Fatal(err)
			}

			if intLine < nextLine {
				increases++
			}
		}
	}

	fmt.Println(increases)
}

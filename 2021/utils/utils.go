package utils

import (
	"io/ioutil"
	"strings"
)

func GetInputLines(filePath string) ([]string, error) {
	inputFileBytes, err := ioutil.ReadFile(filePath)
	if err != nil {
		return nil, err
	}
	lines := strings.Split(string(inputFileBytes), "\n")
	return lines, nil
}

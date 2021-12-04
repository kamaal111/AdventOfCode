package day4

import (
	"fmt"
	"log"
	"strconv"
	"strings"
)

func Run(input string) {
	fmt.Println("Day 4 Part 1:", Part1(input))
	fmt.Println("Day 4 Part 2:", Part2(input))
}

func Part1(input string) int {
	lines := strings.Split(input, "\n")

	game := makeGame(lines)

	for _, play := range game.plays {
		for _, board := range game.boards {
			board = board.MarkPieces(play)
		}

		for _, board := range game.boards {
			if board.Evaluate() {
				playInt, err := strconv.Atoi(play)
				if err != nil {
					log.Fatal(err)
				}
				return board.UnmarkedCount() * playInt
			}
		}
	}

	return 0
}

func Part2(input string) int {
	return 0
}

func makeGame(lines []string) Game {
	boards := []Board{}
	unmarkedBoards := []Board{}

	for lineNumber := 1; lineNumber < len(lines); lineNumber += 1 {
		line := string(lines[lineNumber])
		if line == "" {
			continue
		}

		splittedLine := strings.Split(line, " ")
		cleanedSplittedLine := []string{}
		for _, piece := range splittedLine {
			if piece != "" {
				cleanedSplittedLine = append(cleanedSplittedLine, piece)
			}
		}
		boardsLength := len(boards)
		if boardsLength > 0 && len(boards[boardsLength-1].pieces) < (5*5) {
			boardToAppend := append(boards[boardsLength-1].pieces, cleanedSplittedLine...)
			boards[boardsLength-1].pieces = boardToAppend
			unmarkedBoards[boardsLength-1].pieces = boardToAppend
		} else {
			boardToAppend := append(boards, Board{pieces: cleanedSplittedLine})
			boards = boardToAppend
			unmarkedBoards = boardToAppend
		}
	}

	plays := strings.Split(lines[0], ",")

	game := Game{
		plays:          plays,
		boards:         boards,
		unmarkedBoards: unmarkedBoards,
	}

	return game
}

type Board struct {
	pieces []string
}

func (board Board) MarkPieces(play string) Board {
	for i := 0; i < len(board.pieces); i += 1 {
		if board.pieces[i] == play {
			board.pieces[i] = "X"
		}
	}
	return board
}

func (board Board) XCount() int {
	count := 0
	for _, piece := range board.pieces {
		if piece == "X" {
			count += 1
		}
	}
	return count
}

func (board Board) Evaluate() bool {
	if board.XCount() < 5 {
		return false
	}

	rows := [][]string{}
	columns := [][]string{}

	for i := 0; i < 5; i += 1 {
		row := []string{}
		column := []string{}
		for j := 0; j < 5; j += 1 {
			row = append(row, board.pieces[i*5+j])
			column = append(column, board.pieces[j*5+i])
		}
		rows = append(rows, row)
		columns = append(columns, column)
	}

	for _, row := range rows {
		count := 0
		for _, piece := range row {
			if piece == "X" {
				count += 1
			}
		}

		if count == 5 {
			return true
		}
	}

	for _, column := range columns {
		count := 0
		for _, piece := range column {
			if piece == "X" {
				count += 1
			}
		}

		if count == 5 {
			return true
		}
	}

	return false
}

func (board Board) UnmarkedCount() int {
	sumUnmarked := 0
	for _, piece := range board.pieces {
		if piece != "X" {
			pieceInt, err := strconv.Atoi(piece)
			if err != nil {
				log.Fatal(err)
			}
			sumUnmarked += pieceInt
		}
	}
	return sumUnmarked
}

type Game struct {
	plays          []string
	boards         []Board
	unmarkedBoards []Board
}

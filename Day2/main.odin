package AoC

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:os"


FILENAME :: `input_day2.txt`
// FILENAME :: `test2.txt`
FILE :: string(#load(FILENAME))

main :: proc() 
{
    p1_result: int = part1_solution();
    p2_result: int = part2_solution();

    fmt.println("Part 1 Result: ", p1_result)
    fmt.println("Part 2 Result: ", p2_result)
}

OUTCOME :: enum
{
    LOSE,
    WIN,
    DRAW,
}
HANDS :: struct
{
    rock : []string,
    paper : []string,
    scissors : []string,
}

part1_solution :: proc() -> int 
{
    using fmt
    file_lines := strings.split_lines(FILE)
    defer delete(file_lines)
    
    outcomes := map[OUTCOME]int {
        .WIN = 6,
        .LOSE = 0,
        .DRAW = 3,
    }
    defer delete(outcomes)

    hands : HANDS
    hands.rock = {"A", "X"}
    hands.paper = {"B", "Y"}
    hands.scissors = {"C", "Z"}

    result : int = 0
    
    for l in file_lines 
    {
        // println("LINE", l)   

        ss := strings.split(l, " ")

        if ss[0] == hands.rock[0] && ss[1] == hands.rock[1]
        {
            result += outcomes[.DRAW] + 1 //+1 for chosing rock
        }
        else if ss[0] == hands.rock[0] && ss[1] == hands.paper[1]
        {
            result += outcomes[.WIN] + 2 // +2 for chosing paper
        }
        else if ss[0] == hands.rock[0] && ss[1] == hands.scissors[1]
        {
            result += outcomes[.LOSE] + 3 // +3 for chosing scissors
        }
        else if ss[0] == hands.paper[0] && ss[1] == hands.rock[1]
        {
            result += outcomes[.LOSE] + 1 //+1 for chosing rock
        }
        else if ss[0] == hands.paper[0] && ss[1] == hands.paper[1]
        {
            result += outcomes[.DRAW] + 2 // +2 for chosing paper
        }
        else if ss[0] == hands.paper[0] && ss[1] == hands.scissors[1]
        {
            result += outcomes[.WIN] + 3 // +3 for chosing scissors
        }
        else if ss[0] == hands.scissors[0] && ss[1] == hands.rock[1]
        {
            result += outcomes[.WIN] + 1 //+1 for chosing rock
        }
        else if ss[0] == hands.scissors[0] && ss[1] == hands.paper[1]
        {
            result += outcomes[.LOSE] + 2 // +2 for chosing paper
        }
        else if ss[0] == hands.scissors[0] && ss[1] == hands.scissors[1]
        {
            result += outcomes[.DRAW] + 3 // +3 for chosing scissors
        }
   }

    return result;
}

part2_solution :: proc() -> int
{
    using fmt
    file_lines := strings.split_lines(FILE)
    defer delete(file_lines)
    
    outcomes := map[string]int {
        "Z" = 6, // win
        "X" = 0, // lose
        "Y" = 3, // draw
        "A" = 1,
        "B" = 2,
        "C" = 3,
    }
    defer delete(outcomes)

    hands : HANDS
    hands.rock = {"A", "X"}
    hands.paper = {"B", "Y"}
    hands.scissors = {"C", "Z"}
    
    result : int = 0
    
    for l in file_lines 
    {
        // println("LINE", l)   

        ss := strings.split(l, " ")

        if ss[1] == hands.paper[1] {
            // draw
            result += outcomes[ss[1]] + outcomes[ss[0]]
        }
        else if ss[1] == hands.rock[1] {
            // lose
            if ss[0] == hands.rock[0] {
                result += outcomes[ss[1]] + outcomes[hands.scissors[0]]
            }
            else if ss[0] == hands.paper[0] {
                result += outcomes[ss[1]] + outcomes[hands.rock[0]]
            }
            else if ss[0] == hands.scissors[0] {
                result += outcomes[ss[1]] + outcomes[hands.paper[0]]
            }
        }
        else if ss[1] == hands.scissors[1]{
            // win
            if ss[0] == hands.rock[0] {
                result += outcomes[ss[1]] + outcomes[hands.paper[0]]
            }
            else if ss[0] == hands.paper[0] {
                result += outcomes[ss[1]] + outcomes[hands.scissors[0]]
            }
            else if ss[0] == hands.scissors[0] {
                result += outcomes[ss[1]] + outcomes[hands.rock[0]]
            }
        }
   }

    return result;
}

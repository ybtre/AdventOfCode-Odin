package AoC

import "core:fmt"
import "core:strings"
import "core:strconv"

// FILENAME :: `input_day2.txt`
FILENAME :: `test2.txt`
FILE :: string(#load(FILENAME))

main :: proc() 
{
    p1_result: int = part1_solution();
    // part2_solution();
}

// HANDS :: enum
// {
//     A = 1,
//     X = 1,
//     B = 2,
//     Y = 2,
//     C = 3,
//     Z = 3,
// }
OUTCOME :: enum
{
    LOSE = 0,
    WIN = 6,
    DRAW = 3,
}
HANDS :: struct
{
    rock : string,
    paper : string,
    scissors : string,
}

part1_solution :: proc() -> int 
{
    using fmt
    file_lines := strings.split_lines(FILE)

    hands : HANDS
    hands.rock = "AX"
    hands.paper = "BY"
    hands.scissors = "CZ"

    result : int = 0
    
    for l in file_lines 
    {
        println("LINE", l)    
        for e in l 
        {
            if !strings.is_space(e)
            {            
                println("ELEMENT", e)
                // if e == hands.rock
                // {
                //     result += hands.rock
                // }
            }
        }  
    }
    return result;
}

part2_solution :: proc() 
{
      // Split file into int strings.
      file_lines := strings.split_lines(FILE)

      for l in file_lines {
          parsed_int, ok := strconv.parse_int(l)
          if ok {
          } else {
          }
      }
}

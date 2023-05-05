package AoC

import "core:fmt"
import "core:strings"
import "core:strconv"

// FILENAME :: `input_day2.txt`
FILENAME :: `test2.txt`
FILE :: string(#load(FILENAME))

main :: proc() {
    p1_result: int = part1_solution();
    part2_solution();
 
    fmt.println("highest_calories:", p1_result)
}

part1_solution :: proc() -> int {
    // Split file into int strings.
    file_lines := strings.split_lines(FILE)

    for l in file_lines {
        parsed_int, ok := strconv.parse_int(l)
        
        if ok {
        } else {
        }
    }
    return 0;
}

part2_solution :: proc() {
      // Split file into int strings.
      file_lines := strings.split_lines(FILE)

      for l in file_lines {
          parsed_int, ok := strconv.parse_int(l)
          if ok {
          } else {
          }
      }
}

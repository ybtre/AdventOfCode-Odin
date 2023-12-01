package AoC

import "core:fmt"
import "core:strings"
import "core:strconv"
import "vendor:raylib"

FILENAME :: `input_day1.txt`
FILE :: string(#load(FILENAME))

main :: proc() {
    p1_result: int = part1_solution();
    part2_solution();
 
    fmt.printf("highest_calories: %i\n", p1_result)
}

part1_solution :: proc() -> int {
    // Split file into int strings.
    file_lines := strings.split_lines(FILE)

    // Calc max!
    highest_calories: int = 0
    current_calories: int = 0
    for l in file_lines {
        parsed_int, ok := strconv.parse_int(l)
        
        if ok {
            current_calories += parsed_int
        } else {
            // Pt 1.
            highest_calories = max(current_calories, highest_calories)
        
            current_calories = 0
        }
    }
    return highest_calories;
}

part2_solution :: proc() {
      // Split file into int strings.
      file_lines := strings.split_lines(FILE)

      // Calc max!
      top_one:          int = 0
      top_two:          int = 0
      top_three:        int = 0

      current_calories: int = 0
    

      for l in file_lines {
          parsed_int, ok := strconv.parse_int(l)
          if ok {
              current_calories += parsed_int
          } else {
              switch {
                case current_calories >= top_one:
                    top_three = top_two
                    top_two = top_one
                    top_one = current_calories
                case top_one > current_calories && current_calories >= top_two:
                    top_three = top_two
                    top_two = current_calories
                case top_two > current_calories && current_calories >= top_three:
                    top_three = current_calories
              }
              current_calories = 0
          }
      }
      fmt.printf("top one: %i, top two: %i, top three: %i\n", top_one, top_two, top_three)
      fmt.printf("top 3 sum: %i\n", top_one + top_two + top_three)
}

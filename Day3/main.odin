package AoC

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:os"


// FILENAME :: `input_day3.txt`
FILENAME :: `test3.txt`
FILE :: string(#load(FILENAME))

main :: proc() 
{
    p1_result: int = part1_solution();
    p2_result: int = part2_solution();

    fmt.println("Part 1 Result: ", p1_result)
    fmt.println("Part 2 Result: ", p2_result)
}

part1_solution :: proc() -> int 
{
    using fmt
    file_lines := strings.split_lines(FILE)
    defer delete(file_lines)

    duplicate_items : [dynamic]string
    defer delete(duplicate_items)

    uppercase_lookup : string = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    result : int = 0
    
    for line in file_lines 
    {
        rucksack := strings.split(line, "")
        
        for x in 0..<len(rucksack) / 2 {
            for y in len(rucksack) / 2..< len(rucksack) {
                if rucksack[y] == rucksack[x]
                {
                    append(&duplicate_items, rucksack[x])
                    break
                }
            }
        }
    }

    // for letter in uppercase_lookup 
    // {
    //     println(letter)
    // }

    for dupe in duplicate_items {
        println("dupes", dupe)
    }

    return result;
}

part2_solution :: proc() -> int
{
    using fmt
    file_lines := strings.split_lines(FILE)
    defer delete(file_lines)
    
    result : int = 0
    
    for l in file_lines 
    {
    }

    return result;
}

package AoC

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:unicode"

FILENAME :: `input_day3.txt`
// FILENAME :: `test3.txt`
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

        append(&duplicate_items, part1_dupes(rucksack))
    }

    counter : int = 0
    for item in duplicate_items {
        if unicode.is_upper(rune(item[0]))
        {
            // println("Code: ", item[0], " Letter: ", item, " int: ", int(item[0]), " final: ", int(item[0])-38)
            result += int(item[0]) - 38
        }
        else {
            // println("Code: ", item[0], " Letter: ", item, " int: ", int(item[0]), " final: ", int(item[0])-96)
            result += int(item[0]) - 96
        }
    }
    
    return result;
}

part1_dupes :: proc(rucksack: []string) -> string
{    
    half_len := len(rucksack) / 2
    for x in 0..<half_len {
        for y in half_len..< len(rucksack) {
            if rucksack[y] == rucksack[x]
            {
                return rucksack[x]
            }
        }
    }

    return ""
}

part2_solution :: proc() -> int
{
    using fmt
    file_lines := strings.split_lines(FILE)
    defer delete(file_lines)

    duplicate_items : [dynamic]string
    defer delete(duplicate_items)

    rucksacks := [3]string

    uppercase_lookup : string = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    result : int = 0

    for i := 0; i < len(file_lines); i += 3
    {
        rucksacks[0] = strings.split(file_lines[i], "")
        rucksacks[1] = strings.split(file_lines[i + 1], "")
        rucksacks[2] = strings.split(file_lines[i + 2], "")

        append(&duplicate_items, part2_dupes(rucksacks))
    }

    counter : int = 0
    for item in duplicate_items {
        for letter in uppercase_lookup
        {
            counter +=1
            if u8(letter) == item[0]
            {
                result += counter + 26
                counter = 0
                break
            }

            if u8(letter)+32 == item[0]
            {
                // println("Letter: ", u8(letter)+32, " Item: ", item[0])
                result += counter
                counter = 0
                break
            }
        }
    }
    counter : int = 0
    for item in duplicate_items {
        if unicode.is_upper(rune(item[0]))
        {
            // println("Code: ", item[0], " Letter: ", item, " int: ", int(item[0]), " final: ", int(item[0])-38)
            result += int(item[0]) - 38
        }
        else {
            // println("Code: ", item[0], " Letter: ", item, " int: ", int(item[0]), " final: ", int(item[0])-96)
            result += int(item[0]) - 96
        }
    }
    
    return result;
}

part2_dupes :: proc(rucksack: []string) -> string
{    
    half_len := len(rucksack) / 2
    for x in 0..<half_len {
        for y in half_len..< len(rucksack) {
            if rucksack[y] == rucksack[x]
            {
                return rucksack[x]
            }
        }
    }

    return ""
}

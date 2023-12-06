package AoC

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:slice"
import "core:mem"
import "core:unicode"
import "core:unicode/utf8"
import "core:time"

FILENAME :: `input.txt`
//FILENAME :: `demo1.txt`
//FILENAME :: `demo2.txt`
FILE :: string(#load(FILENAME))

main :: proc() 
{
    arena_backing := make([]u8, 16 * mem.Megabyte)
    solution_arena: mem.Arena
    mem.arena_init(&solution_arena, arena_backing)

    alloc := mem.arena_allocator(&solution_arena)
    context.allocator = alloc

    fmt.println("---------------------------------------------------------------------")
    part1_start := time.now()
        p1_result: int = part1_solution()
    part1_end := time.now()
    fmt.println("PART 1:", p1_result, "Time:", time.diff(part1_start, part1_end), "Memory Used:", solution_arena.peak_used)

    part2_start := time.now()
        p2_result: int = part2_solution()
    part2_end := time.now()
    fmt.println("PART 2:", p2_result, "Time:", time.diff(part2_start, part2_end), "Memory Used:", solution_arena.peak_used)
    fmt.println("---------------------------------------------------------------------\n")
}

part1_solution :: proc() -> int 
{
    using fmt
    file_lines := strings.split_lines(FILE)
    defer delete(file_lines)

    digits : [2]rune

    result : int = 0
    
    for line in file_lines 
    {
        //printf("LINE: %s\n", line) 

        digits_count := 0;
        for symbol in line
        {
            //printf("SYMBOL: %r\n", symbol) 
            
            if unicode.is_digit(symbol) 
            {
                //printf("DIGIT: %r\n", symbol) 
                digits_count += 1

                if digits_count == 1
                {
                    digits[0] = symbol 
                }
            }
        }

        last_digit := 0;
        for symbol in line
        {
            if unicode.is_digit(symbol) 
            {
                last_digit += 1
                if last_digit == digits_count
                {
                    digits[1] = symbol 
                }
            }
        }

        //printf("FIRST DIGIT: %r\n", digits[0])
        //printf("LAST DIGIT: %r\n", digits[1])

        concat := strings.concatenate({utf8.runes_to_string({digits[0]}), utf8.runes_to_string({digits[1]})})
        //printf("CONCAT: %i\n", strconv.atoi(concat))
        result += strconv.atoi(concat);
    }

    return result
}

line_contains :: proc(LINE, KEY : string) -> [dynamic]MATCH
{
    result := make([dynamic]MATCH)
    x :: 0
        
    if strings.contains(LINE, KEY)
    {
        temp := strings.clone(LINE)
        count :=  strings.count(temp, KEY)
        for i := 0; i < count; i += 1
        {
            new_match : MATCH
            new_match.item = KEY
            new_match.idx, new_match.width = strings.index_multi(temp, {KEY})

            append(&result, new_match)
            
            temp,_ = strings.replace(temp, KEY, strings.repeat(" ", len(KEY)), 1)
        }
    }

    return result
}

MATCH :: struct {
    item    : string,
    idx     : int,
    width   : int,
}

part2_solution :: proc() -> int
{
    using fmt
    result : int = 0

    file_lines := strings.split_lines(FILE)
    defer delete(file_lines)

    matches := make([dynamic]MATCH)
    defer delete(matches)

    //parse and find matches
    for line in file_lines 
    {
        //printf("LINE: %s\n", line) 

        //find matches
        append(&matches, ..line_contains(line, "one"))
        append(&matches, ..line_contains(line, "two")[:])
        append(&matches, ..line_contains(line, "three")[:])
        append(&matches, ..line_contains(line, "four")[:])
        append(&matches, ..line_contains(line, "five")[:])
        append(&matches, ..line_contains(line, "six")[:])
        append(&matches, ..line_contains(line, "seven")[:])
        append(&matches, ..line_contains(line, "eight")[:])
        append(&matches, ..line_contains(line, "nine")[:])

        append(&matches, ..line_contains(line, "1")[:])
        append(&matches, ..line_contains(line, "2")[:])
        append(&matches, ..line_contains(line, "3")[:])
        append(&matches, ..line_contains(line, "4")[:])
        append(&matches, ..line_contains(line, "5")[:])
        append(&matches, ..line_contains(line, "6")[:])
        append(&matches, ..line_contains(line, "7")[:])
        append(&matches, ..line_contains(line, "8")[:])
        append(&matches, ..line_contains(line, "9")[:])
        
        //sort found matches
        slice.sort_by(matches[:], proc(i, j:MATCH) -> bool { return i.idx < j.idx })

        //convert words into digits
        for i := 0; i < len(matches); i += 1
        {
            if matches[i].item == "one"
            {
                matches[i].item = "1"
                matches[i].width = 1
            }
            if matches[i].item == "two"
            {
                matches[i].item = "2"
                matches[i].width = 1
            }
            if matches[i].item == "three"
            {
                matches[i].item = "3"
                matches[i].width = 1
            }
            if matches[i].item == "four"
            {
                matches[i].item = "4"
                matches[i].width = 1
            }
            if matches[i].item == "five"
            {
                matches[i].item = "5"
                matches[i].width = 1
            }
            if matches[i].item == "six"
            {
                matches[i].item = "6"
                matches[i].width = 1
            }
            if matches[i].item == "seven"
            {
                matches[i].item = "7"
                matches[i].width = 1
            }
            if matches[i].item == "eight"
            {
                matches[i].item = "8"
                matches[i].width = 1
            }
            if matches[i].item == "nine"
            {
                matches[i].item = "9"
                matches[i].width = 1
            }
        }

        //calculate result
        concat := strings.concatenate({matches[0].item, matches[len(matches)-1].item})
        //printf("CONCAT: %s\n", concat)

        //calculate result
        result += strconv.atoi(concat)

        // reset for next line
        remove_range(&matches, 0, len(matches))
    }

    return result
}

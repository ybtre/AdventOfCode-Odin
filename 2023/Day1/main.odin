package AoC

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:slice"
import "core:mem"
import "core:unicode"
import "core:unicode/utf8"

FILENAME :: `input.txt`
//FILENAME :: `demo1.txt`
//FILENAME :: `demo2.txt`
FILE :: string(#load(FILENAME))

main :: proc() 
{
    p1_result: int = part1_solution()
    p2_result: int = part2_solution()

    fmt.println("Part 1 Result: ", p1_result)
    fmt.println("Part 2 Result: ", p2_result)
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
        printf("LINE: %s\n", line) 

        if strings.contains(line, "one")
        {
            //printf("CONTAINS: %s ", "one")
            //printf(" AT: %i COUNT %i\n", strings.index_multi(line, {"one"}))

            new_match : MATCH
            new_match.item = "one"
            new_match.idx, new_match.width = strings.index_multi(line, {"one"})

            append(&matches, new_match)

            //printf("ITEM: %s, AT %i, COUNT %i\n", new_match.item, new_match.idx, new_match.width)
        }
        if strings.contains(line, "two")
        {
            new_match : MATCH
            new_match.item = "two"
            new_match.idx, new_match.width = strings.index_multi(line, {"two"})

            append(&matches, new_match)
        }
        if strings.contains(line, "three")
        {
            new_match : MATCH
            new_match.item = "three"
            new_match.idx, new_match.width = strings.index_multi(line, {"three"})

            append(&matches, new_match)
        }
        if strings.contains(line, "four")
        {
            new_match : MATCH
            new_match.item = "four"
            new_match.idx, new_match.width = strings.index_multi(line, {"four"})

            append(&matches, new_match)
        }
        if strings.contains(line, "five")
        {
            new_match : MATCH
            new_match.item = "five"
            new_match.idx, new_match.width = strings.index_multi(line, {"five"})

            append(&matches, new_match)
        }
        if strings.contains(line, "six")
        {
            new_match : MATCH
            new_match.item = "six"
            new_match.idx, new_match.width = strings.index_multi(line, {"six"})

            append(&matches, new_match)
        }
        if strings.contains(line, "seven")
        {
            new_match : MATCH
            new_match.item = "seven"
            new_match.idx, new_match.width = strings.index_multi(line, {"seven"})

            append(&matches, new_match)
        }
        if strings.contains(line, "eight")
        {
            new_match : MATCH
            new_match.item = "eight"
            new_match.idx, new_match.width = strings.index_multi(line, {"eight"})

            append(&matches, new_match)
        }
        if strings.contains(line, "nine")
        {
            new_match : MATCH
            new_match.item = "nine"
            new_match.idx, new_match.width = strings.index_multi(line, {"nine"})

            append(&matches, new_match)
        }

        if strings.contains(line, "1")
        {
            new_match : MATCH
            new_match.item = "1"
            new_match.idx, new_match.width = strings.index_multi(line, {"1"})

            append(&matches, new_match)
            //printf("ITEM: %s, AT %i, COUNT %i\n", new_match.item, new_match.idx, new_match.width)
        }
        if strings.contains(line, "2")
        {
            new_match : MATCH
            new_match.item = "2"
            new_match.idx, new_match.width = strings.index_multi(line, {"2"})

            append(&matches, new_match)
            //printf("ITEM: %s, AT %i, COUNT %i\n", new_match.item, new_match.idx, new_match.width)
        }
        if strings.contains(line, "3")
        {
            new_match : MATCH
            new_match.item = "3"
            new_match.idx, new_match.width = strings.index_multi(line, {"3"})

            append(&matches, new_match)
            //printf("ITEM: %s, AT %i, COUNT %i\n", new_match.item, new_match.idx, new_match.width)
        }
        if strings.contains(line, "4")
        {
            new_match : MATCH
            new_match.item = "4"
            new_match.idx, new_match.width = strings.index_multi(line, {"4"})

            append(&matches, new_match)
            //printf("ITEM: %s, AT %i, COUNT %i\n", new_match.item, new_match.idx, new_match.width)
        }
        if strings.contains(line, "5")
        {
            new_match : MATCH
            new_match.item = "5"
            new_match.idx, new_match.width = strings.index_multi(line, {"5"})

            append(&matches, new_match)
            //printf("ITEM: %s, AT %i, COUNT %i\n", new_match.item, new_match.idx, new_match.width)
        }
        if strings.contains(line, "6")
        {
            new_match : MATCH
            new_match.item = "6"
            new_match.idx, new_match.width = strings.index_multi(line, {"6"})

            append(&matches, new_match)
            //printf("ITEM: %s, AT %i, COUNT %i\n", new_match.item, new_match.idx, new_match.width)
        }
        if strings.contains(line, "7")
        {
            new_match : MATCH
            new_match.item = "7"
            new_match.idx, new_match.width = strings.index_multi(line, {"7"})

            append(&matches, new_match)
            //printf("ITEM: %s, AT %i, COUNT %i\n", new_match.item, new_match.idx, new_match.width)
        }
        if strings.contains(line, "8")
        {
            new_match : MATCH
            new_match.item = "8"
            new_match.idx, new_match.width = strings.index_multi(line, {"8"})

            append(&matches, new_match)
            //printf("ITEM: %s, AT %i, COUNT %i\n", new_match.item, new_match.idx, new_match.width)
        }
        if strings.contains(line, "9")
        {
            new_match : MATCH
            new_match.item = "9"
            new_match.idx, new_match.width = strings.index_multi(line, {"9"})

            append(&matches, new_match)
            //printf("ITEM: %s, AT %i, COUNT %i\n", new_match.item, new_match.idx, new_match.width)
        }


        //sort found matches
        slice.sort_by(matches[:], proc(i, j:MATCH) -> bool { return i.idx < j.idx })

        //convert strings into ints
        for i := 0; i < len(matches); i += 1
        {
            if matches[i].item == "one"
            {
                matches[i].item = "1"
            }
            if matches[i].item == "two"
            {
                matches[i].item = "2"
            }
            if matches[i].item == "three"
            {
                matches[i].item = "3"
            }
            if matches[i].item == "four"
            {
                matches[i].item = "4"
            }
            if matches[i].item == "five"
            {
                matches[i].item = "5"
            }
            if matches[i].item == "six"
            {
                matches[i].item = "6"
            }
            if matches[i].item == "seven"
            {
                matches[i].item = "7"
            }
            if matches[i].item == "eight"
            {
                matches[i].item = "8"
            }
            if matches[i].item == "nine"
            {
                matches[i].item = "9"
            }
        }

        //calculate result
        concat := strings.concatenate({matches[0].item, matches[len(matches)-1].item})
        printf("CONCAT: %s\n", concat)

        //calculate result
        result += strconv.atoi(concat)

        // reset for next loop
        remove_range(&matches, 0, len(matches))
    }

    return result
}
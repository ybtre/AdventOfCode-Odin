package day3

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:slice"
import "core:mem"
import "core:unicode"
import "core:unicode/utf8"
import "core:time"

INPUT :: `input.txt`
DEMO1 :: `demo1.txt`
DEMO2 :: `demo2.txt`
FILE :: string(#load(INPUT))

main :: proc() 
{
    using fmt

    arena_backing := make([]u8, 16 * mem.Megabyte)
    solution_arena: mem.Arena
    mem.arena_init(&solution_arena, arena_backing)

    alloc := mem.arena_allocator(&solution_arena)
    context.allocator = alloc

    println("---------------------------------------------------------------------")
    part1_start := time.now()
        p1_result: int = part1_solution()
    part1_end := time.now()

    println("PART 1:", p1_result, "Time:", time.diff(part1_start, part1_end), "Memory Used:", solution_arena.peak_used)
    

    part2_start := time.now()
        p2_result: int = part2_solution()
    part2_end := time.now()

    println("PART 2:", p2_result, "Time:", time.diff(part2_start, part2_end), "Memory Used:", solution_arena.peak_used)
    println("---------------------------------------------------------------------\n")
}

//=============================================================================
STAR    :: '*'
POUND   :: '#'
PLUS    :: '+'
MINUS   :: '-'
DOLLAR  :: '$'
PERCENT :: '%'
EQUALS  :: '='
MONKEY  :: '@'
DIVIDE  :: '/'
REF     :: '&'

SYMBOL :: struct 
{
    type : rune,
    idx  : int,
    idy  : int,
}

DIGIT :: struct 
{
    val   : int,
    idx   : int,
    idy   : int,
    width : int,
}
//=============================================================================


part1_solution :: proc() -> int 
{
    using fmt
    using strings
    using strconv

    file_lines := split_lines(FILE)
    defer delete(file_lines)

    result : int

    symbols := make([dynamic]SYMBOL)
    numbers := make([dynamic]DIGIT)

    idx := 0
    idy := 0
    temp_d : string
    file_height := 0
    for line := 0; line < len(file_lines); line += 1 
    {
        file_height += 1
        using unicode
        //println("LINE:", file_lines[line])

        idx = 0

        //for c in file_lines[line] {
        for r := 0; r < len(file_lines[line]); r += 1 {
            c := file_lines[line][r]
            if c == STAR
            {
                append(&symbols, SYMBOL{ STAR, idx, idy })
            }
            if c == POUND
            {
                append(&symbols, SYMBOL{ POUND, idx, idy })
            }
            if c == PLUS
            {
                append(&symbols, SYMBOL{ PLUS, idx, idy })
            }
            if c == MINUS
            {
                append(&symbols, SYMBOL{ MINUS, idx, idy })
            }
            if c == DOLLAR
            {
                append(&symbols, SYMBOL{ DOLLAR, idx, idy })
            }
            if c == PERCENT
            {
                append(&symbols, SYMBOL{ PERCENT, idx, idy })
            }
            if c == EQUALS
            {
                append(&symbols, SYMBOL{ EQUALS, idx, idy })
            }
            if c == MONKEY
            {
                append(&symbols, SYMBOL{ MONKEY, idx, idy })
            }
            if c == DIVIDE
            {
                append(&symbols, SYMBOL{ DIVIDE, idx, idy })
            }
            if c == REF
            {
                append(&symbols, SYMBOL{ REF, idx, idy })
            }

            if is_digit(rune(c))
            {
                r := utf8.runes_to_string({rune(c)})
                temp_d = concatenate({temp_d, r})
            }
            else
            {
                if atoi(temp_d) != 0
                {
                    append(&numbers, DIGIT{ atoi(temp_d), idx - len(temp_d), idy, len(temp_d) })
                    temp_d = {}
                }
            }

            idx += 1
        }
        idy += 1
    }

    //println("SYMBOLS===============")
    for s in symbols {
        //println(s)
    }

    //println("NUMBERS ===============")
    for d in numbers{
        //println("NUMBERS:", d)
    }

    for i := 0; i < len(numbers); i+=1
    {
        //n := numbers[i]
        //println(n.val, n.idx, n.idy, n.width)
    }

    //println("GEARs ===============")
    part_numbers := make([dynamic]int)
    for s in symbols
    {
        using unicode 

        if s.idy - 1 != -1
        {
            above_line := file_lines[s.idy - 1]
            //println("A:", above_line, "L", file_lines[s.idy], "S", s.type)
            //println("S A", utf8.runes_to_string({ rune(above_line[s.idx]) }))
            //println("S A L", utf8.runes_to_string({ rune(above_line[s.idx-1]) }))
            if s.idx - 1 != -1
            {
                top_left := utf8.runes_to_string({ rune(above_line[s.idx - 1]) })
                if is_digit(rune(top_left[0]))
                {
                    for n in numbers
                    {
                        if n.idy == s.idy - 1
                        {
                            if n.idx + n.width - 1 == s.idx - 1
                            {
                                //println("TL",n)
                                append(&part_numbers, n.val)
                            }
                        }
                    }
                }
            }
            top := utf8.runes_to_string({ rune(above_line[s.idx]) })
            if is_digit(rune(top[0]))
            {
                for n in numbers
                {
                    if n.idy == s.idy - 1
                    {
                        if n.idx == s.idx
                        {
                            //println("T",n)
                            append(&part_numbers, n.val)
                        }
                        else if n.idx + n.width - 1 == s.idx
                        {
                            //println("T",n)
                            append(&part_numbers, n.val)
                        }
                        else if n.idx + 1 == s.idx
                        {
                            append(&part_numbers, n.val)
                        }
                    }
                }
            }
            if s.idx + 1 <= len(above_line)
            {
                top_right := utf8.runes_to_string({ rune(above_line[s.idx+1]) })
                if is_digit(rune(top_right[0]))
                {
                    for n in numbers
                    {
                        if n.idy == s.idy - 1
                        {
                            //println(n.idx, s.idx+1)
                            if n.idx == s.idx +1
                            {
                                //println("TR",n)
                                append(&part_numbers, n.val)
                            }
                        }
                    }
                }
            }
        }

        same_line := file_lines[s.idy]
        //println("A:", same_line, "L", file_lines[s.idy], "S", s.type)
        //println("S A", utf8.runes_to_string({ rune(above_line[s.idx]) }))
        //println("S A L", utf8.runes_to_string({ rune(above_line[s.idx-1]) }))
        if s.idx - 1 != -1
        {
            left := utf8.runes_to_string({ rune(same_line[s.idx - 1]) })
            if is_digit(rune(left[0]))
            {
                for n in numbers
                {
                    if n.idy == s.idy
                    {
                        if n.idx + n.width - 1 == s.idx - 1
                        {
                            //println("L",n)
                            append(&part_numbers, n.val)
                        }
                    }
                }
            }
        }
        if s.idx + 1 <= len(same_line)
        {
            right := utf8.runes_to_string({ rune(same_line[s.idx + 1]) })
            if is_digit(rune(right[0]))
            {
                for n in numbers
                {
                    if n.idy == s.idy
                    {
                        //println(n.idx, s.idx+1)
                        if n.idx == s.idx +1
                        {
                            //println("R",n)
                            append(&part_numbers, n.val)
                        }
                    }
                }
            }
        }
        //println("ABOVE:", above_line[s.idx])

        //println(s.idy + 1, file_height - 1, file_lines[s.idy])
        if s.idy + 1 < file_height 
        {
            below_line := file_lines[s.idy + 1]
            //println(below_line)
            //println("B:", below_line, "L", file_lines[s.idy], "S", s.type)
            //println("S A", utf8.runes_to_string({ rune(above_line[s.idx]) }))
            //println("S A L", utf8.runes_to_string({ rune(above_line[s.idx-1]) }))
            if s.idx -1 != -1
            {
                bot_left := utf8.runes_to_string({ rune(below_line[s.idx - 1]) })
                if is_digit(rune(bot_left[0]))
                {
                    for n in numbers
                    {
                        if n.idy == s.idy + 1
                        {
                            if n.idx + n.width - 1 == s.idx - 1
                            {
                                //println("BL",n)
                                append(&part_numbers, n.val)
                            }
                        }
                    }
                }
            }
            bot := utf8.runes_to_string({ rune(below_line[s.idx]) })
            if is_digit(rune(bot[0]))
            {
                for n in numbers
                {
                    if n.idy == s.idy + 1
                    {
                        //println(n.idx, s.idx)
                        if n.idx == s.idx
                        {
                            //println("B",n)
                            append(&part_numbers, n.val)
                        }
                        else if n.idx + n.width - 1 == s.idx
                        {
                            //println("B",n)
                            append(&part_numbers, n.val)
                        }
                        else if n.idx + 1 == s.idx
                        {
                            append(&part_numbers, n.val)
                        }
                    }
                }
            }
            if s.idx + 1 <= len(below_line)
            {
                bot_right := utf8.runes_to_string({ rune(below_line[s.idx + 1]) })
                if is_digit(rune(bot_right[0]))
                {
                    for n in numbers
                    {
                        if n.idy == s.idy + 1
                        {
                            //println(n.idx, s.idx+1)
                            if n.idx == s.idx +1
                            {
                                //println("BR",n)
                                append(&part_numbers, n.val)
                            }
                        }
                    }
                }
            }
        }
    }

    for p in part_numbers 
    {
        println("GEAR:", p)
        result += p
    }

    return result
}

part2_solution :: proc() -> int
{
    using fmt
    using strings
    using strconv

    file_lines := split_lines(FILE)
    defer delete(file_lines)

    result : int

    for line in file_lines {

    }

    return result
}

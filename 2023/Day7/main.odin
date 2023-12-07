package day7

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:mem"
import "core:unicode"
import "core:unicode/utf8"
import "core:time"

INPUT :: `input.txt`
DEMO1 :: `demo1.txt`
DEMO2 :: `demo2.txt`
FILE :: string(#load(DEMO1))

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

    println()
    println("PART 1:", p1_result, "Time:", time.diff(part1_start, part1_end), "Memory Used:", solution_arena.peak_used)
    

    println()
    part2_start := time.now()
        p2_result: int = part2_solution()
    part2_end := time.now()

    println()
    println("PART 2:", p2_result, "Time:", time.diff(part2_start, part2_end), "Memory Used:", solution_arena.peak_used)
    println("---------------------------------------------------------------------\n")
}

//=============================================================================
TYPE :: enum {
    NONE,
    five_of_a_kind,
    four_of_a_kind,
    full_house,
    three_of_a_kind,
    two_pair,
    one_pair,
    high_card
}

HAND :: struct {
    hand : string,
    bid  : int,
    rank : int,
    type : TYPE
}
//=============================================================================
five_of_a_kind :: proc(HAND : string) -> bool 
{
    using fmt

    matches_count := 0
    matching_rune : rune
    ml: for i := 0; i < len(HAND); i += 1
    {
        matches_count = 0
        for j := i; j < len(HAND); j += 1
        {
            if HAND[i] == HAND[j]
            {
                //println(i, j)
                matches_count += 1
                matching_rune = rune(HAND[i])
            }
        }

        //println(matches_count)
        if matches_count == 5
        {
            return true
        }
    }

    return false
}

four_of_a_kind :: proc(HAND : string) -> bool
{
    using fmt

    matches_count := 0
    matching_rune : rune
    ml: for i := 0; i < len(HAND); i += 1
    {
        matches_count = 0
        for j := i; j < len(HAND); j += 1
        {
            if HAND[i] == HAND[j]
            {
                //println(i, j)
                matches_count += 1
                matching_rune = rune(HAND[i])
            }
        }

        //println(matches_count)
        if matches_count == 4
        {
            return true
        }
    }

    return false
}

full_house :: proc(HAND : string) -> bool
{
    using fmt

    matches_count := 0
    matching_rune : rune
    ml: for i := 0; i < len(HAND); i += 1
    {
        matches_count = 0
        for j := i; j < len(HAND); j += 1
        {
            if HAND[i] == HAND[j]
            {
                //println(i, j)
                matches_count += 1
                matching_rune = rune(HAND[i])
            }
        }

        if matches_count == 3
        {
            is_three_of_a_kind := false
            for o := 0; o < len(HAND); o += 1
            {
                for p := o + 1; p < len(HAND); p += 1
                {
                    if rune(HAND[o]) != matching_rune && rune(HAND[p]) != matching_rune
                    {
                        if HAND[o] == HAND[p]
                        {
                            //println(rune(HAND[o]), rune(HAND[p]))
                            return true
                        }
                    }
                }
            }
        }
    }

    return false
}

three_of_a_kind :: proc(HAND : string) -> bool
{
    using fmt

    matches_count := 0
    matching_rune : rune
    ml: for i := 0; i < len(HAND); i += 1
    {
        matches_count = 0
        for j := i; j < len(HAND); j += 1
        {
            if HAND[i] == HAND[j]
            {
                //println(i, j)
                matches_count += 1
                matching_rune = rune(HAND[i])
            }
        }

        if matches_count == 3
        {
            is_three_of_a_kind := false
            for o := 0; o < len(HAND); o += 1
            {
                for p := o + 1; p < len(HAND); p += 1
                {
                    if rune(HAND[o]) != matching_rune && rune(HAND[p]) != matching_rune
                    {
                        if HAND[o] != HAND[p]
                        {
                            //println(rune(HAND[o]), rune(HAND[p]))
                            return true
                        }
                    }
                }
            }
        }
    }

    return false
}
find_hand_type :: proc (H_VALUE : string) -> TYPE
{
    using fmt

    is_five_of_a_kind := five_of_a_kind(H_VALUE)
    if is_five_of_a_kind
    {
        return .five_of_a_kind
    }

    is_four_of_a_kind := four_of_a_kind(H_VALUE)
    if is_four_of_a_kind
    {
        return .four_of_a_kind
    }

    is_full_house := full_house(H_VALUE)
    if is_full_house
    {
        return .full_house
    }

    is_three_of_a_kind := three_of_a_kind(H_VALUE)
    if is_three_of_a_kind
    {
        return .three_of_a_kind
    }


    return .NONE
}

part1_solution :: proc() -> int 
{
    using fmt
    using strings
    using strconv

    file_lines := split_lines(FILE)
    defer delete(file_lines)

    result : int 
    
    hands := make([dynamic]HAND)
    //for line in file_lines 
    for i := 0; i < len(file_lines); i += 1
    {
        //println(line)

        type := find_hand_type(split(file_lines[i], " ")[0])
        new_h :=  HAND{ split(file_lines[i], " ")[0], atoi(split(file_lines[i], " ")[1]), i + 1, type }
        println(new_h) 
        append(&hands, new_h)
    }
    //println(hands)


    return result
}

part2_solution :: proc() -> int
{
    using fmt
    using strings
    using strconv

    file_lines := split_lines(FILE)
    defer delete(file_lines)

    result : int = 1

    return result
}

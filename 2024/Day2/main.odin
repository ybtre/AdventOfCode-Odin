package AoC

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:slice"
import "core:mem"
import "core:unicode"
import "core:unicode/utf8"
import "core:time"
import "core:sort"
import "core:math"

FILENAME :: `input.txt`
// FILENAME :: `demo1.txt`
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
    fmt.println("PART 1:", p1_result, " -- Time:", time.diff(part1_start, part1_end), " -- Memory Used:", solution_arena.peak_used)

    part2_start := time.now()
        p2_result: int = part2_solution()
    part2_end := time.now()
    fmt.println("PART 2:", p2_result, " -- Time:", time.diff(part2_start, part2_end), " -- Memory Used:", solution_arena.peak_used)
    fmt.println("---------------------------------------------------------------------\n")
}

part1_solution :: proc() -> int
{
    using fmt
    file_lines := strings.split_lines(FILE)
    defer delete(file_lines)

    result := 0

    left := make([dynamic]int)
    right := make([dynamic]int)

    for line in file_lines
    {
        // printf("LINE: %s\n", line)
        
        n, ok := strconv.parse_int(strings.split(line, "   ")[0])
        append(&left, n)

        n, ok = strconv.parse_int(strings.split(line, "   ")[1])
        append(&right, n)
    }

    sort.quick_sort(left[:])
    sort.quick_sort(right[:])

    for i :int = 0; i < len(left); i+=1
    {
        a := left[i]
        b := right[i]

        result += math.abs(a - b)
    }

    return result
}


part2_solution :: proc() -> int
{
    using fmt
    file_lines := strings.split_lines(FILE)
    defer delete(file_lines)

    result := 0

    left := make([dynamic]int)
    right := make([dynamic]int)

    for line in file_lines
    {
        // printf("LINE: %s\n", line)
        
        n, ok := strconv.parse_int(strings.split(line, "   ")[0])
        append(&left, n)

        n, ok = strconv.parse_int(strings.split(line, "   ")[1])
        append(&right, n)
    }


    sort.quick_sort(left[:])
    sort.quick_sort(right[:])

    for i:int=0; i < len(left); i+=1
    {
        a := left[i]
        matches : int

        for j:=0; j <len(right); j+=1
        {
            b := right[j]

            if a == b
            {
                matches+=1
            }
        }

        result += a * matches
    }

    return result
}

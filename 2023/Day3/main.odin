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

    println("PART 1:", p1_result, "Time:", time.diff(part1_start, part1_end), "Memory Used:", solution_arena.peak_used)
    

    part2_start := time.now()
        p2_result: int = part2_solution()
    part2_end := time.now()

    println("PART 2:", p2_result, "Time:", time.diff(part2_start, part2_end), "Memory Used:", solution_arena.peak_used)
    println("---------------------------------------------------------------------\n")
}

part1_solution :: proc() -> int 
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

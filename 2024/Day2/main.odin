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

// FILENAME :: `input.txt`
FILENAME :: `demo1.txt`
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

    row := make([dynamic]string)
    row_map : map[int]string

    row_id : int
    for line in file_lines
    {
        printf("LINE: %s\n", line)
       
        row_map[row_id] = line
        row_id += 1

        n := strings.split(line, " ")
        append_elems(&row, ..n)
    }

    for key, value in row_map
    {
        fmt.println("KEY: ", key, " VALUE: ", value)
    }

    return result
}


part2_solution :: proc() -> int
{
    result := 0

    return result
}

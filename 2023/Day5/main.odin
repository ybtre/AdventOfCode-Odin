package day5

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

    println("PART 1:", p1_result, "Time:", time.diff(part1_start, part1_end), "Memory Used:", solution_arena.peak_used)
    

    part2_start := time.now()
        p2_result: int = part2_solution()
    part2_end := time.now()

    println("PART 2:", p2_result, "Time:", time.diff(part2_start, part2_end), "Memory Used:", solution_arena.peak_used)
    println("---------------------------------------------------------------------\n")
}

//=============================================================================
//=============================================================================

SEED_VALUES :: struct 
{
    seed        : int,
    soil        : int,
    fertilizer  : int,
    water       : int,
    light       : int,
    temperature : int,
    humidity    : int,
    location    : int,
}

part1_solution :: proc() -> int 
{
    using fmt
    using strings
    using strconv

    file_lines := split_lines(FILE)
    defer delete(file_lines)

    result : int


    lowest_location  : i32 = 2147483647

    seeds := make(map[int]SEED_VALUES)

    current_mapping := make([dynamic]string)

    current_map : string

    l1: for line in file_lines 
    {
        if contains(line, "seeds:")
        {
            s := split(line, ": ")[1]

            n := split(s, " ")
            for seed in n
            {
                //println(seed)
                seeds[atoi(seed)] = { seed = atoi(seed)}
            }
        }


        if contains(line, "seed-to-soil")
        {
            current_map = line
        }

        if contains(current_map, "seed-to-soil")
        {
            //process
            if !contains(line, "seed-to-soil")
            {

                if !(line == "")
                {
                    a := split(line, " ")[0]
                    b := split(line, " ")[1]
                    c := split(line, " ")[2]

                    range_start := atoi(b)
                    range_end := atoi(b) + atoi(c) - 1
                    idx := atoi(a) - atoi(b)

                }

                //println("SPL", a, b, c )
            }
        }

        if line == ""
        {
            current_map = ""
        }
    }

    // keys
    for key in seeds
    {
        if seeds[key].seed >= range_start && seeds[key].seed <= range_end
        {
            val := seeds[key]
            val.soil = val.seed + idx
            seeds[key] = val
            //println(seeds[key])
        }
        else 
        {
            val := seeds[key]
            val.soil = val.seed
            seeds[key] = val
            //println(seeds[key])
        }


    }
    
    for s in seeds 
    {
        println(seeds[s])
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

    for line := 0; line < len(file_lines); line += 1 
    {
    }

    return result
}

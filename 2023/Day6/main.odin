package day6

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
//=============================================================================


part1_solution :: proc() -> int 
{
    using fmt
    using strings
    using strconv

    file_lines := split_lines(FILE)
    defer delete(file_lines)

    result : int = 1


    time          := split(file_lines[0], ": ")[0]

    tmp_races     := split(split(file_lines[0], ": ")[1], " ")
    races_time    := make([dynamic]int)
    for t in tmp_races
    {
        num, ok := parse_int(t) 
        if ok
        {
            append(&races_time, num)
        }
    }

    distance          := split(file_lines[1], ": ")[0]

    tmp_races         = split(split(file_lines[1], ": ")[1], " ")
    races_distance    := make([dynamic]int)
    for t in tmp_races
    {
        num, ok := parse_int(t) 
        if ok
        {
            append(&races_distance, num)
        }
    }

    for i := 0; i < len(races_time); i += 1
    {
        win_count := 0
        for t := 1; t <= races_time[i]; t += 1
        {

            speed := t

            time_remaining := races_time[i] - speed

            distance_travelled := 0
            for r := time_remaining; r > 0; r -= 1
            {
                distance_travelled += speed            
            }

            if distance_travelled > races_distance[i]
            {
                win_count += 1
            }
        }

        result = result * win_count
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

    result : int = 1


    time          := split(file_lines[0], ": ")[0]

    tmp_races     := split(split(file_lines[0], ": ")[1], " ")
    races_time    := make([dynamic]string)
    for t in tmp_races
    {
        num, ok := parse_int(t) 
        if ok
        {
            append(&races_time, t)
        }
    }

    race_time := strings.concatenate(races_time[:])

    distance          := split(file_lines[1], ": ")[0]

    tmp_races         = split(split(file_lines[1], ": ")[1], " ")
    races_distance    := make([dynamic]string)
    for t in tmp_races
    {
        num, ok := parse_int(t) 
        if ok
        {
            append(&races_distance, t)
        }
    }

    race_distance := concatenate(races_distance[:])
    
    win_count := 0
    for t := 1; t <= atoi(race_time); t += 1
    {

        speed := t

        time_remaining := atoi(race_time) - speed

        distance_travelled := 0
        for r := time_remaining; r > 0; r -= 1
        {
            distance_travelled += speed            
        }

        if distance_travelled > atoi(race_distance)
        {
            win_count += 1
        }
    }

    result = win_count
   

    return result
}

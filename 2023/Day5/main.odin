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


part1_solution :: proc() -> int 
{
    using fmt
    using strings
    using strconv

    file_lines := split_lines(FILE)
    defer delete(file_lines)

    result : int

    seeds := make([dynamic]int)

    current_map : string

    lowest_location  : i32 = 2147483647

    soil_data        := make([dynamic]string)
    fertilizer_data  := make([dynamic]string)
    water_data       := make([dynamic]string)
    light_data       := make([dynamic]string)
    temperature_data := make([dynamic]string)
    humidity_data    := make([dynamic]string)
    location_data    := make([dynamic]string)

    //for line in file_lines
    for line := 0; line < len(file_lines); line += 1 
    {
        l := file_lines[line]
        println(l)
        
        //parse out seeds
        if contains(l, "seeds:")
        {
            n := split(l, ": ")[1]

            s := split(n, " ")
            for n in s
            {
                append(&seeds, atoi(n))
            }
        }
        if contains(l, "seed-to-soil")
        {
            current_map = l
        }
        if contains(l, "soil-to-fertilizer")
        {
            current_map = l
        }
        if contains(l, "fertilizer-to-water")
        {
            current_map = l
        }
        if contains(l, "water-to-light")
        {
            current_map = l
        }
        if contains(l, "light-to-temperature")
        {
            current_map = l
        }
        if contains(l, "temperature-to-humidity")
        {
            current_map = l
        }
        if contains(l, "humidity-to-location")
        {
            current_map = l
        }

        if contains(current_map, "seed-to-soil")
        {
            if !contains(l, "seed-to-soil")
            {
                append(&soil_data, l) 
            }
        }
        if contains(current_map, "soil-to-fertilizer")
        {
            if !contains(l, "soil-to-fertilizer")
            {
                append(&fertilizer_data, l) 
            }
        }
        if contains(current_map, "fertilizer-to-water")
        {
            if !contains(l, "fertilizer-to-water")
            {
                append(&water_data, l) 
            }
        }
        if contains(current_map, "water-to-light")
        {
            if !contains(l, "water-to-light")
            {
                append(&light_data, l) 
            }
        }
        if contains(current_map, "light-to-temperature")
        {
            if !contains(l, "light-to-temperature")
            {
                append(&temperature_data, l) 
            }
        }
        if contains(current_map, "temperature-to-humidity")
        {
            if !contains(l, "temperature-to-humidity")
            {
                append(&humidity_data, l) 
            }
        }
        if contains(current_map, "humidity-to-location")
        {
            if !contains(l, "humidity-to-location")
            {
                append(&location_data, l) 
            }
        }
    }

    //println("SEEDS==========")
    for s in seeds
    {
        //println(s)
    }

    //println("SOIL MAP========")
    for f in soil_data
    {
        //println(f)
    }
    //println("FERTI MAP========")
    for f in fertilizer_data
    {
        //println(f)
    }

    soil_value        := make([dynamic]int)
    fertilizer_value  := make([dynamic]int)
    water_value       := make([dynamic]int)
    light_value       := make([dynamic]int)
    temperature_value := make([dynamic]int)
    humidity_value    := make([dynamic]int)
    location_value    := make([dynamic]int)
    for seed in seeds
    {
        dest_range_start   := 0
        source_range_start := 0
        range_length       := 0

        for data in soil_data
        {
            if len(data) <= 0
            {
                break
            }

            d := split(data, " ")
            //println("DATA",data)

            dest_range_start   = atoi(d[0])
            source_range_start = atoi(d[1])
            range_length       = atoi(d[2])

        }

        if seed >= source_range_start && seed < source_range_start + range_length 
        {
            ts := dest_range_start + seed - source_range_start
            append(&soil_value, ts)
        }
        else 
        {
            append(&soil_value, seed)
        }
    }

    for soil in soil_value
    {
        dest_range_start   := 0
        source_range_start := 0
        range_length       := 0

        for data in fertilizer_data
        {
            if len(data) <= 0
            {
                break
            }

            d := split(data, " ")
            //println("DATA",data)

            dest_range_start   = atoi(d[0])
            source_range_start = atoi(d[1])
            range_length       = atoi(d[2])

        }
        if soil >= source_range_start && soil < source_range_start + range_length 
        {

            ts := dest_range_start + soil - source_range_start
            //println("TS:",ts)
            append(&fertilizer_value, ts)
        }
        else 
        {
            append(&fertilizer_value, soil)
        }
    }
    for fert in fertilizer_value
    {
        dest_range_start   := 0
        source_range_start := 0
        range_length       := 0

        for data in fertilizer_data
        {
            if len(data) <= 0
            {
                break
            }

            d := split(data, " ")
            //println("DATA",data)

            dest_range_start   = atoi(d[0])
            source_range_start = atoi(d[1])
            range_length       = atoi(d[2])

            if fert >= source_range_start && fert < source_range_start + range_length 
            {

                ts := dest_range_start + fert - source_range_start
                //println("TS:",ts)
                append(&water_value, ts)
            }
            else 
            {
                append(&water_value, fert)
            }
        }
    }

    /*
    dest_range_start   := make([dynamic]int)
    source_range_start := make([dynamic]int)
    range_length       := make([dynamic]int)
    //println("FFFF", fert)
    //println(water_data)
    for data in water_data
    {
        println("DATA",data)
        if len(data) <= 0
        {
            break
        }

        d := split(data, " ")

        append(&dest_range_start, atoi(d[0]))
        append(&source_range_start, atoi(d[1]))
        append(&range_length, atoi(d[2]))
        println(dest_range_start)
        println(source_range_start)
        println(range_length)
        println()
    }

    for i := 0; i < len(dest_range_start); i += 1
    {
    for fert in fertilizer_value
    {
            //println("T",fert, source_range_start[i], source_range_start[i] + range_length[i])
            if fert >= source_range_start[i] && fert < source_range_start[i] + range_length[i] 
            {

                ts := dest_range_start[i] + fert - source_range_start[i]
                //println("TS:",ts)
                append(&water_value, ts)
            }
            else 
            {
                append(&water_value, fert)
                //println(fert)
            }
        }
    }
    clear(&dest_range_start)
    clear(&source_range_start)
    clear(&range_length)
    */

    println("SEED VALUES:", soil_value)
    println("FERT VALUES:", fertilizer_value)
    println("WATER VALUES:", water_value)

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

package day2

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

part1_solution :: proc() -> int 
{
    using fmt
    using strings
    using strconv

    file_lines := split_lines(FILE)
    defer delete(file_lines)

    result : int

    max_red   :: 12
    max_green :: 13
    max_blue  :: 14

    for line in file_lines {
        //println("LINE:", line)

        possible := true

        game := split(line, ": ")
        //println("GAME:", game[0])

        game_id := atoi(split(game[0], " ")[1])
        //println("GAME ID:", game_id)

        rounds := split(game[1], "; ")
        for round in rounds {
            //println("ROUND:", round)
            
            cubes := split(round, ", ")
            for cube in cubes {
                //println("CUBE:", cube)

                num := atoi(split(cube, " ")[0])
                //println("NUM:", num)

                color := split(cube, " ")[1]
                //println("COLOR:", color)
                
                if contains(color, "red") && num > max_red
                {
                    possible = false
                }
                if contains(color, "green") && num > max_green
                {
                    possible = false
                }
                if contains(color, "blue") && num > max_blue
                {
                    possible = false
                }
            }
        }

        //println("POSSIBLE:", possible)

        if possible {
            result += game_id
        }

        //println()
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

    max_red   :: 12
    max_green :: 13
    max_blue  :: 14

    for line in file_lines {
        power     := 0
        min_red   := 0
        min_green := 0
        min_blue  := 0

        game := split(line, ": ")

        game_id := atoi(split(game[0], " ")[1])

        rounds := split(game[1], "; ")
        for round in rounds {
            
            cubes := split(round, ", ")
            for cube in cubes {

                num := atoi(split(cube, " ")[0])

                color := split(cube, " ")[1]
                
                if contains(color, "red") && num > min_red
                {
                    min_red = num
                }
                if contains(color, "green") && num > min_green
                {
                    min_green = num
                }
                if contains(color, "blue") && num > min_blue
                {
                    min_blue = num
                }
            }
        }

        power = min_red * min_green * min_blue
        //println("POWER:", power)

        result += power
        //println()
    }

    return result
}

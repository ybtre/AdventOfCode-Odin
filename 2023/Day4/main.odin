package day4

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
FILE :: string(#load(DEMO2))

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

cleanse_space :: proc(OLD : []string) -> [dynamic]string
{
    result := make([dynamic]string)

    //for w in winning_nums
    for i := 0; i < len(OLD); i+=1
    {
        w := OLD[i]
        if unicode.is_digit(utf8.rune_at(w, 0))
        {
            append(&result, w)
        }
    }

    return result
}

SCRATCHCARDS :: struct 
{
    card_id : int,
    points  : int,
}

scratch_cards := make([dynamic]SCRATCHCARDS)

part1_solution :: proc() -> int
{
    using fmt
    using strings
    using strconv

    file_lines := split_lines(FILE)
    defer delete(file_lines)

    result : int

    for line in file_lines {

        points := 0
        score  := 0

        //println("LINE:", line)

        card                              := split(line, ": ")
        //println("CARD:", card[0])

        card_id                           := split(card[0], " ")[1]
        //println("CARD ID:", card_id)

        winning_list                      := split(card[1], " | ")[0]
        //println("WINNING LIST:", winning_list)

        your_list                         := split(card[1], " | ")[1]
        //println("YOUR LIST:", your_list)

        winning_nums                      := split_multi(winning_list, {" ", "  "})
        your_nums                         := split(your_list, " ")
        //println("Y NUMS:", your_nums)

        w_nums := cleanse_space(winning_nums)
        defer delete(w_nums)
        //println("W NUMS:", w_nums)

        y_nums := cleanse_space(your_nums)
        defer delete(y_nums)
        //println("Y NUMS:", y_nums)

        //for i := 0; i < len(winning_list); i+= 1
        for w in w_nums 
        {
            //println("W:", w)
            for y in y_nums
            {
                //println("Y:", y)
                if atoi(w) == atoi(y)
                {
                    //println("MATCH:", w, y)
                    points += 1
                }
            }
        }
        //println("POINTS:", points)

        for i := 0; i < points; i+=1
        {
            if score == 0
            {
                score = 1
            }
            else {
                score *= 2
            }
        }

        result += score
        //println("SCORE:",score)
        
        //println()

        append(&scratch_cards, SCRATCHCARDS{ atoi(card_id), points })
    }


    return result
}

DUPES :: struct 
{
    id    : int,
    count : int,
}
part2_solution :: proc() -> int
{
    using fmt
    using strings
    using strconv

    file_lines := split_lines(FILE)
    defer delete(file_lines)

    result : int
    sum : int

    copy_ids := make([dynamic]int)
    dupes := make(map[int]int)

    for i := 0; i < len(scratch_cards); i += 1
    {
        s := scratch_cards[i]
    }

    for i := 0; i < len(scratch_cards); i += 1
    {
        for j := i; j < len(scratch_cards); j += 1
        {
            s := scratch_cards[j]

            for k := j; k <= s.points; k += 1
            {
                dupes[s.card_id + k] += 1
                append(&copy_ids, s.card_id + k)
            }
        }
    }
    /*
    for s in scratch_cards
    {
        //m[s.card_id] = s.points
        //println(s)
        for i := 0; i <= s.points; i+=1
        {
            //println("DUPES:", s.card_id + i)
            dupes[s.card_id + i] += 1
            append(&copy_ids, s.card_id + i)
        }
    }
    //println("DUPES:", dupes)
    
    for j := 1; j < len(scratch_cards); j+=1
    {
        s := scratch_cards[j]

        //m[s.card_id] = s.points
        println("CUR:",s.card_id)
        for i := 1; i <= s.points; i+=1
        {
            println("NEXT:", s.card_id+i)
            //println("DUPES:", s.card_id + i)
            dupes[s.card_id + i] += 1
            append(&copy_ids, s.card_id + i)
        }
    }
    */
    println("DUPES:", dupes)
    println("COPY IDS:", copy_ids)
    

    return result
}

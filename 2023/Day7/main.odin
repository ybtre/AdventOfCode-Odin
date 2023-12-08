package day7

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

    arena_backing := make([]u8, 64 * mem.Megabyte)
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
    high_card,
    one_pair,
    two_pair,
    three_of_a_kind,
    full_house,
    four_of_a_kind,
    five_of_a_kind,
}

HAND :: struct {
    hand : string,
    bid  : int,
    rank : int,
    type : TYPE,
}
//=============================================================================
five_of_a_kind :: proc(HAND : string) -> bool
{
    using fmt

    matches_count := 0
    matching_rune : rune
    joker_count   := 0
    for i := 0; i < len(HAND); i += 1
    {
        if HAND[i] == 'J'
        {
            joker_count += 1
        }
    }
    l1: for i := 0; i < len(HAND); i += 1
    {
        matches_count = 0
        for j := i; j < len(HAND); j += 1
        {
            if (HAND[i] == HAND[j]) && HAND[i] != 'J'
            {
                //println(i, j)
                matches_count += 1
                matching_rune = rune(HAND[i])
                if matches_count == 5
                {
                    return true
                }
                else if matches_count == 4 && joker_count == 1
                {
                    return true
                }
                else if matches_count == 3 && joker_count == 2
                {
                    return  true
                }
                else if matches_count == 2 && joker_count == 3
                {
                    return  true
                }
                else if matches_count == 1 && joker_count == 4
                {
                    return  true
                }
            }
            if joker_count == 5
            {
                return true
            }
        }

        //println(matches_count)
    }

    return false
}

four_of_a_kind :: proc(HAND : string) -> bool
{
    using fmt

    matches_count := 0
    matching_rune : rune
    joker_count   := 0
    for i := 0; i < len(HAND); i += 1
    {
        if HAND[i] == 'J'
        {
            joker_count += 1
        }
    }
    l1: for i := 0; i < len(HAND); i += 1
    {
        matches_count = 0
        for j := i; j < len(HAND); j += 1
        {
            if (HAND[i] == HAND[j]) && HAND[j] != 'J'
            {
                //println(i, j)
                matches_count += 1
                matching_rune = rune(HAND[i])
            }
        }
        //println(HAND, matches_count, joker_count)
        if matches_count == 4
        {
            return true
        }
        else if matches_count == 3 && joker_count == 1 
        {
            return true
        }
        else if matches_count == 2 && joker_count == 2
        {
            return true
        }
        else if matches_count == 1 && joker_count == 3
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
    joker_count   := 0
    for i := 0; i < len(HAND); i += 1
    {
        if HAND[i] == 'J'
        {
            joker_count += 1
        }
    }

    ml: for i := 0; i < len(HAND); i += 1
    {
        matches_count = 0
        for j := i; j < len(HAND); j += 1
        {
            if (HAND[i] == HAND[j]) && HAND[j] != 'J'
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
                        if (HAND[o] == HAND[p]) && HAND[o] != 'J'
                        {
                            //println(rune(HAND[o]), rune(HAND[p]))
                            return true
                        }
                    }
                }
            }
        }
        else if matches_count == 2 && joker_count == 1
        {
            is_three_of_a_kind := false
            for o := 0; o < len(HAND); o += 1
            {
                for p := o + 1; p < len(HAND); p += 1
                {
                    if rune(HAND[o]) != matching_rune && rune(HAND[p]) != matching_rune
                    {
                        if (HAND[o] == HAND[p]) && HAND[o] != 'J'
                        {
                            //println(rune(HAND[o]), rune(HAND[p]))
                            return true
                        }
                    }
                }
            }
        }
        else if matches_count == 1 && joker_count == 2
        {
            //println(HAND, matches_count, joker_count, matching_rune)
            is_three_of_a_kind := false
            for o := 0; o < len(HAND); o += 1
            {
                for p := o + 1; p < len(HAND); p += 1
                {
                    if rune(HAND[o]) != matching_rune && rune(HAND[p]) != matching_rune
                    {
                        if (HAND[o] == HAND[p]) && HAND[o] != 'J'
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
    joker_count   := 0
    for i := 0; i < len(HAND); i += 1
    {
        if HAND[i] == 'J'
        {
            joker_count += 1
        }
    }

    ml: for i := 0; i < len(HAND); i += 1
    {
        matches_count = 0
        for j := i; j < len(HAND); j += 1
        {
            if (HAND[i] == HAND[j]) && HAND[j] != 'J'
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
                        if (HAND[o] != HAND[p]) && HAND[o] != 'J'
                        {
                            //println(rune(HAND[o]), rune(HAND[p]))
                            return true
                        }
                    }
                }
            }
        }
        if matches_count == 2 && joker_count == 1
        {
            is_three_of_a_kind := false
            for o := 0; o < len(HAND); o += 1
            {
                for p := o + 1; p < len(HAND); p += 1
                {
                    if rune(HAND[o]) != matching_rune && rune(HAND[p]) != matching_rune
                    {
                        if (HAND[o] != HAND[p]) && HAND[o] != 'J'
                        {
                            //println(rune(HAND[o]), rune(HAND[p]))
                            return true
                        }
                    }
                }
            }
        }
        if matches_count == 1 && joker_count == 2
        {
            is_three_of_a_kind := false
            for o := 0; o < len(HAND); o += 1
            {
                for p := o + 1; p < len(HAND); p += 1
                {
                    if rune(HAND[o]) != matching_rune && rune(HAND[p]) != matching_rune
                    {
                        if (HAND[o] != HAND[p]) && HAND[o] != 'J'
                        {
                            //  println(rune(HAND[o]), rune(HAND[p]))
                            return true
                        }
                    }
                }
            }
        }
        //println(HAND, matches_count, joker_count)
    }

    return false
}

two_pair :: proc(HAND : string) -> bool
{
    using fmt

    first_match  := 0
    first_rune   : rune
    second_match := 0
    second_rune  : rune
    joker_count   := 0
    for i := 0; i < len(HAND); i += 1
    {
        if HAND[i] == 'J'
        {
            joker_count += 1
        }
    }

    //println(HAND)
    l1: for i := 0; i < len(HAND); i += 1
    {
        first_match  = 0
        for j := 0; j < len(HAND); j += 1
        {
            if (HAND[i] == HAND[j]) && HAND[j] != 'J'
            {
                //println(i, j)
                first_match += 1
                first_rune = rune(HAND[i])
                if first_match == 2
                {
                    break l1
                }
            }
        }
    }
    l2: for i := 0; i < len(HAND); i += 1
    {
        second_match = 0
        for j:= 0; j < len(HAND); j += 1
        {
            if HAND[i] == HAND[j]
            {
                if rune(HAND[j]) != first_rune
                {
                    second_match += 1
                    second_rune = rune(HAND[j])
                    if second_match == 2
                    {
                        break l2
                    }
                }
            }
        }
    }

    if ((first_match == 2 && second_match == 2) || (first_match == 2 && joker_count == 2 || (second_match == 2 && joker_count == 2))) && first_rune != second_rune
    {
        return true
    }

    return false
}

one_pair :: proc(HAND : string) -> bool
{
    using fmt

    first_match  := 0
    first_rune   : rune
    second_match := 0
    second_rune  : rune

    joker_count   := 0
    for i := 0; i < len(HAND); i += 1
    {
        if HAND[i] == 'J'
        {
            joker_count += 1
        }
    }

    for i := 0; i < len(HAND); i += 1
    {
        first_match  = 0
        second_match = 0

        for j := i; j < len(HAND); j += 1
        {
            if HAND[i] == HAND[j]
            {
                //println(i, j)
                first_match += 1
                first_rune = rune(HAND[i])
            }
            if rune(HAND[i]) != first_rune
            {
                second_match += 1
                //second_rune = rune(HAND[j])
            }
        }
        //println("FR",first_rune, "SR",second_rune, "FM", first_match, "SM", second_match)

        if (first_match == 2 && second_match == 0) 
        {
            return true
        }
        if (first_match == 1 && joker_count == 1 && second_match == 0)
        {
            return true
        }
    }

    return false
}

high_card :: proc(HAND : string) -> bool
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
        if matches_count == 1
        {
            return true
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

    is_two_pair := two_pair(H_VALUE)
    if is_two_pair 
    {
        return .two_pair
    }

    is_one_pair := one_pair(H_VALUE)
    if is_one_pair 
    {
        return .one_pair
    }

    is_high_card := high_card(H_VALUE)
    if is_high_card 
    {
        return .high_card
    }


    return .NONE
}

sort_hands :: proc(HANDS : [dynamic]HAND)
{
    sorted := make([dynamic]HAND)

    for i := 0; i < len(HANDS); i += 1
    {
        for j := 0; j < len(HANDS); j += 1
        {
            if HANDS[i].type < HANDS[j].type
            {
                tmp := HANDS[i]
                HANDS[i] = HANDS[j]
                HANDS[j] = tmp
            }
        }
    }
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
        //println(file_lines[i])

        type  := find_hand_type(split(file_lines[i], " ")[0])
        h     := split(file_lines[i], " ")[0]
        bid   := atoi(split(file_lines[i], " ")[1])
        new_h := HAND{ h, bid, i + 1, type }
        //println(new_h) 
        append(&hands, new_h)
    }


    sort_hands_by_rune :: proc(A, B : HAND) -> bool {
        pwr := make(map[rune]int)
        pwr['A'] = 13
        pwr['K'] = 12
        pwr['Q'] = 11
        pwr['J'] = 10
        pwr['T'] = 9
        pwr['9'] = 8
        pwr['8'] = 7
        pwr['7'] = 6
        pwr['6'] = 5
        pwr['5'] = 4
        pwr['4'] = 3
        pwr['3'] = 2
        pwr['2'] = 1
        if A.type == B.type
        {
            for i := 0; i < len(A.hand); i += 1
            {
                if A.hand[i] != B.hand[i]
                {
                    return pwr[rune(A.hand[i])] < pwr[rune(B.hand[i])]
                }
            }
        }
        return A.type < B.type
    }

    slice.sort_by(hands[:], sort_hands_by_rune)
    println()


    for i := 0; i < len(hands); i += 1
    {
        hands[i].rank = i + 1
    }

    for h in hands 
    {
        //println(h.hand, h.type)

        result += h.bid * h.rank
    }

    //println(u8('A'), u8('K'), u8('Q'), u8('J'), u8('T'), u8('9'), u8('8'))
    
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
    
    hands := make([dynamic]HAND)
    for i := 0; i < len(file_lines); i += 1
    {

        type  := find_hand_type(split(file_lines[i], " ")[0])
        h     := split(file_lines[i], " ")[0]
        bid   := atoi(split(file_lines[i], " ")[1])
        new_h := HAND{ h, bid, i + 1, type }
        append(&hands, new_h)
    }


    sort_hands_by_rune :: proc(A, B : HAND) -> bool {
        pwr := make(map[rune]int)
        pwr['A'] = 13
        pwr['K'] = 12
        pwr['Q'] = 11
        pwr['T'] = 10
        pwr['9'] = 9
        pwr['8'] = 8
        pwr['7'] = 7
        pwr['6'] = 6
        pwr['5'] = 5
        pwr['4'] = 4
        pwr['3'] = 3
        pwr['2'] = 2
        pwr['J'] = 1
        if A.type == B.type
        {
            for i := 0; i < len(A.hand); i += 1
            {
                if A.hand[i] != B.hand[i]
                {
                    //println(rune(A.hand[i]), rune(B.hand[i]))
                    //println(pwr[rune(A.hand[i])], pwr[rune(B.hand[i])])
                    return pwr[rune(A.hand[i])] < pwr[rune(B.hand[i])]
                }
            }
        }
        return A.type < B.type
    }

    slice.sort_by(hands[:], sort_hands_by_rune)
    slice.sort_by(hands[:], sort_hands_by_rune)
    println()


    for i := 0; i < len(hands); i += 1
    {
        hands[i].rank = i + 1
    }

    for h in hands 
    {
        //println(h.hand, h.bid, h.type)

        result += h.bid * h.rank
    }

    //println(u8('A'), u8('K'), u8('Q'), u8('J'), u8('T'), u8('9'), u8('8'))
    
    return result
}

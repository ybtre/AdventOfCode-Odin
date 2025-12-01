package AoC

import "core:fmt"
import "core:math"
import "core:mem"
import "core:slice"
import "core:sort"
import "core:strconv"
import "core:strings"
import "core:time"
import "core:unicode"
import "core:unicode/utf8"

FILENAME :: `input.txt`
//FILENAME :: `demo1.txt`
//FILENAME :: `demo2.txt`
FILE :: string(#load(FILENAME))

arena_input_backing: [16 * mem.Megabyte]u8
arena_p1_backing:    [4 * mem.Megabyte]u8
arena_p2_backing:    [4 * mem.Megabyte]u8

main :: proc() 
{
  using fmt

  input_arena: mem.Arena
  mem.arena_init(&input_arena, arena_input_backing[:])

  p1_arena: mem.Arena
  mem.arena_init(&p1_arena, arena_p1_backing[:])

  p2_arena: mem.Arena
  mem.arena_init(&p2_arena, arena_p2_backing[:])  

  println(
    "---------------------------------------------------------------------",
  )

  context.allocator = mem.arena_allocator(&input_arena)
  file_lines := strings.split_lines(FILE)
  defer delete(file_lines)

  // --- PART 1 ---
  context.allocator = mem.arena_allocator(&p1_arena)

  part1_start : = time.now()
  p1_result   : = part1_solution(file_lines)
  part1_end   : = time.now()
  println(
    "PART 1:",
    p1_result,
    " -- Time:",
    time.diff(part1_start, part1_end),
    " -- Memory Used:",
    p1_arena.peak_used,
  )

  // --- PART 2 ---
  context.allocator = mem.arena_allocator(&p2_arena)

  part2_start : = time.now()
  p2_result   : = part2_solution(file_lines)
  part2_end   : = time.now()
  println(
    "PART 2:",
    p2_result,
    " -- Time:",
    time.diff(part2_start, part2_end),
    " -- Memory Used:",
    p2_arena.peak_used,
  )
  println(
    "---------------------------------------------------------------------\n",
  )
}

parse_letter_num :: proc(s: string) -> (letter: u8, number: int) 
{
  letter = s[0]

  value := 0
  for ch in s[1:] 
  {
    /*
            `value = value * 10 + int(ch - '0')` is “append digit `ch` to the end of the current decimal number”.
            Break it down:
            * `ch` is a character representing a digit, e.g. `'0'`, `'1'`, … `'9'`.
            * Characters are stored as integer codes (ASCII).
              * `'0'` has code 48
              * `'1'` has code 49
              * …
              * `'9'` has code 57
            So for example, if `ch = '6'`:
            ch        // '6'
            '0'       // '0'
            ch - '0'  // 54 - 48 = 6

            `ch - '0'` converts a digit character into its numeric value `0..9`.

            Then:
            int(ch - '0')
            casts that byte result to `int`, so you can safely add it to `value` (which is an `int`).

            Now the left part:
            value * 10

            If `value` currently holds the number built so far, multiplying by 10 shifts all its digits left in base 10.
            Combine the two:
            value = value * 10 + int(ch - '0')

            means:
            1. Shift existing digits left (×10).
            2. Add the new digit at the units place.

            Concrete example with `"L68"`:
            * Start: `value = 0`
            * First digit `'6'`:
              * `ch - '0'` → `6`
              * `value = 0 * 10 + 6` → `6`
            * Second digit `'8'`:
              * `ch - '0'` → `8`
              * `value = 6 * 10 + 8` → `68`
        */
    value = value * 10 + int(ch - '0')
  }

  return letter, value
}

part1_solution :: proc(file_lines: []string) -> int 
{
  using fmt

  dial := 50
  times_at_zero := 0

  for line in file_lines 
  {
    if line == "" 
    {
      continue
    }

    letter, number := parse_letter_num(line)
    steps := number % 100

    switch letter {
    case 'L':
      dial = (dial + 100 - steps) % 100
    case 'R':
      dial = (dial + steps) % 100
    }

    if dial == 0 {
      times_at_zero += 1
    }
  }

  printf("Total times at zero: %d\n", times_at_zero)
  return times_at_zero
}


part2_solution :: proc(file_lines: []string) -> int 
{
  using fmt

  dial := 50
  times_at_zero := 0

  printf("The dial starts by pointing at %d.\n", dial)

  for line in file_lines {
    if line == "" 
    {
      continue
    }

    letter, number := parse_letter_num(line)

    dir: int
    switch letter {
    case 'L':
      dir = -1
    case 'R':
      dir = +1
    }

    for i := 0; i < number; i += 1 {
      dial = (dial + dir + 100) % 100
      if dial == 0 {
        times_at_zero += 1
      }
    }
  }

  printf("Total times at zero: %d\n", times_at_zero)
  return times_at_zero
}

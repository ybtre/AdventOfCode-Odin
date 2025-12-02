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

// FILENAME :: `input.txt`
FILENAME :: `demo1.txt`
// FILENAME :: `demo2.txt`
FILE :: string(#load(FILENAME))

arena_input_backing: [16 * mem.Megabyte]u8
arena_p1_backing: [4 * mem.Megabyte]u8
arena_p2_backing: [4 * mem.Megabyte]u8

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
  println(
    "---------------------------------------------------------------------",
  )
  defer delete(file_lines)

  ranges_buf: [MAX_RANGES]Range
  ranges := parse_range(file_lines[0], ranges_buf[:])

  // --- PART 1 ---
  context.allocator = mem.arena_allocator(&p1_arena)

  part1_start := time.now()
  p1_result := part1_solution(ranges)
  part1_end := time.now()
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

  part2_start := time.now()
  p2_result := part2_solution(ranges)
  part2_end := time.now()
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

MAX_RANGES :: 128
Range :: struct
{
  lo: int,
  hi: int,
}

parse_range :: proc(s: string, buf: []Range) -> []Range
{
  using strings

  str := trim_space(s)

  counter: int = 0
  parts := split(str, ",")
  for p in parts
  {
    part := trim_space(p)

    bounds := split(part, "-")
    lo := strconv.atoi(trim_space(bounds[0]))
    hi := strconv.atoi(trim_space(bounds[1]))

    buf[counter] = Range{lo, hi}
    counter += 1
  }

  return buf[:counter]
}

is_invalid_id :: proc(i: int) -> bool
{
  buff: [32]int
  len_digits := len(buff)
  number := i
  if number == 0
  {
    return false
  }

  for number > 0 && len_digits > 0
  {
    len_digits -= 1
    buff[len_digits] = number % 10
    number /= 10
  }

  digits := buff[len_digits:]
  n := len(digits)

  if (n % 2) != 0
  {
    return false
  }

  half := n / 2
  for k := 0; k < half; k += 1
  {
    if digits[k] != digits[k + half]
    {
      return false
    }
  }

  return true
}

is_invalid_id_part2 :: proc(i: int) -> bool
{
  buff: [32]int
  len_digits := len(buff)
  number := i
  if number == 0
  {
    return false
  }

  for number > 0 && len_digits > 0
  {
    len_digits -= 1
    buff[len_digits] = number % 10
    number /= 10
  }

  digits := buff[len_digits:]
  n := len(digits)

  if n < 2
  {
    return false
  }

  for p := 1; p <= n / 2; p += 1
  {
    if n % p != 0
    {
      continue
    }

    periodic := true
    for i := p; i < n - 1; i += 1
    {
      if digits[i] != digits[i - p]
      {
        periodic = false
        break
      }

      if periodic
      {
        return true
      }
    }
  }


  return true
}

part1_solution :: proc(ranges: []Range) -> int
{
  using fmt

  result := 0

  for r in ranges
  {
    // printfln("%d-%d", r.lo, r.hi)

    invalid_ids: [128]int

    c := 0
    for i: int = r.lo; i <= r.hi; i += 1
    {
      if is_invalid_id(i)
      {
        c += 1
        result += i
        invalid_ids[c] = i
      }
    }

    // for inv in invalid_ids
    // {
    //   printfln("Pair %d-%d has invalid ID %d ", r.lo, r.hi, inv)
    // }
  }

  printfln("\nresult: %d \n", result)
  return result
}


part2_solution :: proc(ranges: []Range) -> int
{
  using fmt

  result := 0

  for r in ranges
  {
    // printfln("%d-%d", r.lo, r.hi)

    invalid_ids: [128]int

    c := 0
    for i: int = r.lo; i <= r.hi; i += 1
    {
      if is_invalid_id_part2(i)
      {
        c += 1
        result += i
        invalid_ids[c] = i
      }
    }

    // for inv in invalid_ids
    // {
    //   printfln("Pair %d-%d has invalid ID %d ", r.lo, r.hi, inv)
    // }
  }

  printfln("\nresult: %d \n", result)
  return result
}

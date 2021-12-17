# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 15 Part 2
# https://adventofcode.com/2020/day/15#part2
# Answer is: 51358

# Based on: https://oeis.org/A181391 (second python generator, first was too slow)

# sequence = [0, 3, 6]
# last_pos = { 0 => 0, 3 => 1 }
# sequence = [1, 3, 2]
# last_pos = { 1 => 0, 3 => 1 }
# sequence = [2, 1, 3]
# last_pos = { 2 => 0, 1 => 1 }
# sequence = [1, 2, 3]
# last_pos = { 1 => 0, 2 => 1 }
# sequence = [3, 1, 2]
# last_pos = { 3 => 0, 1 => 1 }
sequence = [6, 3, 15, 13, 1, 0]
last_pos = { 6 => 0, 3 => 1, 15 => 2, 13 => 3, 1 => 4 }

i = sequence.length - 1
while i < 30_000_000
  new_value = i - (last_pos[sequence[i]] || i)
  sequence << new_value
  last_pos[sequence[i]] = i
  i += 1
end

puts sequence[29_999_999]

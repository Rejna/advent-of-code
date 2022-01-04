# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 5 Part 2
# https://adventofcode.com/2017/day/5#part2
# Answer is: 27477714

input = File.readlines('../1_Input/day05.input').map(&:strip).map(&:to_i)
# input = File.readlines('../1_Input/day05test.input').map(&:strip).map(&:to_i)

pointer = 0
steps = 0

while pointer >= 0 && pointer < input.length
  jump_value = input[pointer]
  input[pointer] += (jump_value >= 3 ? -1 : 1)
  pointer += jump_value

  steps += 1
end

puts steps

# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 15 Part 1
# https://adventofcode.com/2017/day/15
# Answer is: 619 in 6.4s

input = File.readlines('../1_Input/day15.input').map(&:strip)
# input = File.readlines('../1_Input/day15test.input').map(&:strip)

gen_a = input[0].split(' ').last.to_i
gen_b = input[1].split(' ').last.to_i

gen_a_factor = 16_807
gen_b_factor = 48_271
factor = 2_147_483_647
valid = 0

40_000_000.times.each do
  gen_a = (gen_a * gen_a_factor) % factor
  gen_b = (gen_b * gen_b_factor) % factor

  valid += 1 if gen_a % 65_536 == gen_b % 65_536
end

puts valid

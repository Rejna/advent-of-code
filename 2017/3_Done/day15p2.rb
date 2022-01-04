# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 15 Part 2
# https://adventofcode.com/2017/day/15#part2
# Answer is: 290 in 7.4s

input = File.readlines('../1_Input/day15.input').map(&:strip)
# input = File.readlines('../1_Input/day15test.input').map(&:strip)

gen_a = input[0].split(' ').last.to_i
gen_b = input[1].split(' ').last.to_i

gen_a_factor = 16_807
gen_b_factor = 48_271
factor = 2_147_483_647
valid = 0

gen_a_valid = false
gen_b_valid = false
pairs = 0

until pairs == 5_000_000
  gen_a = (gen_a * gen_a_factor) % factor unless gen_a_valid
  gen_b = (gen_b * gen_b_factor) % factor unless gen_b_valid

  gen_a_valid = true if (gen_a % 4).zero?
  gen_b_valid = true if (gen_b % 8).zero?

  next unless gen_a_valid && gen_b_valid

  valid += 1 if gen_a % 65_536 == gen_b % 65_536
  gen_a_valid = false
  gen_b_valid = false
  pairs += 1
end

puts valid

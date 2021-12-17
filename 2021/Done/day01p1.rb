# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 1 Part 1
# https://adventofcode.com/2021/day/1
# Answer is: 1387

# input = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
input = File.readlines('day01.input').map { |a| a.strip.to_i }

i = 1
counter = 0

while i < input.length
  counter += 1 if input[i] > input[i - 1]
  i += 1
end

puts counter

# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 13 Part 1
# https://adventofcode.com/2020/day/13
# Answer is: 5257

raw_input = File.readlines('../1 Input/day13.input').map(&:strip)
timestamp = raw_input[0].to_i
input = raw_input[1]
input = input.split(',').reject { |x| x == 'x' }.map(&:to_i)

nearest = timestamp
nearest_id = 0

input.each do |id|
  m = id - (timestamp % id)
  nearest_id = id if m < nearest
  nearest = m if m < nearest
end

puts nearest * nearest_id

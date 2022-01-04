# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 2 Part 1
# https://adventofcode.com/2017/day/2
# Answer is: 34925

input = File.readlines('../1_Input/day02.input').map(&:strip)
# input = File.readlines('../1_Input/day02test.input').map(&:strip)

sum = 0

input.each do |row|
  sp = row.split(/\t/).map(&:to_i)
  min = sp.min
  max = sp.max
  sum += max - min
end

puts sum

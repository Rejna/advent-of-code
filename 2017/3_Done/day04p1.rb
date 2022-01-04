# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 4 Part 1
# https://adventofcode.com/2017/day/4
# Answer is: 455

input = File.readlines('../1_Input/day04.input').map(&:strip)
# input = File.readlines('../1_Input/day04test.input').map(&:strip)

valid = 0
input.each do |row|
  sp = row.split(' ')
  valid += 1 if sp.length == sp.uniq.length
end

puts valid

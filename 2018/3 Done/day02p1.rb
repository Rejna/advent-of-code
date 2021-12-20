# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 2 Part 1
# https://adventofcode.com/2018/day/2
# Answer is: 5880

input = File.readlines('../1 Input/day02.input').map(&:strip)

threes = 0
twos = 0

input.each do |i|
  t = i.split('').tally
  twos += 1 if t.values.include?(2)
  threes += 1 if t.values.include?(3)
end

puts twos * threes

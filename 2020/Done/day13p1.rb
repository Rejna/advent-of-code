# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 13 Part 1
# https://adventofcode.com/2020/day/13
# Answer is: 5257

timestamp = 1_002_578
# rubocop:disable Layout/LineLength
input = '19,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,751,x,29,x,x,x,x,x,x,x,x,x,x,13,x,x,x,x,x,x,x,x,x,23,x,x,x,x,x,x,x,431,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,17'
# rubocop:enable Layout/LineLength
input = input.split(',').reject { |x| x == 'x' }.map(&:to_i)

nearest = timestamp
nearest_id = 0

input.each do |id|
  m = id - (timestamp % id)
  nearest_id = id if m < nearest
  nearest = m if m < nearest
end

puts nearest * nearest_id

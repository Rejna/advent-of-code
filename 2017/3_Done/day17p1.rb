# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 17 Part 1
# https://adventofcode.com/2017/day/17
# Answer is: 1914

# input = 3
input = 343

block = [0]
current = 0

2017.times.each do
  temp = block.index(current)
  temp = (temp + input) % block.length

  lhs = block[0..temp]
  rhs = block[temp + 1..]
  current += 1
  block = lhs + [current] + rhs
end

puts block[block.index(2017) + 1]

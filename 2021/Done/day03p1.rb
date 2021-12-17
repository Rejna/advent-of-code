# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 3 Part 1
# https://adventofcode.com/2021/day/3
# Answer is: 3633500

def min(a, b)
  a > b ? b : a
end

def max(a, b)
  a > b ? a : b
end

# input = %w[00100 11110 10110 10111 10101 01111 00111 11100 10000 11001 00010 01010]
input = File.readlines('day03.input').map(&:strip)

most_common = ''
least_common = ''
col_id = 0

while col_id < input[0].length
  col = []
  input.each do |bin|
    col << bin[col_id]
  end
  tally = col.tally
  most_common += max(tally['0'], tally['1']) == tally['0'] ? '0' : '1'
  least_common += min(tally['0'], tally['1']) == tally['0'] ? '0' : '1'
  col_id += 1
end

# puts "gamma #{most_common.to_i(2)}"
# puts "epsilon #{least_common.to_i(2)}"
puts most_common.to_i(2) * least_common.to_i(2)

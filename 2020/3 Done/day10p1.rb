# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 10 Part 1
# https://adventofcode.com/2020/day/10
# Answer is: 2482

# input = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
# input = [28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34,
#          10, 3]
input = File.readlines('../1 Input/day10.input').map(&:strip).map(&:to_i)
device = input.max

start = 0
one_count = 0
three_count = 1

while start < device
  if input.include?(start + 1)
    one_count += 1
    start += 1
  elsif input.include?(start + 2)
    start += 2
  elsif input.include?(start + 3)
    three_count += 1
    start += 3
  end
end

puts one_count * three_count

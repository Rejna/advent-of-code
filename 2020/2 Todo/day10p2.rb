# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 10 Part 2
# https://adventofcode.com/2020/day/10#part2
# Answer is: ???

# input = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
# input = [28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34,
#          10, 3]
# input = File.readlines('../1 Input/day10.input').map(&:strip).map(&:to_i)
device = input.max

start = 0
ways = 1

while start < device
  if input.include?(start + 1) && input.include?(start + 2) && input.include?(start + 3)
    ways *= 2
    start += 1
  elsif input.include?(start + 1) && input.include?(start + 2)
    ways *= 2
    start += 1
  elsif input.include?(start + 1) && input.include?(start + 3)
    ways *= 2
    start += 1
  elsif input.include?(start + 2) && input.include?(start + 3)
    ways *= 2
    start += 2
  elsif input.include?(start + 1)
    start += 1
  elsif input.include?(start + 2)
    start += 2
  elsif input.include?(start + 3)
    start += 3
  end
end

puts ways

# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 1 Part 2
# https://adventofcode.com/2019/day/1#part2
# Answer is: 4847351

# input = [14, 1969, 100756]
input = File.readlines('../1 Input/day01.input').map(&:strip).map(&:to_i)

sum = 0

input.each do |i|
  cur = i
  while cur.positive?
    cur = (cur / 3).floor - 2
    sum += cur if cur.positive?
  end
end

puts sum

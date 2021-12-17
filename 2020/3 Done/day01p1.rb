# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 1 Part 1
# https://adventofcode.com/2020/day/1
# Answer is: 468051

input = File.readlines('../1 Input/day01.input').map(&:strip).map(&:to_i)

input.each do |i|
  if input.include?(2020 - i)
    puts i * (2020 - i)
    break
  end
end

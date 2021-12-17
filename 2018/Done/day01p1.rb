# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 1 Part 1
# https://adventofcode.com/2018/day/1
# Answer is: 454

puts File.readlines('day01.input').map { |a| a.gsub('+', '').to_i }.sum

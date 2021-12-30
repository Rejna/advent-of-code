# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 23 Part 1
# https://adventofcode.com/2018/day/23
# Answer is: 481

def manhattan_distance3d(nanobot1, nanobot2)
  (nanobot1[0] - nanobot2[0]).abs + (nanobot1[1] - nanobot2[1]).abs + (nanobot1[2] - nanobot2[2]).abs
end

# input = File.readlines('../1 Input/day23test.input').map(&:strip)
input = File.readlines('../1 Input/day23.input').map(&:strip)

nanobots = []
input.each do |i|
  sp = i.split(', ')
  position = sp[0][5..-2].split(',').map(&:to_i)
  range = sp[1][2..].to_i
  nanobots << [position, range]
end

strongest_nanobot = nanobots.max_by { |n| n[1] }
in_range = 0

nanobots.each do |nanobot|
  distance = manhattan_distance3d(nanobot[0], strongest_nanobot[0])
  in_range += 1 if distance <= strongest_nanobot[1]
end

puts in_range

# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 12 Part 1
# https://adventofcode.com/2017/day/12
# Answer is: 115

input = File.readlines('../1_Input/day12.input').map(&:strip)
# input = File.readlines('../1_Input/day12test.input').map(&:strip)

programs = {}

input.each do |row|
  sp = row.split(' <-> ')
  programs[sp[0].to_i] = sp[1].split(', ').map(&:to_i)
end

visited = [0]

visited.each do |p|
  visited << p unless visited.include?(p)
  programs[p].each do |pp|
    visited << pp unless visited.include?(pp)
  end
end

puts visited.length

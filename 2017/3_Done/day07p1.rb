# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 7 Part 1
# https://adventofcode.com/2017/day/7
# Answer is: mwzaxaj

input = File.readlines('../1_Input/day07.input').map(&:strip)
# input = File.readlines('../1_Input/day07test.input').map(&:strip)

potential_roots = []
children = []

input.each do |row|
  sp = row.split(' -> ')
  node_info = sp[0].split(' ')
  node_name = node_info[0]

  next if sp.length == 1

  node_children = sp[1].split(', ')
  potential_roots << node_name
  children += node_children
end

puts (potential_roots - children)[0]

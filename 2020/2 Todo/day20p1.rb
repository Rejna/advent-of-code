# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 20 Part 1
# https://adventofcode.com/2020/day/20
# Answer is: ???

require 'matrix'

raw_input = File.readlines('../1 Input/day20.input').map(&:strip)
raw_input << ''
tiles = {}
temp_tile = []
temp_id = 0
raw_input.each do |row|
  if row.include?('Tile')
    temp_id = row.split(' ')[1].gsub(':', '').to_i
    tiles[temp_id] = []
  elsif row == ''
    tiles[temp_id] = temp_tile
    temp_tile = []
  else
    temp_tile << row.split('')
  end
end

# m = Matrix[
#     [1, 2],
#     [2, 3]
# ]
# m = m.rotate_entries
# puts m

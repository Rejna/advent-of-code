# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 10 Part 1
# https://adventofcode.com/2017/day/10
# Answer is: 826

input = File.readlines('../1_Input/day10.input').map(&:strip)[0].split(',').map(&:to_i)
list = [*0..255]
# input = File.readlines('../1_Input/day10test.input').map(&:strip)[0].split(',').map(&:to_i)
# list = [*0..4]

current_position = 0
skip_size = 0

input.each do |length|
  temp = {}

  i = 0
  while i < length
    temp[(current_position + i) % list.length] = list[(current_position + i) % list.length]
    i += 1
  end

  i = 0
  temp.each do |k, _v|
    list[k] = temp.values[temp.length - 1 - i]
    i += 1
  end

  current_position = (length + skip_size + current_position) % list.length
  skip_size += 1
end

puts list[0] * list[1]

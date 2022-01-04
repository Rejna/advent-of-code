# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 10 Part 2
# https://adventofcode.com/2017/day/10#part2
# Answer is: d067d3f14d07e09c2e7308c3926605c4

input = File.readlines('../1_Input/day10.input').map(&:strip)[0].split('').map(&:ord) + [17, 31, 73, 47, 23]
# input = File.readlines('../1_Input/day10test.input').map(&:strip)[0].split('').map(&:ord) + [17, 31, 73, 47, 23]
list = [*0..255]

current_position = 0
skip_size = 0

64.times.each do
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
end

sparse_hash = list
dense_hash = []
i = 0
while i < 256
  dense_hash << sparse_hash[i, 16].reduce(:^)
  i += 16
end

final_result = ''
dense_hash.each do |x|
  final_result += x.to_s(16).rjust(2, '0')
end

puts final_result

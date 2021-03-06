# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 3 Part 1
# https://adventofcode.com/2020/day/3
# Answer is: 148

# input = %w[..##....... #...#...#.. .#....#..#. ..#.#...#.# .#...##..#. ..#.##..... .#.#.#....# .#........# #.##...#...
#            #...##....# .#..#...#.#]
input = File.readlines('../1 Input/day03.input').map(&:strip)

i = 0
input.each do |line|
  input[i] = line.split('')
  i += 1
end

cur_i = 0
cur_j = 0
m = input[0].length
tree_count = 0
empty_count = 0

while cur_i < input.length - 1
  cur_i += 1
  cur_j = (cur_j + 3) % m
  # puts "#{cur_i} #{cur_j}"
  if input[cur_i][cur_j] == '#'
    tree_count += 1
  else
    empty_count += 1
  end
end

puts tree_count

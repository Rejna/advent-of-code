# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 3 Part 2
# https://adventofcode.com/2020/day/3#part2
# Answer is: 727923200

# input = %w[..##....... #...#...#.. .#....#..#. ..#.#...#.# .#...##..#. ..#.##..... .#.#.#....# .#........# #.##...#...
#           #...##....# .#..#...#.#]
input = File.readlines('../1 Input/day03.input').map(&:strip)

i = 0
input.each do |line|
  input[i] = line.split('')
  i += 1
end

slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
total_trees = 1
m = input[0].length

slopes.each do |slope|
  cur_i = slope[1]
  cur_j = slope[0]
  tree_count = 0
  empty_count = 0
  while cur_i < input.length
    if input[cur_i][cur_j] == '#'
      tree_count += 1
    else
      empty_count += 1
    end
    cur_i += slope[1]
    cur_j = (cur_j + slope[0]) % m
  end
  # puts "#{slope}: #{tree_count} trees, #{empty_count} empties"
  total_trees *= tree_count
end

puts total_trees

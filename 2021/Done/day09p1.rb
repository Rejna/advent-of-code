# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 9 Part 1
# https://adventofcode.com/2021/day/9
# Answer is: 468

def scan_neighbours(point)
  i = point[0]
  j = point[1]

  left = j >= 1 ? @input[i][j - 1] : 9
  right = j < @input[i].length - 1 ? @input[i][j + 1] : 9
  up = i >= 1 ? @input[i - 1][j] : 9
  down = i < @input.length - 1 ? @input[i + 1][j] : 9

  [left, right, up, down].map(&:to_i).all? { |a| a > @input[i][j].to_i }
end

# @input = %w[2199943210 3987894921 9856789892 8767896789 9899965678]
@input = File.readlines('day09.input').map(&:strip)

risk_level_sum = 0

@input.length.times do |i|
  @input[i].length.times do |j|
    risk_level_sum += @input[i][j].to_i + 1 if scan_neighbours([i, j])
  end
end

puts risk_level_sum

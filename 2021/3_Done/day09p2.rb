# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 9 Part 2
# https://adventofcode.com/2021/day/9#part2
# Answer is: 1280496

def scan_neighbours(point)
  i = point[0]
  j = point[1]

  left = j >= 1 ? @input[i][j - 1] : 9
  right = j < @input[i].length - 1 ? @input[i][j + 1] : 9
  up = i >= 1 ? @input[i - 1][j] : 9
  down = i < @input.length - 1 ? @input[i + 1][j] : 9

  [left, right, up, down].map(&:to_i).all? { |a| a > @input[i][j].to_i }
end

def scan_neighbours_recurrent(point, visited)
  visited << point

  i = point[0]
  j = point[1]

  # puts "#{i} #{j} #{@input[i][j]}"
  left = j >= 1 ? @input[i][j - 1] : 9
  right = j < @input[i].length - 1 ? @input[i][j + 1] : 9
  up = i >= 1 ? @input[i - 1][j] : 9
  down = i < @input.length - 1 ? @input[i + 1][j] : 9

  # puts "#{left} #{right} #{up} #{down}"
  # gets

  if left.to_i != 9 && !visited.include?([i, j - 1])
    # puts 'Going left'
    scan_neighbours_recurrent([i, j - 1], visited)
  end

  if right.to_i != 9 && !visited.include?([i, j + 1])
    # puts 'Going right'
    scan_neighbours_recurrent([i, j + 1], visited)
  end

  if up.to_i != 9 && !visited.include?([i - 1, j])
    # puts 'Going up'
    scan_neighbours_recurrent([i - 1, j], visited)
  end

  return unless down.to_i != 9 && !visited.include?([i + 1, j])

  # puts 'Going down'
  scan_neighbours_recurrent([i + 1, j], visited)
  # puts 'Exit'
end

# @input = %w[2199943210 3987894921 9856789892 8767896789 9899965678]
@input = File.readlines('../1_Input/day09.input').map(&:strip)

low_points = []
@input.length.times do |i|
  @input[i].length.times do |j|
    low_points << [i, j] if scan_neighbours([i, j])
  end
end

basin_sizes = []
low_points.each do |point|
  basin = []
  scan_neighbours_recurrent(point, basin)
  # puts "DONE #{point} | #{basin}"
  basin_sizes << basin.length
end

pp basin_sizes.sort.last(3).inject(:*)

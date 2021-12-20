# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 15 Part 1
# https://adventofcode.com/2021/day/15
# Answer is: 527

def min(a, b)
  a <= b ? a : b
end

# input = %w[1163751742 1381373672 2136511328 3694931569 7463417111
#            1319128137 1359912421 3125421639 1293138521 2311944581].map { |row| row.split('').map(&:to_i) }
input = File.readlines('../1 Input/day15.input').map { |row| row.strip.split('').map(&:to_i) }
# input_clone = input.map(&:clone)
start = input[0][0]

i = 0
while i < input.length
  j = 0
  while j < input[i].length
    if i.zero? && j.zero?
      input[i][j] = 0
    elsif i.zero? && j.positive?
      input[i][j] += input[i][j - 1]
    elsif i.positive? && j.zero?
      input[i][j] += input[i - 1][j]
    else
      input[i][j] += min(input[i][j - 1], input[i - 1][j])
    end
    j += 1
  end
  i += 1
end

# path = [[0, 0]]
# path_values = [input[0][0]]

# i = input.length - 1
# j = input.length - 1
# until [i, j] == [0, 0]
#   if (input[i - 1][j] || 999_999_999) < (input[i][j - 1] || 999_999_999)
#     path << [i - 1, j]
#     path_values << input[i - 1][j]
#     i -= 1
#   else
#     path << [i, j - 1]
#     path_values << input[i][j - 1]
#     j -= 1
#   end
# end

# i = 0
# while i < input.length
#   j = 0
#   row = ''
#   while j < input.length
#     row += "(#{input_clone[i][j]})".rjust(6, ' ') if path.include?([i, j])
#     row += "#{input_clone[i][j].to_s.rjust(6, ' ')}" unless path.include?([i, j])
#     j += 1
#   end
#   puts row
#   i += 1
# end

# puts

# i = 0
# while i < input.length
#   j = 0
#   row = ''
#   while j < input.length
#     row += "(#{input[i][j]})".rjust(6, ' ') if path.include?([i, j])
#     row += "#{input[i][j].to_s.rjust(6, ' ')}" unless path.include?([i, j])
#     j += 1
#   end
#   puts row
#   i += 1
# end

# pp path
# pp path_values
puts input.last.last - start

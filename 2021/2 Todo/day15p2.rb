# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 15 Part 2
# https://adventofcode.com/2021/day/15#part2
# Answer is: 2887

def min(a, b)
  a > b ? b : a
end

# input = %w[1163751742 1381373672 2136511328 3694931569 7463417111
#            1319128137 1359912421 3125421639 1293138521 2311944581].map { |row| row.split('').map(&:to_i) }
input = File.readlines('../1 Input/day15.input').map { |row| row.strip.split('').map(&:to_i) }

start = input[0][0]
cave_size = input.length

big_input = []
(cave_size * 5).times do
  big_input << Array.new(cave_size * 5, 0)
end

i = 0
while i < cave_size
  j = 0
  while j < cave_size
    big_input[i][j] = input[i][j]
    j += 1
  end
  i += 1
end

i = 0
while i < cave_size
  j = 0
  while j < cave_size
    a = 0
    while a < 5
      b = 0
      while b < 5
        if a.zero? && b.zero?
          b += 1
          next
        elsif a <= b
          big_input[a * cave_size + i][b * cave_size + j] = (big_input[a * cave_size + i][(b - 1) * cave_size + j] % 9) + 1
        else
          big_input[a * cave_size + i][b * cave_size + j] = (big_input[(a - 1) * cave_size + i][b * cave_size + j] % 9) + 1
        end
        b += 1
      end
      a += 1
    end
    j += 1
  end
  i += 1
end

# finish = big_input[big_input.length - 1][big_input.length - 1]

# big_input.each do |row|
#   puts row.join('')
# end

i = 0
while i < cave_size * 5
  j = 0
  while j < cave_size * 5
    if i.zero? && j.zero?
      big_input[i][j] = 0
    elsif i.zero? && j.positive?
      big_input[i][j] += big_input[i][j - 1]
    elsif i.positive? && j.zero?
      big_input[i][j] += big_input[i - 1][j]
    else
      big_input[i][j] += min(big_input[i][j - 1], big_input[i - 1][j])
    end
    j += 1
  end
  i += 1
end

# i = big_input.length - 1
# j = big_input.length - 1

# path = [[i, j]]
# path_values = [big_input[i][j]]

# until [i, j] == [0, 0]
#   if (big_input[i - 1][j] || 999_999_999) < (big_input[i][j - 1] || 999_999_999)
#     path << [i - 1, j]
#     path_values << big_input[i - 1][j]
#     i -= 1
#   else
#     path << [i, j - 1]
#     path_values << big_input[i][j - 1]
#     j -= 1
#   end
# end

# board = []
# (5 * cave_size).times do
#   board << Array.new(5 * cave_size, '.')
# end

# path.each do |row|
#   board[row[0]][row[1]] = 'X'
# end

# board.each do |row|
#   puts row.join('')
# end

puts big_input.last.last - start

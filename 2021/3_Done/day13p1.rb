# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 13 Part 1
# https://adventofcode.com/2021/day/13
# Answer is: 720

def overlap_points(point1, point2)
  return '#' if point1 == '#' || point2 == '#'

  '.'
end

# input = %w[6,10 0,14 9,10 0,3 10,4 4,11 6,0 6,12 4,1 0,13 10,12 3,4 3,0 8,4 1,10 2,14 8,10 9,0]
# folds = ['fold along y=7', 'fold along x=5']

input = []
folds = []
is_fold = false
raw_input = File.readlines('../1_Input/day13.input').map(&:strip)
raw_input.each do |row|
  if is_fold
    folds << row
  elsif row == ''
    is_fold = true
  else
    input << row
  end
end

input = input.map { |i| i.split(',').map(&:to_i) }
folds = folds.map { |f| f.split(' ')[2] }.map { |t| t.split('=') }.each { |a| a[1] = a[1].to_i }

size_x = input.max_by { |p| p[0] }[0] + 1
size_y = input.max_by { |p| p[1] }[1] + 1

board = []
size_y.times do
  board << Array.new(size_x, '.')
end

input.each do |i|
  board[i[1]][i[0]] = '#'
end

# board.each do |row|
#   puts row.join
# end
# puts

[folds.first].each do |fold|
  new_board = board.clone
  visible_points = 0

  i = 0
  while i < new_board.length
    j = 0
    while j < new_board[i].length
      case fold[0]
      when 'x'
        if j > fold[1]
          new_board[i][2 * fold[1] - j] = overlap_points(new_board[i][j], new_board[i][2 * fold[1] - j])
          visible_points += 1 if new_board[i][2 * fold[1] - j] == '#'
        end
      else
        if i > fold[1]
          new_board[2 * fold[1] - i][j] = overlap_points(new_board[i][j], new_board[2 * fold[1] - i][j])
          visible_points += 1 if new_board[2 * fold[1] - i][j] == '#'
        end
      end

      j += 1
    end
    i += 1
  end

  board = new_board[0..fold[1] - 1] if fold[0] == 'y'
  board = new_board.map { |row| row[0..fold[1] - 1] } if fold[0] == 'x'

  puts visible_points
  # board.each do |row|
  #   puts row.join
  # end
  # puts
end

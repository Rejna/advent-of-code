# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 20 Part 2
# https://adventofcode.com/2021/day/20#part2
# Answer is: 16605

def neighbours(i, j, board, infinity)
  [
    (i - 1).negative? || (j - 1).negative? ? infinity : board[i - 1][j - 1],
    (i - 1).negative? ? infinity : board[i - 1][j],
    (i - 1).negative? || j + 1 >= board[i].length ? infinity : board[i - 1][j + 1],
    (j - 1).negative? ? infinity : board[i][j - 1],
    board[i][j],
    j + 1 >= board[i].length ? infinity : board[i][j + 1],
    i + 1 >= board.length || (j - 1).negative? ? infinity : board[i + 1][j - 1],
    i + 1 >= board.length ? infinity : board[i + 1][j],
    i + 1 >= board.length || j + 1 >= board[i].length ? infinity : board[i + 1][j + 1]
  ]
end

def neighbours_to_index(neighbours)
  bin = ''
  neighbours.each do |c|
    bin += c == '#' ? '1' : '0'
  end
  bin.to_i(2)
end

@debug = false
@print_boards = false
# input = File.readlines('../1 Input/day20test.input').map(&:strip)
input = File.readlines('../1 Input/day20.input').map(&:strip)

steps = 50
enhance = input[0]
board = []
input[2..].each do |line|
  board << line.split('')
end

board_size = board.length

(steps * 2).times do
  board.prepend(Array.new(board_size, '.'))
  board << Array.new(board_size, '.')
end

board.each do |row|
  (steps * 2).times do
    row.prepend('.')
    row << '.'
  end
end

if @debug && @print_boards
  puts 'Initial state'
  board.each do |row|
    puts row.join('')
  end
  puts
end

pixels_lit = 0
steps.times do |k|
  pixels_lit = 0
  board_copy = board.map(&:clone)
  infinity_pixel = board_copy[0][0]

  i = 0
  while i < board_copy.length
    j = 0
    while j < board_copy[i].length
      nei = neighbours(i, j, board, infinity_pixel)
      action = enhance[neighbours_to_index(nei)]
      pixels_lit += 1 if action == '#'
      board_copy[i][j] = action

      j += 1
    end
    i += 1
  end

  if @debug
    puts "After step #{k + 1}"
    if @print_boards
      board_copy.each do |row|
        puts row.join('')
      end
    end
    puts "Pixels lit: #{pixels_lit}"
    puts
  end
  board = board_copy
end

puts pixels_lit

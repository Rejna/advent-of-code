# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 25 Part 1
# https://adventofcode.com/2021/day/25
# Answer is: 429

# input = File.readlines('../1 Input/day25test.input').map(&:strip)
input = File.readlines('../1 Input/day25.input').map(&:strip)

board = []
input.each do |row|
  board << row.split('')
end

# puts 'Initial state:'
# board.each do |row|
#   puts row.join('')
# end
# puts
step = 1

loop do
  board_clone = board.map(&:clone)
  moves = 0

  i = 0
  while i < board.length
    j = 0
    while j < board[i].length
      if board[i][j] == '>'
        if j + 1 == board[i].length
          if board[i][0] == '.'
            board_clone[i][j] = '.'
            board_clone[i][0] = '>'
            moves += 1
          end
        elsif board[i][j + 1] == '.'
          board_clone[i][j] = '.'
          board_clone[i][j + 1] = '>'
          moves += 1
        end
      end
      j += 1
    end
    i += 1
  end

  board = board_clone.map(&:clone)
  board_clone = board.map(&:clone)
  i = 0
  while i < board.length
    j = 0
    while j < board[i].length
      if board[i][j] == 'v'
        if i + 1 == board.length
          if board[0][j] == '.'
            board_clone[i][j] = '.'
            board_clone[0][j] = 'v'
            moves += 1
          end
        elsif board[i + 1][j] == '.'
          board_clone[i][j] = '.'
          board_clone[i + 1][j] = 'v'
          moves += 1
        end
      end
      j += 1
    end
    i += 1
  end

  board = board_clone

  # puts "After #{step + 1} step#{step + 1 > 1 ? 's' : ''}:"
  # board.each do |row|
  #   puts row.join('')
  # end
  # puts

  if moves.zero?
    puts step
    break
  end
  step += 1
end

# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 4 Part 1
# https://adventofcode.com/2021/day/4
# Answer is: 27027

def get_sum_of_all_unmarked(board, marked)
  sum = 0
  i = 0
  while i < 5
    j = 0
    while j < 5
      sum += board[i][j] unless marked[i][j]
      j += 1
    end
    i += 1
  end
  sum
end

def look_for_bingoes(called_number)
  i = 0
  while i < @marked.length
    board = @marked[i]
    j = 0
    while j < 5
      return get_sum_of_all_unmarked(@boards[i], @marked[i]) * called_number if board[j].tally[true] == 5

      board_transposed = board.transpose.map(&:reverse)
      return get_sum_of_all_unmarked(@boards[i], @marked[i]) * called_number if board_transposed[j].tally[true] == 5

      j += 1
    end
    i += 1
  end
  0
end

# numbers = [7, 4, 9, 5, 11, 17, 23, 2, 0, 14, 21, 24, 10, 16, 13, 6, 15, 25, 12, 22, 18, 20, 8, 19, 3, 26, 1]
# @boards = [
#   [
#     [22, 13, 17, 11, 0],
#     [8,  2, 23,  4, 24],
#     [21, 9, 14, 16, 7],
#     [6, 10, 3, 18, 5],
#     [1, 12, 20, 15, 19]
#   ],
#   [
#     [3, 15, 0, 2, 22],
#     [9, 18, 13, 17, 5],
#     [19, 8, 7, 25, 23],
#     [20, 11, 10, 24, 4],
#     [14, 21, 16, 12, 6]
#   ],
#   [
#     [14, 21, 17, 24, 4],
#     [10, 16, 15, 9, 19],
#     [18, 8, 23, 26, 20],
#     [22, 11, 13, 6, 5],
#     [2, 0, 12, 3, 7]
#   ]
# ]

input = File.readlines('../1_Input/day04.input').map(&:strip)
numbers = input[0].split(',').map(&:to_i)

i = 2
@boards = []
board = []
input.each do |line|
  if line == ''
    @boards << board
    board = []
    next
  end

  board << line.split(' ').map(&:to_i)
end

@marked = []

@boards.length.times do
  board = []
  @boards[0].length.times do
    board << [false, false, false, false, false]
  end
  @marked << [*board]
end

boards_num = @boards.length
board_size = 5
done = false
bingo = 0

numbers.each do |number|
  # puts "--------- NUMBER #{number} !!!! ----------------"
  i = 0
  while i < boards_num
    j = 0
    while j < board_size
      k = 0
      while k < board_size
        if @boards[i][j][k] == number
          @marked[i][j][k] = true
          bingo = look_for_bingoes(number)
          done = bingo != 0
        end
        break if done

        k += 1
      end
      break if done

      j += 1
    end
    break if done

    i += 1
  end
  break if done
end

puts bingo

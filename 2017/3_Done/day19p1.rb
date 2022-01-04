# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 19 Part 1
# https://adventofcode.com/2017/day/19
# Answer is: NDWHOYRUEA

def move(location, direction)
  case direction
  when 'down'
    [location[0] + 1, location[1]]
  when 'up'
    [location[0] - 1, location[1]]
  when 'left'
    [location[0], location[1] - 1]
  when 'right'
    [location[0], location[1] + 1]
  end
end

input = File.readlines('1_Input/day19.input')
# input = File.readlines('1_Input/day19test.input')

map = []
position = [0, input[0].index('|')]
direction = 'down'

input.each do |row|
  map << if row[..-2] == "\n"
           row[0..-2].gsub(' ', '.').chars
         else
           row.gsub(' ', '.').chars
         end
end

letters = ''

loop do
  next_move = move(position, direction)

  case map[next_move[0]][next_move[1]]
  when '+'
    direction = if %w[up down].include?(direction)
                  if map[next_move[0]][next_move[1] - 1] != '.'
                    'left'
                  else
                    'right'
                  end
                elsif map[next_move[0] - 1][next_move[1]] != '.'
                  'up'
                else
                  'down'
                end
  when /[A-Z]/
    letters += map[next_move[0]][next_move[1]]
  end
  position = next_move

  if map[next_move[0]][next_move[1]] == '.'
    puts letters
    break
  end

  # i = 0
  # while i < map.length
  #   j = 0
  #   while j < map[i].length
  #     putc 'X' if position == [i, j]
  #     putc map[i][j] unless position == [i, j]
  #     j += 1
  #   end
  #   i += 1
  # end
  # gets
  # puts
end

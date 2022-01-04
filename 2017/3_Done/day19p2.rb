# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 19 Part 2
# https://adventofcode.com/2017/day/19#part2
# Answer is: 17540

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

steps = 1

loop do
  next_move = move(position, direction)

  if map[next_move[0]][next_move[1]] == '+'
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
  end
  position = next_move

  break if map[next_move[0]][next_move[1]] == '.'

  steps += 1
end

puts steps

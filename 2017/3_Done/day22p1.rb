# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 22 Part 1
# https://adventofcode.com/2017/day/22
# Answer is: 5538

def turn(current, direction)
  case current
  when 'up'
    case direction
    when 'left'
      'left'
    when 'right'
      'right'
    end
  when 'down'
    case direction
    when 'left'
      'right'
    when 'right'
      'left'
    end
  when 'left'
    case direction
    when 'left'
      'down'
    when 'right'
      'up'
    end
  when 'right'
    case direction
    when 'left'
      'up'
    when 'right'
      'down'
    end
  end
end

def move(position, direction)
  case direction
  when 'up'
    [position[0] - 1, position[1]]
  when 'down'
    [position[0] + 1, position[1]]
  when 'left'
    [position[0], position[1] - 1]
  when 'right'
    [position[0], position[1] + 1]
  end
end

def print_map(map, virus_position)
  i = 0
  while i < map.length
    j = 0
    while j < map.length
      putc 'X' if virus_position == [i, j]
      putc map[i][j] unless virus_position == [i, j]
      putc ' '
      j += 1
    end
    puts
    i += 1
  end
end

input = File.readlines('../1_Input/day22.input').map(&:strip)
extender = 48
# input = File.readlines('../1_Input/day22test.input').map(&:strip)
# extender = 184

map = []
size = 2 * extender + input.length
i = 0

virus_position = [extender + (input.length / 2).floor, extender + (input.length / 2).floor]
virus_direction = 'up'
infections = 0

size.times.each do |k|
  if k < extender || k >= extender + input.length
    map << Array.new(size, '.')
  else
    map << Array.new(extender, '.') + input[i].chars + Array.new(extender, '.')
    i += 1
  end
end

10_000.times.each do
  virus_direction = if map[virus_position[0]][virus_position[1]] == '#'
                      turn(virus_direction, 'right')
                    else
                      turn(virus_direction, 'left')
                    end

  map[virus_position[0]][virus_position[1]] = if map[virus_position[0]][virus_position[1]] == '#'
                                                '.'
                                              else
                                                '#'
                                              end
  infections += 1 if map[virus_position[0]][virus_position[1]] == '#'
  virus_position = move(virus_position, virus_direction)
  # print_map(map, virus_position)
  # gets
end

puts infections

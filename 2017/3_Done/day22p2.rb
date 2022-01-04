# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 22 Part 2
# https://adventofcode.com/2017/day/22#part2
# Answer is: 2511090 in ~6.5s

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
extender = 194
# input = File.readlines('../1_Input/day22test.input').map(&:strip)
# extender = 225

transformations = {
  '.' => 'W',
  'W' => '#',
  '#' => 'F',
  'F' => '.'
}

reverse = {
  'up' => 'down',
  'down' => 'up',
  'left' => 'right',
  'right' => 'left'
}

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

10_000_000.times.each do
  virus_direction = case map[virus_position[0]][virus_position[1]]
                    when '#'
                      turn(virus_direction, 'right')
                    when '.'
                      turn(virus_direction, 'left')
                    when 'F'
                      reverse[virus_direction]
                    when 'W'
                      virus_direction
                    end

  map[virus_position[0]][virus_position[1]] = transformations[map[virus_position[0]][virus_position[1]]]
  infections += 1 if map[virus_position[0]][virus_position[1]] == '#'
  virus_position = move(virus_position, virus_direction)
  # print_map(map, virus_position)
  # puts
end

puts infections

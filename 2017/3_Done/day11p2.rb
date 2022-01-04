# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 11 Part 2
# https://adventofcode.com/2017/day/11#part2
# Answer is: 1493

def distance(point1, point2)
  ((point2[0] - point1[0]).abs.to_f / 2 + (point2[1] - point1[1]).abs.to_f / 2).to_i
end

input = File.readlines('../1_Input/day11.input').map(&:strip)[0]
max_distance = 0

x = 0
y = 0

path = input.split(',')

path.each do |move|
  case move
  when 'ne'
    x += 1
    y += 1
  when 'se'
    x -= 1
    y += 1
  when 'nw'
    x += 1
    y -= 1
  when 'sw'
    x -= 1
    y -= 1
  when 'n'
    x += 2
  when 's'
    x -= 2
  end

  d = distance([0, 0], [x, y])
  max_distance = d if d > max_distance
end

puts max_distance

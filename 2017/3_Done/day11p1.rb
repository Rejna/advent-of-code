# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 11 Part 1
# https://adventofcode.com/2017/day/11
# Answer is: 743

def distance(point1, point2)
  ((point2[0] - point1[0]).abs.to_f / 2 + (point2[1] - point1[1]).abs.to_f / 2).to_i
end

input = File.readlines('../1_Input/day11.input').map(&:strip)
# input = File.readlines('../1_Input/day11test.input').map(&:strip)

input.each do |path|
  x = 0
  y = 0

  pat = path.split(',')

  pat.each do |move|
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
  end
  puts distance([0, 0], [x, y])
end

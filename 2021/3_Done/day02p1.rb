# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 2 Part 1
# https://adventofcode.com/2021/day/2
# Answer is: 2091984

# input = ['forward 5', 'down 5', 'forward 8', 'up 3', 'down 8', 'forward 2']
input = File.readlines('../1_Input/day02.input').map(&:strip)

horizontal = 0
depth = 0

input.each do |command|
  s = command.split(' ')
  val = s[1].to_i

  case s[0]
  when 'forward'
    horizontal += val
  when 'down'
    depth += val
  when 'up'
    depth -= val
  end
end

puts horizontal * depth

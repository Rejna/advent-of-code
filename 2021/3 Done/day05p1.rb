# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 5 Part 1
# https://adventofcode.com/2021/day/5
# Answer is: 5442

def min(a, b)
  a > b ? b : a
end

def max(a, b)
  a > b ? a : b
end

def print_area
  @area.each do |row|
    row.each do |c|
      if c.zero?
        putc '.'
      else
        putc c.to_s
      end
    end
    puts
  end
end

lines = []
@area = []

input = File.readlines('../1 Input/day05.input').map(&:strip)
1000.times do
  @area << Array.new(1000, 0)
end

# input = ['0,9 -> 5,9', '8,0 -> 0,8', '9,4 -> 3,4', '2,2 -> 2,1', '7,0 -> 7,4', '6,4 -> 2,0', '0,9 -> 2,9',
#          '3,4 -> 1,4', '0,0 -> 8,8', '5,5 -> 8,2']
# 20.times do
#   @area << Array.new(20, 0)
# end

input.each do |line|
  points = line.split(' -> ')
  start = points[0].split(',').map(&:to_i)
  finish = points[1].split(',').map(&:to_i)
  lines << [start, finish]
end

lines.each do |line|
  start = line[0]
  finish = line[1]

  if start[0] == finish[0] # vertical
    j = min(start[1], finish[1])
    while j <= max(start[1], finish[1])
      @area[j][start[0]] += 1
      j += 1
    end
  elsif start[1] == finish[1] # horizontal
    j = min(start[0], finish[0])
    while j <= max(start[0], finish[0])
      @area[start[1]][j] += 1
      j += 1
    end
  else
    next
  end
end

puts @area.flatten.length - @area.flatten.tally[0] - @area.flatten.tally[1]

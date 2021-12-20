# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 10
# https://adventofcode.com/2018/day/10
# Answer is: ???

def print_points_on_area(points, area)
end

input = ['position=< 9,  1> velocity=< 0,  2>', 'position=< 7,  0> velocity=<-1,  0>',
         'position=< 3, -2> velocity=<-1,  1>', 'position=< 6, 10> velocity=<-2, -1>',
         'position=< 2, -4> velocity=< 2,  2>', 'position=<-6, 10> velocity=< 2, -2>',
         'position=< 1,  8> velocity=< 1, -1>', 'position=< 1,  7> velocity=< 1,  0>',
         'position=<-3, 11> velocity=< 1, -2>', 'position=< 7,  6> velocity=<-1, -1>',
         'position=<-2,  3> velocity=< 1,  0>', 'position=<-4,  3> velocity=< 2,  0>',
         'position=<10, -3> velocity=<-1,  1>', 'position=< 5, 11> velocity=< 1, -2>',
         'position=< 4,  7> velocity=< 0, -1>', 'position=< 8, -2> velocity=< 0,  1>',
         'position=<15,  0> velocity=<-2,  0>', 'position=< 1,  6> velocity=< 1,  0>',
         'position=< 8,  9> velocity=< 0, -1>', 'position=< 3,  3> velocity=<-1,  1>',
         'position=< 0,  5> velocity=< 0, -1>', 'position=<-2,  2> velocity=< 2,  0>',
         'position=< 5, -2> velocity=< 1,  2>', 'position=< 1,  4> velocity=< 2,  1>',
         'position=<-2,  7> velocity=< 2, -2>', 'position=< 3,  6> velocity=<-1, -1>',
         'position=< 5,  0> velocity=< 1,  0>', 'position=<-6,  0> velocity=< 2,  0>',
         'position=< 5,  9> velocity=< 1, -2>', 'position=<14,  7> velocity=<-2,  0>',
         'position=<-3,  6> velocity=< 2, -1>']
# input = File.readlines('../1 Input/day10.input').map(&:strip)
size = 50
mid_x = 25
mid_y = 25
points = []

input.each do |point|
  puts point
  sp = point.split('> velocity=')
  position = sp[0].gsub('position=< ', '').gsub('position=<', '').gsub(',  ', ',').gsub(', ', ',').split(',').map(&:to_i)
  velocity = sp[1].gsub('< ', '').gsub('<', '').gsub(',  ', ',').gsub(', ', ',').split(',').map(&:to_i)
  points << [position, velocity]
end

seconds = 0

area = []
size.times do
  area << Array.new(size, '.')
end

points.each do |position, _velocity|
  area[position[1]][position[0]] = '#'
end

puts 'Initial state'
area.each do |row|
  puts row.join
end

loop do
# while seconds < 3
  area = []
  size.times do
    area << Array.new(size, '.')
  end

  points.each do |position, velocity|
    position[0] += velocity[0]
    position[1] += velocity[1]
    area[(mid_y+position[1]) % size][(mid_x+position[0]) % size] = '#'
  end

  seconds += 1
  puts "After #{seconds} seconds"
  area.each do |row|
    puts row.join
  end
  pp points
  puts 'xxxxxxxxxxxxxxxxxx'
  gets
end

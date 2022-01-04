# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 20 Part 1
# https://adventofcode.com/2017/day/20
# Answer is: 150

def manhattan_distance3d(position)
  position[0].abs + position[1].abs + position[2].abs
end

input = File.readlines('../1_Input/day20.input')
# input = File.readlines('../1_Input/day20test.input')

POSITION = 0
VELOCITY = 1
ACC = 2

X = 0
Y = 1
Z = 2

particles = []

input.each do |inp|
  sp = inp.split(', ')
  position = sp[POSITION]
  velocity = sp[VELOCITY]
  acc = sp[ACC]

  position = position[3..-2].split(',').map(&:strip).map(&:to_i)
  velocity = velocity[3..-2].split(',').map(&:strip).map(&:to_i)
  acc = acc[3..-2].split(',').map(&:strip).map(&:to_i)

  particles << [position, velocity, acc]
end

500.times.each do
  particles.each do |p|
    p[VELOCITY][X] += p[ACC][X]
    p[VELOCITY][Y] += p[ACC][Y]
    p[VELOCITY][Z] += p[ACC][Z]

    p[POSITION][X] += p[VELOCITY][X]
    p[POSITION][Y] += p[VELOCITY][Y]
    p[POSITION][Z] += p[VELOCITY][Z]
  end
end

puts particles.index(particles.min_by { |v| manhattan_distance3d(v[0]) })

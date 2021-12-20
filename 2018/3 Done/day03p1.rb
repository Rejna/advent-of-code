# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 3 Part 1
# https://adventofcode.com/2018/day/3
# Answer is: 107043

# input = ['#123 @ 3,2: 5x4']
# fabric_size = 10
# input = ['#1 @ 1,3: 4x4', '#2 @ 3,1: 4x4', '#3 @ 5,5: 2x2']
# fabric_size = 8
input = File.readlines('../1 Input/day03.input').map(&:strip)
fabric_size = 1000

fabric = []
fabric_size.times do
  fabric << Array.new(fabric_size, '.')
end
overlaps = 0

input.each do |claim|
  spl = claim.split(' ')
  # claim_id = spl[0]
  # at = spl[1]
  left_top_corner = spl[2].gsub(':', '').split(',').map(&:to_i)
  size = spl[3].split('x').map(&:to_i)

  i = left_top_corner[1]
  j = left_top_corner[0]

  size[1].times do |a|
    size[0].times do |b|
      if fabric[i + a][j + b] == '#'
        overlaps += 1
        fabric[i + a][j + b] = 'X'
      end
      fabric[i + a][j + b] = '#' if fabric[i + a][j + b] == '.'
    end
  end
end

puts overlaps

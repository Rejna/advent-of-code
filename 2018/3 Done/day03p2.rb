# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 3 Part 2
# https://adventofcode.com/2018/day/3#part2
# Answer is: 346

input = File.readlines('../1 Input/day03.input').map(&:strip)
fabric_size = 1000

fabric = []
fabric_size.times do
  fabric << Array.new(fabric_size, '.')
end

no_overlaps = []

input.each do |claim|
  spl = claim.split(' ')
  claim_id = spl[0]
  no_overlaps << claim_id
  # at = spl[1]
  left_top_corner = spl[2].gsub(':', '').split(',').map(&:to_i)
  size = spl[3].split('x').map(&:to_i)

  i = left_top_corner[1]
  j = left_top_corner[0]

  size[1].times do |a|
    size[0].times do |b|
      if fabric[i + a][j + b].include?('#') || fabric[i + a][j + b] == 'X'
        no_overlaps.delete(claim_id)
        no_overlaps.delete(fabric[i + a][j + b])
        fabric[i + a][j + b] = 'X'
      end
      fabric[i + a][j + b] = claim_id if fabric[i + a][j + b] == '.'
    end
  end
end

puts no_overlaps[0].gsub('#', '')

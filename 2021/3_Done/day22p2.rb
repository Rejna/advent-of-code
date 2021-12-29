# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 22 Part 2
# https://adventofcode.com/2021/day/22#part2
# Answer is: 1125649856443608

def min(a, b)
  a < b ? a : b
end

def max(a, b)
  a > b ? a : b
end

def overlap(box_a, box_b)
  res = []
  i = 0
  while i < 3
    return nil if box_a[i][1] < box_b[i][0] || box_b[i][1] < box_a[i][0]

    res << [max(box_a[i][0], box_b[i][0]), min(box_a[i][1], box_b[i][1])]
    i += 1
  end

  res
end

def volume(box)
  v = 1
  box.each do |ax|
    v *= (ax[1] - ax[0]).abs + 1
  end
  v
end

# inputs = File.readlines('../1_Input/day22smalltest.input').map(&:strip)
# inputs = File.readlines('../1_Input/day22largetest.input').map(&:strip)
inputs = File.readlines('../1_Input/day22.input').map(&:strip)

steps = []

inputs.each do |input|
  input_s = input.split(' ')
  switch = input_s[0] == 'on' # on/off
  coords = input_s[1].split(',')

  x_range = coords[0][2..].split('..').map(&:to_i)
  y_range = coords[1][2..].split('..').map(&:to_i)
  z_range = coords[2][2..].split('..').map(&:to_i)

  steps << [[x_range, y_range, z_range], switch]
end

counts = Hash.new { |h, k| h[k] = 0 }
steps.each do |step|
  operation_box, switch = step

  new_counts = Hash.new { |h, k| h[k] = 0 }
  counts.keys.uniq.each do |box|
    over = overlap(box, operation_box)

    new_counts[over] -= counts[box] unless over.nil?
  end

  new_counts[operation_box] += 1 if switch

  new_counts.each do |k, v|
    counts[k] += v
  end
end

total_count = 0
counts.each do |box, c|
  total_count += volume(box) * c
end

puts total_count

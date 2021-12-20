# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 8 Part 1
# https://adventofcode.com/2019/day/8
# Answer is: 2250

# input = '123456789012'
# width = 3
# height = 2
input = File.readlines('../1 Input/day08.input')[0].strip
width = 25
height = 6
layers = []
layer_size = width * height
layer_count = input.length / layer_size

i = 0
while i < layer_count
  layer = []
  j = 0
  while j < height
    k = 0
    row = []
    while k < width
      row << input[i * layer_size + j * width + k]
      k += 1
    end
    layer << [*row]
    j += 1
  end
  layers << [*layer]
  i += 1
end

# layers.each do |layer|
#   layer.each do |row|
#     puts row.join('')
#   end
#   puts '---------------------------------'
# end

min_layer = []
min_layer_zeroes = 999_999
layers.each do |layer|
  if (layer.flatten.tally['0'] || 0) < min_layer_zeroes
    min_layer = layer
    min_layer_zeroes = layer.flatten.tally['0'] || 0
  end
end

puts min_layer.flatten.tally['1'] * min_layer.flatten.tally['2']

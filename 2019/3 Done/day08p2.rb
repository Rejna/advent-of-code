# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 8 Part 2
# https://adventofcode.com/2019/day/8#part2
# Answer is: FHJUL

input = '0222112222120000'
width = 2
height = 2
# input = File.readlines('../1 Input/day08.input')[0].strip
# width = 25
# height = 6
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

message = []
height.times do
  message << []
end

pp message

i = 0
while i < height
  j = 0
  while j < width
    k = 1
    pixel = layers[0][i][j]
    while k < layer_count
      if pixel == '2'
        # puts "#{i} #{j} - #{layers[k][i][j]}"
        pixel = layers[k][i][j]
        k += 1
      end
      if pixel != '2' || k == layer_count
        k += 1
        next
      end

      # puts "Final #{i} #{j} - #{pixel}"
      # puts '----------------------'
      message[i][j] = pixel
      # gets
    end
    j += 1
  end
  i += 1
end

message.each do |row|
  puts row.join('').gsub!('0', ' ')
end

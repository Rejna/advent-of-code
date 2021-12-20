# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 6 Part 1
# https://adventofcode.com/2018/day/6
# Answer is: ???

input = File.readlines('../1 Input/day06test.input').map { |t| t.split(',').map(&:to_i) }
size = 10
# input = File.readlines('../1 Input/day06.input').map { |t| t.split(',').map(&:to_i) }

area = []
size.times do
  area << Array.new(size, 'o')
end

i = 'A'.ord
input.each do |point|
  area[point[1]][point[0]] = i.chr
  i += 1
end

i = 0
while i < size
  j = 0
  while j < size
    if input.include?([j, i])
      j += 1
      next
    end

    min_dist = 99_999_999_999
    min_letter = ''

    input.each do |point|
      dist = (point[1] - i).abs + (point[0] - j).abs
      if dist < min_dist
        min_dist = dist
        min_letter = area[point[1]][point[0]]
      end
    end

    area[j][i] = area[j][i] == 'o' ? min_letter.downcase : '.'

    j += 1
  end
  i += 1
end

area.each do |row|
  puts row.join
end

# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 22 Part 1
# https://adventofcode.com/2018/day/22
# Answer is: 10603

# input = File.readlines('../1 Input/day22test.input').map(&:strip)
input = File.readlines('../1 Input/day22.input').map(&:strip)

depth = input[0].split(' ')[1].to_i
target = input[1].split(' ')[1].split(',').map(&:to_i)
risk_levels = {
  '.' => 0,
  '=' => 1,
  '|' => 2
}

erosion_levels = []
cave = []
(target[1] + 1).times.each do
  erosion_levels << Array.new(target[0] + 1, 0)
  cave << Array.new(target[0] + 1, 'x')
end

i = 0
while i <= target[1]
  j = 0
  while j <= target[0]
    geologic_index = if (i.zero? && j.zero?) || (i == target[1] && j == target[0])
                       0
                     elsif i.zero?
                       j * 16_807
                     elsif j.zero?
                       i * 48_271
                     else
                       erosion_levels[i][j - 1] * erosion_levels[i - 1][j]
                     end

    erosion_levels[i][j] = (geologic_index + depth) % 20_183
    cave[i][j] = case erosion_levels[i][j] % 3
                 when 0
                   '.'
                 when 1
                   '='
                 else
                   '|'
                 end
    j += 1
  end
  i += 1
end

# cave[0][0] = 'M'
# cave[target[1]][target[0]] = 'T'

result = 0
cave.flatten.map { |c| result += risk_levels[c] }
puts result

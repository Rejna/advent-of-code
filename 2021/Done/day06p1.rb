# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 6 Part 1
# https://adventofcode.com/2021/day/6
# Answer is: 376194

# input = [3, 4, 3, 1, 2]
input = File.readlines('day06.input')[0].strip.split(',').map(&:to_i)
day = 0

# puts "Initial state: #{input.join(',')}"
while day < 80
  input2 = [*input]
  i = 0
  while i < input.length
    if input[i].zero?
      input2[i] = 6
      input2 << 8
    else
      input2[i] = (input[i] - 1) % 7 if input[i] < 7
      input2[i] = input[i] - 1 unless input[i] < 7
    end

    i += 1
  end
  input = input2
  day += 1
  # puts "After #{day}: #{input.join(',')} (#{input.length} fish)"
end

puts input.length

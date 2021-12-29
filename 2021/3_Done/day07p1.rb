# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 7 Part 1
# https://adventofcode.com/2021/day/7
# Answer is: 335271

# input = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]
input = File.readlines('../1_Input/day07.input')[0].strip.split(',').map(&:to_i)

min_fuel = 99_999_999_999
# min_location = 0
target_location = 0

while target_location <= input.max
  total_fuel = 0

  input.each do |a|
    total_fuel += (target_location - a).abs
  end

  if total_fuel < min_fuel
    min_fuel = total_fuel
    # min_location = target_location
  end

  target_location += 1
end

# puts "Minimum fuel: #{min_fuel} at #{min_location}"
puts min_fuel

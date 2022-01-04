# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 6 Part 2
# https://adventofcode.com/2017/day/6#part2
# Answer is: 2392

input = File.readlines('../1_Input/day06.input').map(&:strip)[0].split(/\t/).map(&:to_i)
# input = File.readlines('../1_Input/day06test.input').map(&:strip)[0].split(/\t/).map(&:to_i)

counter = 0
configurations = [input.join(',')]

loop do
  max = input.max
  min_index = input.find_index(max)
  input[min_index] = 0

  max.times.each do |k|
    input[(min_index + k + 1) % input.length] += 1
  end

  counter += 1

  break if configurations.include?(input.join(','))

  configurations << input.join(',')
end

puts counter - configurations.find_index(input.join(','))

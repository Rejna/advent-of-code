# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 15 Part 1
# https://adventofcode.com/2020/day/15
# Answer is: 700

# input = [0, 0, 3, 6]
# last_heard = { 0 => 1, 3 => 2 }
# input = [0, 1, 3, 2]
# last_heard = { 1 => 1, 3 => 2 }
# input = [0, 2, 1, 3]
# last_heard = { 2 => 1, 1 => 2 }
# input = [0, 3, 1, 2]
# last_heard = { 3 => 1, 1 => 2 }

# input = [0, File.readlines('../1 Input/day15.input')[0].strip.split(',').map(&:to_i)].flatten
# last_heard = {}
# i = 1
# input[1..-2].each do |a|
#   last_heard[a] = i
#   i += 1
# end
# pp i
# pp last_heard
# pp input

input = [0, 6, 3, 15, 13, 1, 0]
last_heard = { 6 => 1, 3 => 2, 15 => 3, 13 => 4, 1 => 5 }
i = 6

while i < 2020
  input << if last_heard.keys.include?(input[i])
             i - last_heard[input[i]]
           else
             input << 0
           end
  last_heard[input[i]] = i
  i += 1
end

puts input[2020]

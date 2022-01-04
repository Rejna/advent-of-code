# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 1 Part 2
# https://adventofcode.com/2017/day/1#part2
# Answer is: 1092

input = File.readlines('../1_Input/day01.input').map(&:strip)
# input = File.readlines('../1_Input/day01test2.input').map(&:strip)

input.each do |i|
  ind = 0
  sum = 0
  while ind < i.length
    ind1 = ind
    ind2 = (ind + (i.length / 2)) % i.length

    sum += i[ind1].to_i if i[ind1] == i[ind2]
    ind += 1
  end
  puts sum
end

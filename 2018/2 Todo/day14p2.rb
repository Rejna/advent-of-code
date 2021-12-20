# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 14 Part 2
# https://adventofcode.com/2018/day/14#part2
# Answer is: ???

input = '37'

# string_to_find = '51589'
# string_to_find = '01245'
# string_to_find = '92510'
# string_to_find = '59414'
string_to_find = '580741'

first_elf = 0
second_elf = 1

loop do
  input += (input[first_elf].to_i + input[second_elf].to_i).to_s

  first_elf = (first_elf + 1 + input[first_elf].to_i) % input.length
  second_elf = (second_elf + 1 + input[second_elf].to_i) % input.length

  unless input.index(string_to_find).nil?
    puts input.index(string_to_find)
    break
  end
end

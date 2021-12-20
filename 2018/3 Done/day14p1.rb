# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 14 Part 1
# https://adventofcode.com/2018/day/14
# Answer is: 6910849249 in 3m7s

input = '37'

# number_of_recipies = 5
# number_of_recipies = 9
# number_of_recipies = 18
# number_of_recipies = 2_018
number_of_recipies = 580_741

first_elf = 0
second_elf = 1

loop do
  first_elf_value = input[first_elf].to_i
  second_elf_value = input[second_elf].to_i

  input += (first_elf_value + second_elf_value).to_s

  first_elf = (first_elf + 1 + first_elf_value) % input.length
  second_elf = (second_elf + 1 + second_elf_value) % input.length

  if input.length >= number_of_recipies + 10
    puts input[number_of_recipies, 10].join
    break
  end
end

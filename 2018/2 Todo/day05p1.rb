# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 5 Part 1
# https://adventofcode.com/2018/day/5
# Answer is: ???

# input = 'dabAcCaCBAcCcaDA'
input = File.read('../1 Input/day05.input')
puts input.length

# loop do
  new_input = ''
  i = 0
  while i < input.length
    if i + 1 < input.length && input[i].downcase == input[i + 1].downcase
      i += 2
    else
      new_input += input[i]
      i += 1
    end
  end
  input = new_input
  # break if reductions.zero?
# end

puts input
puts input.length

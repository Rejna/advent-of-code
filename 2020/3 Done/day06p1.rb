# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 6 Part 1
# https://adventofcode.com/2020/day/6
# Answer is: 6703

# input = ["abc', '', 'a', 'b', 'c', '', 'ab', 'ac', '', 'a', 'a', 'a', 'a', '', 'b"]
input = File.readlines('../1 Input/day06.input').map(&:strip)

group = ''
groups = []
input.each do |line|
  if line == ''
    groups << group.strip
    group = ''
  else
    group += line
  end
end
groups << group

total_count = 0
groups.each do |g|
  answers = ''
  g = g.split('')
  g.each do |q|
    answers += q unless answers.include?(q)
  end
  # puts "#{g} - questions answered #{answers.length}"
  total_count += answers.length
end
puts total_count

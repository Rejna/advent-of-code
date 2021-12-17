# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 6 Part 2
# https://adventofcode.com/2020/day/6#part2
# Answer is: 3430

# input = ['abc','','a','b','c','','ab','ac','','a','a','a','a','','b']
input = File.readlines('../1 Input/day06.input').map(&:strip)

group = ''
groups = []
input.each do |line|
  if line == ''
    groups << group.strip
    group = ''
  else
    group += " #{line}"
  end
end
groups << group

total_count = 0
groups.each do |g|
  answers = {}
  g = g.split(' ')
  people_count = g.length
  g.each do |person|
    person = person.split('')
    person.each do |q|
      answers[q] += 1 if answers.keys.include?(q)
      answers[q] = 1 unless answers.keys.include?(q)
    end
  end

  group_count = 0
  answers.each do |_k, v|
    group_count += 1 if v == people_count
  end
  # puts "#{g} - questions all answered #{group_count}"
  total_count += group_count
end
puts total_count

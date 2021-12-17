# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 2 Part 2
# https://adventofcode.com/2020/day/2#part2
# Answer is: 294

# input = ['1-3 a: abcde', '1-3 b: cdefg', '2-9 c: ccccccccc']
input = File.readlines('../1 Input/day02.input').map(&:strip)
valid = 0

input.each do |line|
  sp = line.split(' ')
  limits = sp[0].split('-')
  min = limits[0].to_i
  max = limits[1].to_i
  char = sp[1].gsub!(':', '')
  password = sp[2].split('')

  valid += 1 if (password[min - 1] == char && password[max - 1] != char) ||
                (password[min - 1] != char && password[max - 1] == char)
end

puts valid

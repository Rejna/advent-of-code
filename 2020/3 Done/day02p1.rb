# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 2 Part 1
# https://adventofcode.com/2020/day/2
# Answer is: 465

input = File.readlines('../1 Input/day02.input').map(&:strip)
valid = 0

input.each do |line|
  sp = line.split(' ')
  limits = sp[0].split('-')
  min = limits[0].to_i
  max = limits[1].to_i
  char = sp[1].gsub!(':', '')
  password = sp[2].split('')
  count = 0

  password.each do |c|
    count += 1 if c == char
  end
  if count >= min && count <= max
    # puts "#{line} valid"
    valid += 1
  end
end

# puts "#{valid} valid"
puts valid

# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 4 Part 1
# https://adventofcode.com/2019/day/4
# Answer is: 1019

def double_condition(num)
  num[0] == num[1] || num[1] == num[2] || num[2] == num[3] || num[3] == num[4] || num[4] == num[5]
end

def increasing_condition(num)
  num.join == num.sort.join
end

min = 248_345
max = 746_315
counter = 0

while min <= max
  min_str = min.to_s.split('')

  if double_condition(min_str) && increasing_condition(min_str)
    puts min_str.join
    counter += 1
  end
  min += 1
end

puts counter

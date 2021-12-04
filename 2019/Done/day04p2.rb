# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 4 Part 2
# https://adventofcode.com/2019/day/4
# Answer is: 660

def double_condition(num)
  i = 0
  has_it = false
  while i < 5
    has_it = true if (num[i - 1] != num[i] || i.zero?) && num[i] == num[i + 1] && (num[i + 1] != num[i + 2] || i == 4)
    i += 1
  end
  has_it
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

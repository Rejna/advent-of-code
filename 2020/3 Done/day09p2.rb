# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 9 Part 2
# https://adventofcode.com/2020/day/9#part2
# Answer is: 55732936

# input = [20, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 1, 21, 22, 23, 24, 25, 45, 66]
# input = [35, 20, 15, 25, 47, 40, 62, 55, 65, 95, 102, 117, 150, 182, 127, 219, 299, 277, 309, 576]
input = File.readlines('../1 Input/day09.input').map(&:strip).map(&:to_i)

i_start = 0
i_end = 24
i = 25

while i < input.length
  to_check = input[i]
  check_area = input[i_start..i_end]
  valid = false

  check_area.each do |a|
    next unless check_area.include?(to_check - a) && to_check - a != a

    # puts "#{to_check} is valid, #{a} + #{to_check-a} = #{to_check}"
    valid = true
    break
  end

  unless valid
    # puts to_check
    break
  end

  i += 1
  i_start += 1
  i_end += 1
end

set_size = 2
found = false

while set_size <= input.length
  i_start = 0
  while i_start < input.length - set_size
    if input[i_start, set_size].sum == to_check
      # puts "#{to_check} = #{input[i_start, set_size].join(' + ')}"
      found = true
      break
    end
    i_start += 1
  end
  break if found

  set_size += 1
end

puts input[i_start, set_size].min + input[i_start, set_size].max

# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 4 Part 2
# https://adventofcode.com/2017/day/4#part2
# Answer is: 186

input = File.readlines('../1_Input/day04.input').map(&:strip)
# input = File.readlines('../1_Input/day04test2.input').map(&:strip)

valid_count = 0
input.each do |row|
  valid = true
  sp = row.split(' ')
  i = 0
  while i < sp.length
    j = 0
    while j < sp.length
      if i == j
        j += 1
        next
      end

      if sp[i].split('').sort == sp[j].split('').sort
        valid = false
        break
      end
      j += 1
    end
    break unless valid

    i += 1
  end

  valid_count += 1 if valid
end

puts valid_count

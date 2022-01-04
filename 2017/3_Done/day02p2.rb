# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 2 Part 2
# https://adventofcode.com/2017/day/2#part2
# Answer is: 221

input = File.readlines('../1_Input/day02.input').map(&:strip)
# input = File.readlines('../1_Input/day02test2.input').map(&:strip)

sum = 0

input.each do |row|
  sp = row.split(/\t/).map(&:to_i)

  done = false
  sp.each do |a|
    sp.each do |b|
      next if a == b

      next unless a >= b && (a % b).zero?

      sum += a / b
      done = true
      break
    end
    break if done
  end
end

puts sum

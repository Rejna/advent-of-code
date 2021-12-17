# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 1 Part 2
# https://adventofcode.com/2018/day/1#part2
# Answer is: 566

# inputs = [[%w[+1 -1], 0],
#           [%w[+3 +3 +4 -2 -4], 10],
#           [%w[-6 +3 +8 +5 -6], 5],
#           [%w[+7 +7 -2 -7 -4], 14]]
inputs = [File.readlines('day01.input').map(&:strip).map { |a| a.gsub('+', '').to_i }]

inputs.each do |input|
  freqs = {} # bool hashes are much faster than Array.include?
  freqs[0] = true
  freq = 0
  i = 0

  if input.length == 2
    loop do
      freq += input[0][i % input[0].length].gsub('+', '').to_i
      break if freqs

      freqs[freq] = true
      i += 1
    end

    puts "#{freq} | #{freq == input[1] ? 'OK' : 'BAD'}"
  else
    loop do
      freq += input[i % input.length]
      break if freqs[freq]

      freqs[freq] = true
      i += 1
    end
    puts freq
  end
end

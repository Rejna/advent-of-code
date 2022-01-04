# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 9 Part 1
# https://adventofcode.com/2017/day/9
# Answer is: 11898

input = File.readlines('../1_Input/day09.input').map(&:strip)
# input = File.readlines('../1_Input/day09test.input').map(&:strip)

input.each do |stream|
  depth = 0
  score = 0
  inside_garbage = false
  str = stream.chars

  i = 0
  while i < stream.length
    c = str[i]
    case c
    when '{'
      unless inside_garbage
        depth += 1
        score += depth
      end
    when '}'
      depth -= 1 unless inside_garbage
    when '<'
      inside_garbage = true
    when '>'
      inside_garbage = false
    when '!'
      i += 2
    end
    i += 1 unless c == '!'
  end
  puts score
end

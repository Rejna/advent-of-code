# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 9 Part 2
# https://adventofcode.com/2017/day/9#part2
# Answer is: 5601

input = File.readlines('../1_Input/day09.input').map(&:strip)
# input = File.readlines('../1_Input/day09test2.input').map(&:strip)

input.each do |stream|
  garbage = 0
  inside_garbage = false
  str = stream.chars

  i = 0
  while i < stream.length
    c = str[i]
    if c == '<'
      if inside_garbage
        garbage += 1
      else
        inside_garbage = true
      end
    elsif c == '>'
      if inside_garbage
        inside_garbage = false
      else
        garbage += 1
      end
    elsif c == '!'
      i += 2
    elsif inside_garbage
      garbage += 1
    end
    i += 1 unless c == '!'
  end
  puts garbage
end

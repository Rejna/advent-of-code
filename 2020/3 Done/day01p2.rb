# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 1 Part 2
# https://adventofcode.com/2020/day/1#part2
# Answer is: 272611658

input = File.readlines('../1 Input/day01.input').map(&:strip).map(&:to_i)
done = false

input.each do |i|
  temp = 2020 - i
  input.each do |j|
    next unless input.include?(temp - j)

    puts i * j * (temp - j)
    done = true
    break
  end
  break if done
end

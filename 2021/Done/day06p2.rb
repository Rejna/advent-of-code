# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 6 Part 2
# https://adventofcode.com/2021/day/6#part2
# Answer is: 1693022481538

# input = [3, 4, 3, 1, 2]
input = File.readlines('day06.input')[0].strip.split(',').map(&:to_i)
day = 0
fish_age = input.tally

# puts "Initial state: #{fish_age}"
while day < 256
  fish_age2 = fish_age.clone

  fish_age.each do |age, fish_no|
    if age.zero?
      fish_age2[8] += fish_no if fish_age2.keys.include?(8)
      fish_age2[8] = fish_no unless fish_age2.keys.include?(8)
      fish_age2[6] += fish_no if fish_age2.keys.include?(6)
      fish_age2[6] = fish_no unless fish_age2.keys.include?(6)
      fish_age2[0] -= fish_no if fish_age2.keys.include?(0)
    elsif age < 7
      new_age = (age - 1) % 7
      fish_age2[age] -= fish_no if fish_age2.keys.include?(age)
      fish_age2[age] = fish_no unless fish_age2.keys.include?(age)
      fish_age2[new_age] += fish_no if fish_age2.keys.include?(new_age)
      fish_age2[new_age] = fish_no unless fish_age2.keys.include?(new_age)
    else
      fish_age2[age - 1] += fish_no if fish_age2.keys.include?(age - 1)
      fish_age2[age - 1] = fish_no unless fish_age2.keys.include?(age - 1)
      fish_age2[age] -= fish_no if fish_age2.keys.include?(age)
    end
  end

  fish_age = fish_age2.clone
  day += 1

  # puts "After #{day} day#{day > 1 ? 's' : ''}: #{fish_age.reject { |k, v| v.zero? }} (#{fish_age.values.sum} fish)"
end

puts fish_age.values.sum

# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 14 Part 1
# https://adventofcode.com/2021/day/14
# Answer is: 3230

# input = 'NNCB'
# p = ['CH -> B', 'HH -> N', 'CB -> H', 'NH -> C', 'HB -> C', 'HC -> B', 'HN -> C', 'NN -> C', 'BH -> H',
#      'NC -> B', 'NB -> B', 'BN -> B', 'BB -> N', 'BC -> B', 'CC -> N', 'CN -> C']
raw_input = File.readlines('day14.input').map(&:strip)
input = raw_input[0]
p = raw_input[2..]

pairs = {}

p.each do |pair|
  ps = pair.split(' -> ')
  pairs[ps[0]] = ps[1]
end

# puts "Initial state: #{input}"

10.times do # |k|
  new_input = ''
  i = 0
  while i < input.length - 1
    new_input += "#{input[i]}#{pairs["#{input[i]}#{input[i + 1]}"]}"
    new_input += input[i + 1] if i == input.length - 2
    i += 1
  end

  input = new_input
  # t = input.split('').tally
  # puts "After step #{k + 1}: #{t.values.max - t.values.min}"
end

t = input.split('').tally
puts t.values.max - t.values.min

# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 25 Part 1
# https://adventofcode.com/2017/day/25
# Answer is: 2794 in 2.2s

input = File.readlines('1_Input/day25.input').map(&:strip)
# input = File.readlines('1_Input/day25test.input').map(&:strip)

state = input[0].split(' ').last[0]
diagnostic_after = input[1].split(' ')[-2].to_i
states = {}
tape_size = 4_500
tape = Array.new(tape_size, 0)
pointer = tape_size / 2

i = 3
while i < input.length
  state_name = input[i].split(' ').last[0]
  zero_action = [
    input[i + 2].split(' ').last[0..-2].to_i,
    input[i + 3].split(' ').last[0..-2] == 'left' ? -1 : 1,
    input[i + 4].split(' ').last[0]
  ]
  one_action = [
    input[i + 6].split(' ').last[0..-2].to_i,
    input[i + 7].split(' ').last[0..-2] == 'left' ? -1 : 1,
    input[i + 8].split(' ').last[0]
  ]
  i += 10
  states[state_name] = [zero_action, one_action]
end

diagnostic_after.times.each do
  action = states[state][tape[pointer]]
  tape[pointer] = action[0]
  pointer += action[1]
  state = action[2]
end

puts tape.sum

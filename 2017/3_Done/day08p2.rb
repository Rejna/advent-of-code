# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 8 Part 2
# https://adventofcode.com/2017/day/8#part2
# Answer is: 6026

input = File.readlines('../1_Input/day08.input').map(&:strip)
# input = File.readlines('../1_Input/day08test.input').map(&:strip)

memory = {}
max_value = 0

input.each do |row|
  sp = row.split(' if ')
  operands = sp[0].split(' ')
  register = operands[0]
  operation = operands[1] == 'inc' ? '+' : '-'
  value = operands[2].to_i

  condition = sp[1].split(' ')
  lhs = condition[0]
  operand = condition[1]
  rhs = condition[2]

  memory[register] = 0 unless memory.key?(register)
  memory[lhs] = 0 unless memory.key?(lhs)

  eval("memory['#{register}'] #{operation}= #{value} if memory['#{lhs}'] #{operand} #{rhs}")

  max_value = memory.values.max if memory.values.max > max_value
end

puts max_value

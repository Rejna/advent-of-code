# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 2 Part 1
# https://adventofcode.com/2019/day/2
# Answer is: 3166704

# memory = [1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50]
memory = File.readlines('../1 Input/day02.input')[0].strip.split(',').map(&:to_i)

memory[1] = 12
memory[2] = 2
pointer = 0

loop do
  op = memory[pointer]

  case op
  when 1
    operand = '+'
  when 2
    operand = '*'
  when 99
    break
  end

  val1 = memory[memory[pointer + 1]]
  val2 = memory[memory[pointer + 2]]
  addr = memory[pointer + 3]
  memory[addr] = val1.method(operand).call(val2)

  pointer += 4
end

puts memory[0]

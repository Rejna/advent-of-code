# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 23 Part 1
# https://adventofcode.com/2017/day/23
# Answer is: 6724

input = File.readlines('../1_Input/day23.input').map(&:strip)

registers = {
  'a' => 0,
  'b' => 0,
  'c' => 0,
  'd' => 0,
  'e' => 0,
  'f' => 0,
  'g' => 0,
  'h' => 0
}

mul_counter = 0
pointer = 0

loop do
  jumped = false
  command = input[pointer]
  sp = command.split(' ')
  opcode = sp[0]
  lhs = sp[1] =~ /[a-z]/ ? registers[sp[1]] : sp[1].to_i
  lhs_register = sp[1]
  rhs = sp[2] =~ /[a-z]/ ? registers[sp[2]] : sp[2].to_i

  case opcode
  when 'set'
    registers[lhs_register] = rhs
  when 'sub'
    registers[lhs_register] -= rhs
  when 'mul'
    registers[lhs_register] *= rhs
    mul_counter += 1
  when 'jnz'
    unless lhs.zero?
      pointer += rhs
      jumped = true
    end
  end

  pointer += 1 unless jumped
  break if pointer >= input.length || pointer.negative?
end

puts mul_counter

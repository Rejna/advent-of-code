# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 19 Part 1
# https://adventofcode.com/2018/day/19
# Answer is: 2106

def function(function_name, registers, a, b, c)
  temp_registers = registers.clone
  temp_registers[c] = case function_name
                      when 'addr'
                        temp_registers[a] + temp_registers[b]
                      when 'addi'
                        temp_registers[a] + b
                      when 'mulr'
                        temp_registers[a] * temp_registers[b]
                      when 'muli'
                        temp_registers[a] * b
                      when 'banr'
                        temp_registers[a] & temp_registers[b]
                      when 'bani'
                        temp_registers[a] & b
                      when 'borr'
                        temp_registers[a] | temp_registers[b]
                      when 'bori'
                        temp_registers[a] | b
                      when 'setr'
                        temp_registers[a]
                      when 'seti'
                        a
                      when 'gtri'
                        temp_registers[a] > b ? 1 : 0
                      when 'gtir'
                        a > temp_registers[b] ? 1 : 0
                      when 'gtrr'
                        temp_registers[a] > temp_registers[b] ? 1 : 0
                      when 'eqri'
                        temp_registers[a] == b ? 1 : 0
                      when 'eqir'
                        a == temp_registers[b] ? 1 : 0
                      when 'eqrr'
                        temp_registers[a] == temp_registers[b] ? 1 : 0
                      end
  temp_registers
end

# input = File.readlines('../1 Input/day19test.input').map(&:strip)
input = File.readlines('../1 Input/day19.input').map(&:strip)

instruction_pointer = input[0].split(' ')[1].to_i
registers = [0, 0, 0, 0, 0, 0]
memory = []
input[1..].each do |command|
  sp = command.split(' ')
  memory << [sp[0], sp[1].to_i, sp[2].to_i, sp[3].to_i]
end

loop do
  command = memory[registers[instruction_pointer]]
  break if command.nil?

  result = function(command[0], registers, command[1], command[2], command[3])

  break if registers[instruction_pointer] + 1 == memory.length

  result[instruction_pointer] += 1
  registers = result
end

puts registers[0]

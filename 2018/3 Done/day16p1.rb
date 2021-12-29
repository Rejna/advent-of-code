# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 16 Part 1
# https://adventofcode.com/2018/day/16
# Answer is: 624

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

input = File.readlines('../1 Input/day16.input').map(&:strip)
# input = File.readlines('../1 Input/day16test.input').map(&:strip)
all_functions = %w[addr addi mulr muli banr bani borr bori gtrr gtri gtir eqrr eqri eqir setr seti]
i = 0
counter = 0

loop do
  sample = input[i, 3]
  sample_counter = 0
  break if sample[0].empty?

  before = sample[0][9..-2].split(', ').map(&:to_i)
  command = sample[1].split(' ').map(&:to_i)
  after = sample[2][9..-2].split(', ').map(&:to_i)

  all_functions.each do |function|
    result = eval("function('#{function}', #{before}, #{command[1]}, #{command[2]}, #{command[3]})")
    sample_counter += 1 if result == after
  end

  counter += 1 if sample_counter >= 3
  i += 4
end

puts counter

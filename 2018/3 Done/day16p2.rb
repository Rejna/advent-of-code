# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 16 Part 2
# https://adventofcode.com/2018/day/16#part2
# Answer is: 584

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
all_functions = %w[addr addi mulr muli banr bani borr bori gtrr gtri gtir eqrr eqri eqir setr seti]
potential = {}
i = 0

loop do
  sample = input[i, 3]
  break if sample[0].empty?

  before = sample[0][9..-2].split(', ').map(&:to_i)
  command = sample[1].split(' ').map(&:to_i)
  after = sample[2][9..-2].split(', ').map(&:to_i)

  if potential.key?(command[0])
    potential_functions = potential[command[0]]
    potential[command[0]] = []

    potential_functions.each do |function|
      result = eval("function('#{function}', #{before}, #{command[1]}, #{command[2]}, #{command[3]})")
      potential[command[0]] << function if result == after
    end
  else
    all_functions.each do |function|
      result = eval("function('#{function}', #{before}, #{command[1]}, #{command[2]}, #{command[3]})")
      if result == after
        potential[command[0]] << function if potential.key?(command[0])
        potential[command[0]] = [function] unless potential.key?(command[0])
      end
    end
  end

  i += 4
end
i += 2

until potential.values.all? { |v| v.length == 1 }
  singles = potential.values.select { |v| v.length == 1 }.flatten
  singles.each do |single|
    potential.each_value do |val|
      val.delete(single) if val.length > 1
    end
  end
end

registers = [0, 0, 0, 0]

input[i..].each do |c|
  command = c.split(' ').map(&:to_i)
  registers = eval("function('#{potential[command[0]][0]}', registers, #{command[1]}, #{command[2]}, #{command[3]})")
end

puts registers[0]

# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 5 Part 1
# https://adventofcode.com/2019/day/5
# Answer is: 12440243

def get_value(address, mode)
  if mode.to_i.zero?
    @memory[@memory[address]]
  else
    @memory[address]
  end
end

# @memory = [1002, 4, 3, 4, 33]
@memory = File.readlines('../1 Input/day05.input')[0].strip.split(',').map(&:to_i)

pointer = 0

loop do
  command = @memory[pointer]
  op_code = command % 100

  case op_code
  when 1
    operand = '+'
    param_count = 4
  when 2
    operand = '*'
    param_count = 4
  when 3
    operand = '@memory['
    operand2 = '] = 1'
    param_count = 2
  when 4
    operand = 'puts '
    param_count = 2
  when 99
    break
  end

  param_modes = if [1, 2, 4].include?(op_code)
                  (command.to_s)[..-3].rjust(param_count - 1, '0').reverse
                else
                  ['1']
                end

  val1 = get_value(pointer + 1, param_modes[0])
  case op_code
  when 1, 2
    val2 = get_value(pointer + 2, param_modes[1])
    addr = get_value(pointer + 3, '1')
    @memory[addr] = eval("#{val1} #{operand} #{val2}")
  when 3, 4
    eval("#{operand}#{val1}#{operand2}")
  end
  pointer += param_count
end

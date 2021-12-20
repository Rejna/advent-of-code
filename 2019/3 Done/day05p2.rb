# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 5 Part 2
# https://adventofcode.com/2019/day/5#part2
# Answer is: 15486302

class FalseClass
  def to_i
    0
  end
end

class TrueClass
  def to_i
    1
  end
end

def get_value(address, mode)
  if mode.to_i.zero?
    @memory[@memory[address]]
  else
    @memory[address]
  end
end

# @memory = [3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31,
#            1106, 0, 36, 98, 0, 0, 1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104,
#            999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105, 1, 46, 98, 99]
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
    operand2 = '] = 5'
    param_count = 2
  when 4
    operand = 'puts '
    param_count = 2
  when 5
    operand = '!'
    param_count = 3
  when 6
    param_count = 3
  when 7
    operand = '<'
    param_count = 4
  when 8
    operand = '=='
    param_count = 4
  when 99
    break
  end

  param_modes = if op_code == 3
                  ['1']
                else
                  (command.to_s)[..-3].rjust(param_count - 1, '0').reverse
                end

  val1 = get_value(pointer + 1, param_modes[0])
  case op_code
  when 1, 2, 7, 8
    val2 = get_value(pointer + 2, param_modes[1])
    addr = get_value(pointer + 3, '1')
    @memory[addr] = eval("#{val1} #{operand} #{val2}").to_i
  when 3, 4
    eval("#{operand}#{val1}#{operand2}")
  when 5, 6
    if eval("#{operand}#{val1}.zero?")
      val2 = get_value(pointer + 2, param_modes[1])
      pointer = val2
      param_count = 0
    end
  end
  pointer += param_count
end

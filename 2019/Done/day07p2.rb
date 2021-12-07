# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 7 Part 2
# https://adventofcode.com/2019/day/7#part2
# Answer is: 4374895

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
    @memory[@amplifier][@memory[@amplifier][address]]
  else
    @memory[@amplifier][address]
  end
end

# base = [3, 26, 1001, 26, -4, 26, 3, 27, 1002, 27, 2, 27, 1, 27, 26, 27, 4, 27, 1001, 28, -1, 28, 1005, 28, 6, 99, 0,
#         0, 5]
# base = [3, 52, 1001, 52, -5, 52, 3, 53, 1, 52, 56, 54, 1007, 54, 5, 55, 1005, 55, 26, 1001, 54, -5, 54, 1105, 1, 12,
#         1, 53, 54, 53, 1008, 54, 0, 55, 1001, 55, 1, 55, 2, 53, 55, 53, 4, 53, 1001, 56, -1, 56, 1005, 56, 6, 99, 0,
#         0, 0, 0, 10]
base = [3, 8, 1001, 8, 10, 8, 105, 1, 0, 0, 21, 30, 55, 76, 97, 114, 195, 276, 357, 438, 99_999, 3, 9, 102, 3, 9, 9,
        4, 9, 99, 3, 9, 1002, 9, 3, 9, 1001, 9, 5, 9, 1002, 9, 2, 9, 1001, 9, 2, 9, 102, 2, 9, 9, 4, 9, 99, 3, 9,
        1002, 9, 5, 9, 1001, 9, 2, 9, 102, 5, 9, 9, 1001, 9, 4, 9, 4, 9, 99, 3, 9, 1001, 9, 4, 9, 102, 5, 9, 9, 101,
        4, 9, 9, 1002, 9, 4, 9, 4, 9, 99, 3, 9, 101, 2, 9, 9, 102, 4, 9, 9, 1001, 9, 5, 9, 4, 9, 99, 3, 9, 1002, 9,
        2, 9, 4, 9, 3, 9, 102, 2, 9, 9, 4, 9, 3, 9, 102, 2, 9, 9, 4, 9, 3, 9, 1001, 9, 1, 9, 4, 9, 3, 9, 102, 2, 9,
        9, 4, 9, 3, 9, 1002, 9, 2, 9, 4, 9, 3, 9, 102, 2, 9, 9, 4, 9, 3, 9, 102, 2, 9, 9, 4, 9, 3, 9, 1001, 9, 2, 9,
        4, 9, 3, 9, 101, 1, 9, 9, 4, 9, 99, 3, 9, 1002, 9, 2, 9, 4, 9, 3, 9, 1001, 9, 2, 9, 4, 9, 3, 9, 101, 1, 9, 9,
        4, 9, 3, 9, 1002, 9, 2, 9, 4, 9, 3, 9, 1001, 9, 2, 9, 4, 9, 3, 9, 1001, 9, 2, 9, 4, 9, 3, 9, 1002, 9, 2, 9,
        4, 9, 3, 9, 1001, 9, 2, 9, 4, 9, 3, 9, 101, 2, 9, 9, 4, 9, 3, 9, 102, 2, 9, 9, 4, 9, 99, 3, 9, 101, 1, 9, 9,
        4, 9, 3, 9, 1002, 9, 2, 9, 4, 9, 3, 9, 1001, 9, 1, 9, 4, 9, 3, 9, 1002, 9, 2, 9, 4, 9, 3, 9, 1001, 9, 1, 9,
        4, 9, 3, 9, 1001, 9, 1, 9, 4, 9, 3, 9, 101, 1, 9, 9, 4, 9, 3, 9, 102, 2, 9, 9, 4, 9, 3, 9, 1001, 9, 1, 9, 4,
        9, 3, 9, 1001, 9, 1, 9, 4, 9, 99, 3, 9, 1001, 9, 1, 9, 4, 9, 3, 9, 1002, 9, 2, 9, 4, 9, 3, 9, 1001, 9, 2, 9,
        4, 9, 3, 9, 1002, 9, 2, 9, 4, 9, 3, 9, 1001, 9, 1, 9, 4, 9, 3, 9, 101, 2, 9, 9, 4, 9, 3, 9, 102, 2, 9, 9, 4,
        9, 3, 9, 101, 2, 9, 9, 4, 9, 3, 9, 101, 1, 9, 9, 4, 9, 3, 9, 1001, 9, 1, 9, 4, 9, 99, 3, 9, 101, 2, 9, 9, 4,
        9, 3, 9, 102, 2, 9, 9, 4, 9, 3, 9, 101, 2, 9, 9, 4, 9, 3, 9, 101, 1, 9, 9, 4, 9, 3, 9, 101, 2, 9, 9, 4, 9, 3,
        9, 1002, 9, 2, 9, 4, 9, 3, 9, 102, 2, 9, 9, 4, 9, 3, 9, 1001, 9, 1, 9, 4, 9, 3, 9, 1001, 9, 1, 9, 4, 9, 3, 9,
        101, 2, 9, 9, 4, 9, 99]

phase_settings = [5, 6, 7, 8, 9].permutation.to_a
max_signal = 0
max_permutation = []

phase_settings.each do |phase_setting|
  @amplifier = 0
  input = 0
  output = 0
  first_input = [true, true, true, true, true]
  halted = [false, false, false, false, false]
  pointer = [0, 0, 0, 0, 0]
  @memory = []
  @memory << [*base]
  @memory << [*base]
  @memory << [*base]
  @memory << [*base]
  @memory << [*base]

  loop do
    command = @memory[@amplifier][pointer[@amplifier]]
    op_code = command % 100

    case op_code
    when 1
      operand = '+'
      param_count = 4
    when 2
      operand = '*'
      param_count = 4
    when 3
      operand = '@memory[@amplifier]['
      if first_input[@amplifier]
        operand2 = '] = phase_setting[@amplifier]'
        first_input[@amplifier] = false
      else
        operand2 = '] = input'
      end
      param_count = 2
    when 4
      operand = 'output = '
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
      halted[@amplifier] = true
    end

    unless halted[@amplifier]
      param_modes = if op_code == 3
                      ['1']
                    else
                      (command.to_s)[..-3].rjust(param_count - 1, '0').reverse
                    end

      val1 = get_value(pointer[@amplifier] + 1, param_modes[0])
      case op_code
      when 1, 2, 7, 8
        val2 = get_value(pointer[@amplifier] + 2, param_modes[1])
        addr = get_value(pointer[@amplifier] + 3, '1')
        @memory[@amplifier][addr] = eval("#{val1} #{operand} #{val2}").to_i
      when 3
        eval("#{operand}#{val1}#{operand2}")
      when 4
        eval("#{operand}#{val1}#{operand2}")
        input = output
      when 5, 6
        if eval("#{operand}#{val1}.zero?")
          val2 = get_value(pointer[@amplifier] + 2, param_modes[1])
          pointer[@amplifier] = val2
          param_count = 0
        end
      end
      pointer[@amplifier] += param_count
    end
    @amplifier = (@amplifier + 1) % 5 if [4, 99].include?(op_code)

    break if halted.all? { |a| a }
  end

  if output > max_signal
    max_signal = output
    max_permutation = phase_setting
  end
end

puts "#{max_signal} from permutation #{max_permutation.join(',')}"

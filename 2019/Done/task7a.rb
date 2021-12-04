# frozen_string_literal: true

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

# base = [3, 15, 3, 16, 1002, 16, 10, 16, 1, 16, 15, 15, 4, 15, 99, 0, 0]
# base = [3, 23, 3, 24, 1002, 24, 10, 24, 1002, 23, -1, 23, 101, 5, 23, 23, 1, 24, 23, 23, 4, 23, 99, 0, 0]
# base = [3, 31, 3, 32, 1002, 32, 10, 32, 1001, 31, -2, 31, 1007, 31, 0, 33, 1002, 33, 7, 33, 1, 33, 31, 31, 1, 32, 31,
#         31, 4, 31, 99, 0, 0, 0]
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

phase_settings = [0, 1, 2, 3, 4].permutation.to_a
max_signal = 0
max_permutation = []

phase_settings.each do |phase_setting|
  amplifier = 0
  input = 0
  output = 0

  while amplifier < 5
    pointer = 0
    first_input = true
    @memory = [*base]

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
        if first_input
          operand2 = '] = phase_setting[amplifier]'
          first_input = false
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
      when 3
        eval("#{operand}#{val1}#{operand2}")
      when 4
        eval("#{operand}#{val1}#{operand2}")
        input = output
        amplifier += 1
      when 5, 6
        if eval("#{operand}#{val1}.zero?")
          val2 = get_value(pointer + 2, param_modes[1])
          pointer = val2
          param_count = 0
        end
      end
      pointer += param_count
    end
  end

  if output > max_signal
    max_signal = output
    max_permutation = phase_setting
  end
end

puts "#{max_signal} from permutation #{max_permutation.join(',')}"

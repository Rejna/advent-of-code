# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 19 Part 2
# https://adventofcode.com/2019/day/19#part2
# Answer is: ???

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
  case mode.to_i
  when 0
    # puts "mode 0, #{@memory[address]}"
    @memory[@memory[address]] || 0
  when 1
    # puts "mode 1, #{address}"
    @memory[address] || 0
  when 2
    # puts "mode 2, #{address} #{@relative_base} #{@memory[address + @relative_base]}"
    @memory[@memory[address] + @relative_base] || 0
  when 9
    # puts "#{address} #{@relative_base}"
    @memory[address] + @relative_base
  end
end

def print_area
  @area.each do |row|
    row.each do |c|
      putc '#' if c == 1
      putc '.' if c.zero?
    end
    puts
  end
  puts '--------------------------------'
end

def move
  if @cur_x == @max_x - 1
    @cur_y += 1
    @cur_x = 0
  else
    @cur_x += 1
  end
end

input = [109, 424, 203, 1, 21_101, 0, 11, 0, 1106, 0, 282, 21_102, 1, 18, 0, 1106, 0, 259, 2101, 0, 1, 221, 203, 1,
         21_101, 0, 31, 0, 1106, 0, 282, 21_101, 0, 38, 0, 1106, 0, 259, 21_001, 23, 0, 2, 21_202, 1, 1, 3, 21_102, 1,
         1, 1, 21_102, 1, 57, 0, 1106, 0, 303, 2102, 1, 1, 222, 20_102, 1, 221, 3, 21_001, 221, 0, 2, 21_102, 1, 259,
         1, 21_102, 80, 1, 0, 1106, 0, 225, 21_102, 106, 1, 2, 21_102, 91, 1, 0, 1105, 1, 303, 1201, 1, 0, 223, 21_001,
         222, 0, 4, 21_101, 259, 0, 3, 21_102, 1, 225, 2, 21_101, 225, 0, 1, 21_101, 0, 118, 0, 1106, 0, 225, 20_101, 0,
         222, 3, 21_102, 42, 1, 2, 21_101, 133, 0, 0, 1105, 1, 303, 21_202, 1, -1, 1, 22_001, 223, 1, 1, 21_101, 0, 148,
         0, 1106, 0, 259, 1201, 1, 0, 223, 21_001, 221, 0, 4, 20_101, 0, 222, 3, 21_101, 10, 0, 2, 1001, 132, -2, 224,
         1002, 224, 2, 224, 1001, 224, 3, 224, 1002, 132, -1, 132, 1, 224, 132, 224, 21_001, 224, 1, 1, 21_101, 195, 0,
         0, 106, 0, 108, 20_207, 1, 223, 2, 20_102, 1, 23, 1, 21_101, -1, 0, 3, 21_101, 214, 0, 0, 1105, 1, 303, 22_101,
         1, 1, 1, 204, 1, 99, 0, 0, 0, 0, 109, 5, 1202, -4, 1, 249, 22_102, 1, -3, 1, 22_101, 0, -2, 2, 21_202, -1, 1,
         3, 21_101, 250, 0, 0, 1105, 1, 225, 21_202, 1, 1, -4, 109, -5, 2106, 0, 0, 109, 3, 22_107, 0, -2, -1, 21_202,
         -1, 2, -1, 21_201, -1, -1, -1, 22_202, -1, -2, -2, 109, -3, 2105, 1, 0, 109, 3, 21_207, -2, 0, -1, 1206, -1,
         294, 104, 0, 99, 22_102, 1, -2, -2, 109, -3, 2106, 0, 0, 109, 5, 22_207, -3, -4, -1, 1206, -1, 346, 22_201,
         -4, -3, -4, 21_202, -3, -1, -1, 22_201, -4, -1, 2, 21_202, 2, -1, -1, 22_201, -4, -1, 1, 21_202, -2, 1, 3,
         21_101, 343, 0, 0, 1106, 0, 303, 1105, 1, 415, 22_207, -2, -3, -1, 1206, -1, 387, 22_201, -3, -2, -3, 21_202,
         -2, -1, -1, 22_201, -3, -1, 3, 21_202, 3, -1, -1, 22_201, -3, -1, 2, 22_101, 0, -4, 1, 21_102, 384, 1, 0, 1106,
         0, 303, 1105, 1, 415, 21_202, -4, -1, -4, 22_201, -4, -3, -4, 22_202, -3, -2, -2, 22_202, -2, -4, -4, 22_202,
         -3, -2, -3, 21_202, -4, -1, -2, 22_201, -3, -2, 1, 22_102, 1, 1, -4, 109, -5, 2105, 1, 0]

@cur_x = 0
@cur_y = 0
@max_x = 50
@max_y = 50
@area = []
@max_y.times do
  @area << Array.new(@max_x, 0)
end

while @cur_x < @max_x && @cur_y < @max_y
  @first_input = true
  pointer = 0
  @relative_base = 0
  @memory = [*input]

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
      operand2 = @first_input ? '] = @cur_x' : '] = @cur_y'
      @first_input = !@first_input
      param_count = 2
    when 4
      operand = '@area[@cur_y][@cur_x] = '
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
    when 9
      operand = '@relative_base += '
      param_count = 2
    when 99
      break
    end

    pm = (command.to_s)[..-3].rjust(param_count - 1, '0').reverse

    param_modes = if op_code == 3
                    case pm
                    when '0', '1'
                      '1'
                    when '2'
                      '9'
                    end
                  elsif [1, 2, 7, 8].include?(op_code)
                    case pm[2]
                    when '0', '1'
                      "#{pm[0, 2]}1"
                    when '2'
                      "#{pm[0, 2]}9"
                    end
                  else
                    pm
                  end

    val1 = get_value(pointer + 1, param_modes[0])
    case op_code
    when 1, 2, 7, 8
      val2 = get_value(pointer + 2, param_modes[1])
      addr = get_value(pointer + 3, param_modes[2])
      # puts "OP_CODE: #{op_code}\tCOMMAND: #{command}\tPOINTER: #{pointer}\t@memory[#{addr}] = #{val1} #{operand} #{val2}" # = #{eval("#{val1} #{operand} #{val2}").to_i}"
      @memory[addr] = eval("#{val1} #{operand} #{val2}").to_i
    when 3, 9
      # puts "OP_CODE: #{op_code}\tCOMMAND: #{command}\tPOINTER: #{pointer}\t#{operand}#{val1}#{operand2}"
      eval("#{operand}#{val1}#{operand2}")
    when 4
      # puts "OP_CODE: #{op_code}\tCOMMAND: #{command}\tPOINTER: #{pointer}\t#{operand}#{val1}#{operand2}"
      eval("#{operand}#{val1}#{operand2}")

      # puts "#{@cur_x} #{@cur_y}"
      # print_area if @area[@cur_y][@cur_x] == 1
      move
      break
    when 5, 6
      val2 = get_value(pointer + 2, param_modes[1])
      # puts "OP_CODE: #{op_code}\tCOMMAND: #{command}\tPOINTER: #{pointer}\t#{operand}#{val1}.zero? -> #{val2}"
      if eval("#{operand}#{val1}.zero?")
        pointer = val2
        param_count = 0
      end
    end
    pointer += param_count
  end
end

print_area

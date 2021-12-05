# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 11 Part 1
# https://adventofcode.com/2019/day/11
# Answer is: 1967

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
    @memory[address]
  when 2
    # puts "mode 2, #{address} #{@relative_base} #{@memory[address + @relative_base]}"
    @memory[@memory[address] + @relative_base]
  when 9
    # puts "#{address} #{@relative_base}"
    @memory[address] + @relative_base
  end
end

def action
  @space[@cur_y][@cur_x] = @paint_color
  @visited_fields << [@cur_x, @cur_y] unless @visited_fields.include?([@cur_x, @cur_y])
  if @turn_direction.zero? # 90 left
    case @cur_direction
    when 'up'
      @ship = '<'
      @cur_direction = 'left'
    when 'left'
      @ship = 'v'
      @cur_direction = 'down'
    when 'down'
      @ship = '>'
      @cur_direction = 'right'
    else
      @ship = '^'
      @cur_direction = 'up'
    end
  else # 90 right
    case @cur_direction
    when 'up'
      @ship = '>'
      @cur_direction = 'right'
    when 'left'
      @ship = '^'
      @cur_direction = 'up'
    when 'down'
      @ship = '<'
      @cur_direction = 'left'
    else
      @ship = 'v'
      @cur_direction = 'down'
    end
  end
  move
end

def move
  case @cur_direction
  when 'up'
    @cur_y -= 1
  when 'down'
    @cur_y += 1
  when 'left'
    @cur_x -= 1
  else
    @cur_x += 1
  end
end

def print_space
  i = 0
  while i < @space.length
    j = 0
    while j < @space[i].length
      if i == @cur_y && j == @cur_x
        putc @ship
      else
        putc @space[i][j].zero? ? ' ' : '#'
      end
      j += 1
    end
    puts
    i += 1
  end
end

@memory = [3, 8, 1005, 8, 327, 1106, 0, 11, 0, 0, 0, 104, 1, 104, 0, 3, 8, 102, -1, 8, 10, 1001, 10, 1, 10, 4, 10, 108,
           0, 8, 10, 4, 10, 1001, 8, 0, 28, 1006, 0, 42, 2, 1104, 11, 10, 1006, 0, 61, 2, 1005, 19, 10, 3, 8, 1002, 8,
           -1, 10, 1001, 10, 1, 10, 4, 10, 1008, 8, 1, 10, 4, 10, 102, 1, 8, 65, 1006, 0, 4, 3, 8, 1002, 8, -1, 10,
           1001, 10, 1, 10, 4, 10, 108, 1, 8, 10, 4, 10, 1002, 8, 1, 89, 1, 1108, 10, 10, 1, 1103, 11, 10, 1, 109, 18,
           10, 1006, 0, 82, 3, 8, 102, -1, 8, 10, 1001, 10, 1, 10, 4, 10, 108, 0, 8, 10, 4, 10, 102, 1, 8, 126, 2, 109,
           7, 10, 1, 104, 3, 10, 1006, 0, 64, 2, 1109, 20, 10, 3, 8, 1002, 8, -1, 10, 101, 1, 10, 10, 4, 10, 108, 1,
           8, 10, 4, 10, 101, 0, 8, 163, 3, 8, 102, -1, 8, 10, 1001, 10, 1, 10, 4, 10, 108, 1, 8, 10, 4, 10, 1002, 8, 1,
           185, 2, 1109, 12, 10, 2, 103, 16, 10, 1, 107, 11, 10, 3, 8, 102, -1, 8, 10, 1001, 10, 1, 10, 4, 10, 108, 0,
           8, 10, 4, 10, 1001, 8, 0, 219, 1, 1005, 19, 10, 3, 8, 102, -1, 8, 10, 1001, 10, 1, 10, 4, 10, 108, 1, 8, 10,
           4, 10, 102, 1, 8, 245, 2, 1002, 8, 10, 1, 2, 9, 10, 1006, 0, 27, 1006, 0, 37, 3, 8, 1002, 8, -1, 10, 1001,
           10, 1, 10, 4, 10, 108, 0, 8, 10, 4, 10, 102, 1, 8, 281, 1006, 0, 21, 3, 8, 102, -1, 8, 10, 101, 1, 10, 10, 4,
           10, 108, 0, 8, 10, 4, 10, 1001, 8, 0, 306, 101, 1, 9, 9, 1007, 9, 1075, 10, 1005, 10, 15, 99, 109, 649, 104,
           0, 104, 1, 21_102, 1, 847_069_852_568, 1, 21_101, 344, 0, 0, 1105, 1, 448, 21_101, 0, 386_979_963_688, 1,
           21_101, 355, 0, 0, 1105, 1, 448, 3, 10, 104, 0, 104, 1, 3, 10, 104, 0, 104, 0, 3, 10, 104, 0, 104, 1, 3, 10,
           104, 0, 104, 1, 3, 10, 104, 0, 104, 0, 3, 10, 104, 0, 104, 1, 21_102, 46_346_031_251, 1, 1, 21_101, 0, 402,
           0, 1105, 1, 448, 21_102, 1, 29_195_594_775, 1, 21_101, 0, 413, 0, 1105, 1, 448, 3, 10, 104, 0, 104, 0, 3, 10,
           104, 0, 104, 0, 21_101, 0, 868_498_428_772, 1, 21_101, 0, 436, 0, 1106, 0, 448, 21_102, 718_170_641_172, 1,
           1, 21_102, 1, 447, 0, 1105, 1, 448, 99, 109, 2, 21_202, -1, 1, 1, 21_102, 40, 1, 2, 21_102, 1, 479, 3,
           21_102, 1, 469, 0, 1105, 1, 512, 109, -2, 2105, 1, 0, 0, 1, 0, 0, 1, 109, 2, 3, 10, 204, -1, 1001, 474, 475,
           490, 4, 0, 1001, 474, 1, 474, 108, 4, 474, 10, 1006, 10, 506, 1101, 0, 0, 474, 109, -2, 2106, 0, 0, 0, 109,
           4, 2102, 1, -1, 511, 1207, -3, 0, 10, 1006, 10, 529, 21_101, 0, 0, -3, 22_101, 0, -3, 1, 22_101, 0, -2, 2,
           21_101, 0, 1, 3, 21_101, 548, 0, 0, 1106, 0, 553, 109, -4, 2106, 0, 0, 109, 5, 1207, -3, 1, 10, 1006, 10,
           576, 2207, -4, -2, 10, 1006, 10, 576, 21_202, -4, 1, -4, 1106, 0, 644, 22_101, 0, -4, 1, 21_201, -3, -1, 2,
           21_202, -2, 2, 3,  21_102, 1, 595, 0, 1105, 1, 553, 21_201, 1, 0, -4, 21_101, 0, 1, -1, 2207, -4, -2, 10,
           1006, 10, 614, 21_102, 1, 0, -1, 22_202, -2, -1, -2, 2107, 0, -3, 10, 1006, 10, 636, 22_102, 1, -1, 1,
           21_102, 1, 636, 0, 106, 0, 511, 21_202, -2, -1, -2, 22_201, -4, -2, -4, 109, -5, 2105, 1, 0]
pointer = 0
@relative_base = 0
first_output = true
@visited_fields = []
@paint_color = 1
@turn_direction = 0
@ship = '^'

@cur_x = 10
@cur_y = 40
@cur_direction = 'up'

@space = []
70.times do
  @space << Array.new(70, 0)
end

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
    operand2 = "] = #{@space[@cur_y][@cur_x]}"
    param_count = 2
  when 4
    # operand = 'output = '
    if first_output
      operand = '@paint_color = '
      first_output = false
    else
      operand = '@turn_direction = '
      first_output = true
    end
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
    # puts "OP_CODE: #{op_code}\tCOMMAND: #{command}\tPOINTER: #{pointer}\t@memory[#{addr}] = #{val1} #{operand} #{val2}" = #{eval("#{val1} #{operand} #{val2}").to_i}"
    @memory[addr] = eval("#{val1} #{operand} #{val2}").to_i
  when 3, 9
    # puts "OP_CODE: #{op_code}\tCOMMAND: #{command}\tPOINTER: #{pointer}\t#{operand}#{val1}#{operand2}"
    eval("#{operand}#{val1}#{operand2}")
  when 4
    # puts "OP_CODE: #{op_code}\tCOMMAND: #{command}\tPOINTER: #{pointer}\t#{operand}#{val1}#{operand2}"
    eval("#{operand}#{val1}#{operand2}")

    action if first_output
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

print_space
puts @visited_fields.length

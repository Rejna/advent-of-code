# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 15 Part 1
# https://adventofcode.com/2019/day/15
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
    @memory[address]
  when 2
    # puts "mode 2, #{address} #{@relative_base} #{@memory[address + @relative_base]}"
    @memory[@memory[address] + @relative_base]
  when 9
    # puts "#{address} #{@relative_base}"
    @memory[address] + @relative_base
  end
end

def move
  case @next_move
  when 1 # N
    @cur_y -= 1
  when 2 # S
    @cur_y += 1
  when 3 # W
    @cur_x -= 1
  else # E
    @cur_x += 1
  end
end

def move_to_dir
  case @next_move
  when 1
    'up'
  when 2
    'down'
  when 3
    'left'
  else
    'right'
  end
end

def status_to_str
  case @status
  when 0
    'bump, no move'
  when 1
    "move #{move_to_dir}"
  else
    "move #{move_to_dir} and win"
  end
end

def calculate_move
  if @next_move.zero? # first move - go north
    @next_move = 1
  elsif @status.zero? # bump, move to first unexplored field
    potential_moves = surroundings.select { |a| a[1] == ' ' }
    puts "|#{potential_moves} #{potential_moves.empty?} #{potential_moves.any?} #{potential_moves.nil?}|"
    if potential_moves.empty?
      puts 'DEAD END'
      potential_moves = surroundings.select { |a| a[1] == '.' } # go back
    end
    @next_move = potential_moves.first[0]
  end
end

def surroundings
  [[1, @map[@cur_y - 1][@cur_x]], [2, @map[@cur_y + 1][@cur_x]],
   [3, @map[@cur_y][@cur_x - 1]], [4, @map[@cur_y][@cur_x + 1]]]
end

def evaluate_status
  case @status
  when 0
    case @next_move
    when 1
      @map[@cur_y - 1][@cur_x] = '#'
    when 2
      @map[@cur_y + 1][@cur_x] = '#'
    when 3
      @map[@cur_y][@cur_x - 1] = '#'
    else
      @map[@cur_y][@cur_x + 1] = '#'
    end
  when 1
    @map[@cur_y][@cur_x] = '.'
    move
  else
    @map[@cur_y][@cur_x] = '.'
    move
    @end = true
  end
end

def print_map
  puts '-------------------------------'
  i = 0
  while i < @map.length
    j = 0
    while j < @map[i].length
      if i == @cur_y && j == @cur_x
        putc 'D'
      else
        putc @map[i][j]
      end
      j += 1
    end
    putc 'X'
    puts
    i += 1
  end
  puts "Last move: #{move_to_dir} Status: #{status_to_str}"
end

@memory = [3, 1033, 1008, 1033, 1, 1032, 1005, 1032, 31, 1008, 1033, 2, 1032, 1005, 1032, 58, 1008, 1033, 3, 1032, 1005,
           1032, 81, 1008, 1033, 4, 1032, 1005, 1032, 104, 99, 101, 0, 1034, 1039, 1002, 1036, 1, 1041, 1001, 1035, -1,
           1040, 1008, 1038, 0, 1043, 102, -1, 1043, 1032, 1, 1037, 1032, 1042, 1105, 1, 124, 1002, 1034, 1, 1039, 101,
           0, 1036, 1041, 1001, 1035, 1, 1040, 1008, 1038, 0, 1043, 1, 1037, 1038, 1042, 1106, 0, 124, 1001, 1034, -1,
           1039, 1008, 1036, 0, 1041, 101, 0, 1035, 1040, 102, 1, 1038, 1043, 1001, 1037, 0, 1042, 1105, 1, 124, 1001,
           1034, 1, 1039, 1008, 1036, 0, 1041, 1002, 1035, 1, 1040, 1001, 1038, 0, 1043, 102, 1, 1037, 1042, 1006, 1039,
           217, 1006, 1040, 217, 1008, 1039, 40, 1032, 1005, 1032, 217, 1008, 1040, 40, 1032, 1005, 1032, 217, 1008,
           1039, 5, 1032, 1006, 1032, 165, 1008, 1040, 7, 1032, 1006, 1032, 165, 1101, 2, 0, 1044, 1106, 0, 224, 2,
           1041, 1043, 1032, 1006, 1032, 179, 1102, 1, 1, 1044, 1105, 1, 224, 1, 1041, 1043, 1032, 1006, 1032, 217, 1,
           1042, 1043, 1032, 1001, 1032, -1, 1032, 1002, 1032, 39, 1032, 1, 1032, 1039, 1032, 101, -1, 1032, 1032, 101,
           252, 1032, 211, 1007, 0, 31, 1044, 1106, 0, 224, 1101, 0, 0, 1044, 1106, 0, 224, 1006, 1044, 247, 1002, 1039,
           1, 1034, 101, 0, 1040, 1035, 1001, 1041, 0, 1036, 102, 1, 1043, 1038, 1002, 1042, 1, 1037, 4, 1044, 1105, 1,
           0, 9, 21, 83, 15, 75, 17, 11, 9, 80, 22, 37, 23, 19, 89, 6, 29, 79, 24, 75, 3, 39, 3, 98, 13, 20, 53, 24, 30,
           59, 26, 13, 19, 63, 84, 10, 2, 57, 7, 22, 43, 28, 72, 11, 25, 67, 17, 90, 6, 10, 24, 93, 76, 36, 21, 34, 18,
           19, 15, 72, 53, 18, 19, 82, 8, 57, 40, 18, 2, 48, 71, 19, 46, 26, 32, 69, 29, 27, 42, 8, 58, 25, 17, 44, 39,
           47, 24, 54, 32, 48, 6, 26, 43, 91, 4, 16, 47, 45, 19, 73, 3, 52, 43, 25, 5, 22, 73, 58, 12, 56, 23, 44, 7,
           46, 96, 48, 25, 8, 16, 56, 20, 48, 72, 28, 44, 26, 14, 23, 28, 61, 29, 15, 69, 86, 28, 97, 6, 4, 77, 4, 1,
           37, 55, 70, 69, 22, 19, 23, 78, 21, 41, 2, 1, 48, 29, 20, 30, 22, 91, 36, 15, 46, 16, 83, 5, 95, 38, 9, 42,
           84, 25, 45, 3, 81, 38, 79, 8, 1, 78, 42, 25, 58, 15, 29, 48, 52, 19, 36, 4, 27, 43, 24, 62, 6, 56, 60, 22,
           22, 48, 23, 70, 8, 83, 17, 13, 63, 85, 25, 13, 14, 85, 79, 18, 13, 63, 3, 48, 94, 22, 73, 18, 26, 40, 68, 12,
           25, 10, 56, 90, 59, 19, 68, 25, 27, 20, 20, 65, 1, 22, 55, 20, 1, 20, 88, 24, 69, 65, 13, 49, 8, 5, 78, 77,
           1, 3, 93, 9, 13, 34, 17, 75, 28, 13, 92, 66, 35, 7, 98, 3, 63, 78, 59, 87, 2, 80, 83, 56, 15, 28, 96, 25, 32,
           3, 27, 47, 5, 73, 56, 9, 59, 19, 16, 60, 2, 21, 50, 92, 44, 19, 73, 64, 7, 21, 39, 19, 20, 20, 63, 5, 12, 6,
           14, 34, 12, 8, 48, 12, 68, 33, 14, 99, 9, 85, 20, 76, 18, 29, 99, 52, 11, 5, 98, 65, 83, 15, 30, 97, 35, 21,
           96, 4, 53, 44, 23, 39, 25, 53, 60, 78, 85, 11, 7, 4, 39, 23, 84, 22, 29, 56, 37, 88, 18, 19, 84, 4, 65, 86,
           8, 27, 66, 24, 26, 19, 95, 13, 19, 61, 19, 42, 85, 14, 19, 29, 90, 22, 15, 78, 18, 90, 8, 24, 21, 97, 86, 15,
           40, 21, 61, 21, 49, 61, 6, 88, 40, 9, 2, 38, 13, 85, 16, 50, 55, 93, 83, 16, 77, 25, 27, 91, 8, 95, 15, 60,
           70, 63, 13, 24, 24, 96, 30, 8, 22, 27, 74, 17, 14, 92, 18, 49, 4, 38, 9, 33, 88, 12, 62, 28, 35, 77, 29, 59,
           3, 18, 45, 5, 10, 42, 58, 23, 78, 72, 15, 79, 2, 48, 47, 14, 65, 24, 5, 83, 41, 11, 89, 4, 57, 36, 19, 12, 2,
           40, 21, 16, 44, 36, 13, 69, 70, 1, 11, 51, 16, 68, 30, 24, 83, 26, 40, 14, 82, 48, 10, 5, 83, 1, 76, 90, 15,
           44, 24, 10, 88, 30, 24, 78, 1, 54, 97, 83, 27, 46, 87, 5, 19, 86, 19, 48, 19, 9, 50, 20, 69, 17, 10, 80, 34,
           23, 24, 18, 75, 19, 20, 21, 73, 11, 32, 5, 15, 35, 2, 77, 22, 53, 18, 22, 86, 6, 9, 37, 30, 64, 28, 77, 17,
           28, 12, 41, 62, 59, 2, 92, 97, 77, 14, 3, 76, 85, 11, 47, 14, 85, 6, 53, 2, 18, 52, 29, 23, 54, 35, 75, 5,
           97, 40, 6, 45, 4, 75, 64, 5, 13, 86, 7, 84, 84, 1, 38, 23, 81, 72, 5, 26, 97, 70, 14, 40, 9, 41, 63, 41, 26,
           80, 57, 14, 69, 90, 2, 28, 95, 24, 21, 80, 18, 26, 33, 39, 29, 11, 70, 73, 69, 17, 79, 13, 7, 73, 6, 21, 11,
           75, 35, 10, 23, 30, 78, 75, 1, 1, 73, 4, 62, 30, 11, 21, 6, 38, 8, 40, 9, 56, 3, 24, 92, 66, 3, 86, 61, 28,
           40, 17, 81, 74, 58, 92, 19, 4, 48, 34, 39, 30, 14, 36, 35, 73, 12, 15, 60, 49, 77, 13, 53, 77, 12, 20, 78,
           18, 34, 17, 36, 17, 53, 64, 7, 63, 26, 20, 19, 94, 16, 26, 84, 13, 18, 60, 47, 17, 11, 56, 2, 48, 53, 11, 8,
           79, 94, 22, 14, 8, 95, 7, 12, 21, 77, 16, 44, 4, 89, 70, 96, 11, 81, 8, 72, 5, 35, 79, 45, 1, 47, 10, 86, 75,
           82, 5, 47, 5, 65, 4, 50, 22, 34, 12, 84, 13, 62, 80, 63, 23, 45, 39, 36, 0, 0, 21, 21, 1, 10, 1, 0, 0, 0, 0,
           0, 0]
pointer = 0
@relative_base = 0

@cur_x = 50
@cur_y = 50
@next_move = 0
@end = false
@status = 0

@map = []
100.times do
  @map << Array.new(100, ' ')
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
    calculate_move
    operand = '@memory['
    operand2 = "] = #{@next_move}"
    param_count = 2
  when 4
    operand = '@status = '
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

    evaluate_status
    print_map
    # gets
  when 5, 6
    val2 = get_value(pointer + 2, param_modes[1])
    # puts "OP_CODE: #{op_code}\tCOMMAND: #{command}\tPOINTER: #{pointer}\t#{operand}#{val1}.zero? -> #{val2}"
    if eval("#{operand}#{val1}.zero?")
      pointer = val2
      param_count = 0
    end
  end
  pointer += param_count
  break if @end
end

# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 17 Part 2
# https://adventofcode.com/2019/day/17
# Answer is: 799463

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
    (@memory[@memory[address] + @relative_base]) || 0
  when 9
    # puts "#{address} #{@relative_base}"
    (@memory[address] || 0) + @relative_base
  end
end

def print_area
  @new_area.each do |row|
    puts row.join(' ')
  end
end

def procedure_value
  procedure = case @procedure_id
              when 'M'
                @main_procedure
              when 'A'
                @procedure_a
              when 'B'
                @procedure_b
              when 'C'
                @procedure_c
              else
                @procedure_x
              end

  if @procedure_idx == procedure.length
    # puts "Procedure #{@procedure_id} finished"
    @procedure_id = case @procedure_id
                    when 'M'
                      'A'
                    when 'A'
                      'B'
                    when 'B'
                      'C'
                    when 'C'
                      'X'
                    end
    @procedure_idx = 0
    return 10
  end

  r = procedure[@procedure_idx].ord
  # puts "Procedure #{@procedure_id} Index #{@procedure_idx} Value #{r.chr}"
  @procedure_idx += 1
  r
end

@memory = [2, 330, 331, 332, 109, 3376, 1101, 1182, 0, 16, 1102, 1, 1449, 24, 101, 0, 0, 570, 1006, 570, 36, 1001, 571,
           0, 0, 1001, 570, -1, 570, 1001, 24, 1, 24, 1105, 1, 18, 1008, 571, 0, 571, 1001, 16, 1, 16, 1008, 16, 1449,
           570, 1006, 570, 14, 21_102, 1, 58, 0, 1106, 0, 786, 1006, 332, 62, 99, 21_101, 0, 333, 1, 21_101, 0, 73, 0,
           1105, 1, 579, 1101, 0, 0, 572, 1101, 0, 0, 573, 3, 574, 101, 1, 573, 573, 1007, 574, 65, 570, 1005, 570,
           151, 107, 67, 574, 570, 1005, 570, 151, 1001, 574, -64, 574, 1002, 574, -1, 574, 1001, 572, 1, 572, 1007,
           572, 11, 570, 1006, 570, 165, 101, 1182, 572, 127, 1002, 574, 1, 0, 3, 574, 101, 1, 573, 573, 1008, 574,
           10, 570, 1005, 570, 189, 1008, 574, 44, 570, 1006, 570, 158, 1105, 1, 81, 21_102, 1, 340, 1, 1105, 1, 177,
           21_102, 477, 1, 1, 1105, 1, 177, 21_102, 1, 514, 1, 21_101, 176, 0, 0, 1105, 1, 579, 99, 21_102, 184, 1, 0,
           1105, 1, 579, 4, 574, 104, 10, 99, 1007, 573, 22, 570, 1006, 570, 165, 102, 1, 572, 1182, 21_102, 1, 375,
           1, 21_102, 211, 1, 0, 1105, 1, 579, 21_101, 1182, 11, 1, 21_102, 222, 1, 0, 1105, 1, 979, 21_101, 388, 0, 1,
           21_102, 233, 1, 0, 1106, 0, 579, 21_101, 1182, 22, 1, 21_102, 1, 244, 0, 1105, 1, 979, 21_101, 401, 0, 1,
           21_101, 0, 255, 0, 1105, 1, 579, 21_101, 1182, 33, 1, 21_102, 1, 266, 0, 1106, 0, 979, 21_102, 414, 1, 1,
           21_102, 1, 277, 0, 1105, 1, 579, 3, 575, 1008, 575, 89, 570, 1008, 575, 121, 575, 1, 575, 570, 575, 3, 574,
           1008, 574, 10, 570, 1006, 570, 291, 104, 10, 21_102, 1, 1182, 1, 21_101, 0, 313, 0, 1106, 0, 622, 1005, 575,
           327, 1101, 0, 1, 575, 21_101, 0, 327, 0, 1106, 0, 786, 4, 438, 99, 0, 1, 1, 6, 77, 97, 105, 110, 58, 10, 33,
           10, 69, 120, 112, 101, 99, 116, 101, 100, 32, 102, 117, 110, 99, 116, 105, 111, 110, 32, 110, 97, 109, 101,
           32, 98, 117, 116, 32, 103, 111, 116, 58, 32, 0, 12, 70, 117, 110, 99, 116, 105, 111, 110, 32, 65, 58, 10, 12,
           70, 117, 110, 99, 116, 105, 111, 110, 32, 66, 58, 10, 12, 70, 117, 110, 99, 116, 105, 111, 110, 32, 67,
           58, 10, 23, 67, 111, 110, 116, 105, 110, 117, 111, 117, 115, 32, 118, 105, 100, 101, 111, 32, 102, 101,
           101, 100, 63, 10, 0, 37, 10, 69, 120, 112, 101, 99, 116, 101, 100, 32, 82, 44, 32, 76, 44, 32, 111, 114,
           32, 100, 105, 115, 116, 97, 110, 99, 101, 32, 98, 117, 116, 32, 103, 111, 116, 58, 32, 36, 10, 69, 120,
           112, 101, 99, 116, 101, 100, 32, 99, 111, 109, 109, 97, 32, 111, 114, 32, 110, 101, 119, 108, 105, 110,
           101, 32, 98, 117, 116, 32, 103, 111, 116, 58, 32, 43, 10, 68, 101, 102, 105, 110, 105, 116, 105, 111, 110,
           115, 32, 109, 97, 121, 32, 98, 101, 32, 97, 116, 32, 109, 111, 115, 116, 32, 50, 48, 32, 99, 104, 97,
           114, 97, 99, 116, 101, 114, 115, 33, 10, 94, 62, 118, 60, 0, 1, 0, -1, -1, 0, 1, 0, 0, 0, 0, 0, 0, 1,
           20, 24, 0, 109, 4, 1201, -3, 0, 586, 21_002, 0, 1, -1, 22_101, 1, -3, -3, 21_102, 1, 0, -2, 2208, -2, -1,
           570, 1005, 570, 617, 2201, -3, -2, 609, 4, 0, 21_201, -2, 1, -2, 1106, 0, 597, 109, -4, 2105, 1, 0, 109,
           5, 2102, 1, -4, 630, 20_102, 1, 0, -2, 22_101, 1, -4, -4, 21_102, 1, 0, -3, 2208, -3, -2, 570, 1005, 570,
           781, 2201, -4, -3, 653, 20_101, 0, 0, -1, 1208, -1, -4, 570, 1005, 570, 709, 1208, -1, -5, 570, 1005, 570,
           734, 1207, -1, 0, 570, 1005, 570, 759, 1206, -1, 774, 1001, 578, 562, 684, 1, 0, 576, 576, 1001, 578, 566,
           692, 1, 0, 577, 577, 21_101, 702, 0, 0, 1105, 1, 786, 21_201, -1, -1, -1, 1105, 1, 676, 1001, 578, 1, 578,
           1008, 578, 4, 570, 1006, 570, 724, 1001, 578, -4, 578, 21_102, 1, 731, 0, 1105, 1, 786, 1106, 0, 774, 1001,
           578, -1, 578, 1008, 578, -1, 570, 1006, 570, 749, 1001, 578, 4, 578, 21_102, 1, 756, 0, 1105, 1, 786, 1106,
           0, 774, 21_202, -1, -11, 1, 22_101, 1182, 1, 1, 21_101, 0, 774, 0, 1105, 1, 622, 21_201, -3, 1, -3, 1105, 1,
           640, 109, -5, 2105, 1, 0, 109, 7, 1005, 575, 802, 21_002, 576, 1, -6, 21_002, 577, 1, -5, 1105, 1, 814,
           21_102, 1, 0, -1, 21_101, 0, 0, -5, 21_102, 1, 0, -6, 20_208, -6, 576, -2, 208, -5, 577, 570, 22_002, 570,
           -2, -2, 21_202, -5, 41, -3, 22_201, -6, -3, -3, 22_101, 1449, -3, -3, 2102, 1, -3, 843, 1005, 0, 863, 21_202,
           -2, 42, -4, 22_101, 46, -4, -4, 1206, -2, 924, 21_102, 1, 1, -1, 1105, 1, 924, 1205, -2, 873, 21_101, 0, 35,
           -4, 1105, 1, 924, 1202, -3, 1, 878, 1008, 0, 1, 570, 1006, 570, 916, 1001, 374, 1, 374, 2101, 0, -3, 895,
           1101, 0, 2, 0, 2102, 1, -3, 902, 1001, 438, 0, 438, 2202, -6, -5, 570, 1, 570, 374, 570, 1, 570, 438, 438,
           1001, 578, 558, 921, 21_002, 0, 1, -4, 1006, 575, 959, 204, -4, 22_101, 1, -6, -6, 1208, -6, 41, 570, 1006,
           570, 814, 104, 10, 22_101, 1, -5, -5, 1208, -5, 47, 570, 1006, 570, 810, 104, 10, 1206, -1, 974, 99, 1206,
           -1, 974, 1102, 1, 1, 575, 21_101, 0, 973, 0, 1105, 1, 786, 99, 109, -7, 2105, 1, 0, 109, 6, 21_102, 1, 0, -4,
           21_101, 0, 0, -3, 203, -2, 22_101, 1, -3, -3, 21_208, -2, 82, -1, 1205, -1, 1030, 21_208, -2, 76, -1, 1205,
           -1, 1037, 21_207, -2, 48, -1, 1205, -1, 1124, 22_107, 57, -2, -1, 1205, -1, 1124, 21_201, -2, -48, -2, 1106,
           0, 1041, 21_101, -4, 0, -2, 1106, 0, 1041, 21_102, -5, 1, -2, 21_201, -4, 1, -4, 21_207, -4, 11, -1, 1206,
           -1, 1138, 2201, -5, -4, 1059, 2101, 0, -2, 0, 203, -2, 22_101, 1, -3, -3, 21_207, -2, 48, -1, 1205, -1, 1107,
           22_107, 57, -2, -1, 1205, -1, 1107, 21_201, -2, -48, -2, 2201, -5, -4, 1090, 20_102, 10, 0, -1, 22_201, -2,
           -1, -2, 2201, -5, -4, 1103, 2102, 1, -2, 0, 1105, 1, 1060, 21_208, -2, 10, -1, 1205, -1, 1162, 21_208, -2,
           44, -1, 1206, -1, 1131, 1105, 1, 989, 21_101, 439, 0, 1, 1105, 1, 1150, 21_101, 0, 477, 1, 1105, 1, 1150,
           21_102, 514, 1, 1, 21_102, 1149, 1, 0, 1105, 1, 579, 99, 21_102, 1157, 1, 0, 1106, 0, 579, 204, -2, 104, 10,
           99, 21_207, -3, 22, -1, 1206, -1, 1138, 2102, 1, -5, 1176, 2102, 1, -4, 0, 109, -6, 2105, 1, 0, 22, 11, 30,
           1, 9, 1, 30, 1, 9, 1, 30, 1, 9, 1, 30, 1, 9, 1, 30, 1, 9, 1, 30, 1, 9, 5, 26, 1, 13, 1, 26, 1, 13, 1, 26, 1,
           13, 1, 10, 5, 5, 7, 13, 1, 10, 1, 3, 1, 5, 1, 19, 1, 10, 1, 3, 1, 5, 1, 11, 13, 6, 1, 3, 1, 5, 1, 11, 1, 7,
           1, 3, 12, 5, 1, 11, 1, 7, 1, 3, 2, 5, 1, 9, 1, 11, 1, 7, 1, 3, 2, 5, 1, 7, 5, 9, 1, 7, 6, 5, 1, 7, 1, 1, 1,
           1, 1, 9, 1, 12, 1, 5, 1, 7, 1, 1, 1, 1, 1, 9, 1, 12, 1, 5, 1, 7, 1, 1, 1, 1, 1, 9, 1, 12, 13, 1, 1, 1, 1, 1,
           1, 9, 1, 18, 1, 5, 1, 1, 1, 1, 1, 1, 1, 9, 1, 18, 11, 1, 11, 24, 1, 1, 1, 36, 11, 30, 1, 1, 1, 1, 1, 26, 5,
           5, 1, 1, 1, 1, 13, 14, 1, 3, 1, 5, 1, 1, 1, 13, 1, 14, 1, 3, 1, 5, 1, 1, 1, 13, 1, 14, 1, 3, 1, 5, 1, 1, 1,
           13, 1, 14, 13, 13, 1, 18, 1, 5, 1, 15, 1, 18, 1, 5, 1, 15, 11, 8, 1, 5, 1, 25, 1, 8, 1, 5, 1, 25, 1, 8, 1,
           5, 1, 25, 1, 8, 7, 25, 1, 40, 1, 40, 1, 40, 1, 40, 1, 40, 1, 34, 7, 34, 1, 40, 1, 40, 1, 40, 1, 10]
pointer = 0
@relative_base = 0
area = ''
@procedure_id = 'M'
@procedure_idx = 0

@main_procedure = ['A', ',', 'B', ',', 'A', ',', 'B', ',', 'A', ',', 'C', ',', 'B', ',', 'C', ',', 'A', ',', 'C']
@procedure_a = ['L', ',', '1', '0', ',', 'L', ',', '1', '2', ',', 'R', ',', '6']
@procedure_b = ['R', ',', '1', '0', ',', 'L', ',', '4', ',', 'L', ',', '4', ',', 'L', ',', '1', '2']
@procedure_c = ['L', ',', '1', '0', ',', 'R', ',', '1', '0', ',', 'R', ',', '6', ',', 'L', ',', '4']
@procedure_x = ['n']

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
    operand2 = "] = #{procedure_value}"
    param_count = 2
  when 4
    operand = 'area += '
    operand2 = '.chr'
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
  when 3, 4, 9
    # puts "OP_CODE: #{op_code}\tCOMMAND: #{command}\tPOINTER: #{pointer}\t#{operand}#{val1}#{operand2}"
    begin
      eval("#{operand}#{val1}#{operand2}")
    rescue RangeError => _e
      puts val1
    end
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

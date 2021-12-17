# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 16 Part 2
# https://adventofcode.com/2021/day/16#part2
# Answer is: 246225449979

# inputs = [
#   ['C200B40A82', 3],
#   ['04005AC33890', 54],
#   ['880086C3E88112', 7],
#   ['CE00C43D881120', 9],
#   ['D8005AC2A8F0', 1],
#   ['F600BC2D8F', 0],
#   ['9C005AC2F8F0', 0],
#   ['9C0141080250320F1802104A08', 1]
# ]
inputs = [File.readlines('../1 Input/day16.input')[0].strip]

def parse_packet(binary, i)
  return if binary[i..].split('').all?('0')

  puts '-----------------------' if @debug
  puts "parse packet #{i}" if @debug
  puts binary[i..] if @debug
  # packet_version = binary[i, 3].to_i(2)
  i += 3
  packet_type = binary[i, 3].to_i(2)
  i += 3

  puts '-----------------------' if @debug
  if packet_type == 4
    puts "parse literal #{i}" if @debug
    a, value = parse_literal(binary[i..], 0)
    i += a
    puts "after parse literal #{i}" if @debug
  else
    puts "parse operator #{i}" if @debug
    a, value = parse_operator(binary[i..], 0, packet_type)
    i += a
    puts "after parse operator #{i}" if @debug
  end

  [i, value]
end

def parse_literal(binary, i)
  bin_value = ''
  loop do
    last = binary[i]
    i += 1
    bin_value += binary[i, 4]
    i += 4
    break if last == '0'
  end
  puts bin_value.to_i(2) if @debug

  [i, bin_value.to_i(2)]
end

def parse_operator(binary, i, operator)
  values = []
  length_type = binary[i]
  i += 1

  if length_type == '0' # bits count - 15 bit-number
    amount = binary[i, 15].to_i(2)
    i += 15
  else # sub-packets count - 11 bit-number
    amount = binary[i, 11].to_i(2)
    i += 11
  end

  puts '-----------------------' if @debug
  if length_type == '0'
    puts "parse #{amount} bits of subpackets #{i}" if @debug
    a = 0
    while amount.positive?
      puts "#{amount} of subpackets bits left" if @debug
      a, value = parse_packet(binary[i, amount], 0)
      amount -= a
      values << value
      break if a.nil?

      puts "move i by #{a}" if @debug
      i += a
    end
  else
    puts "parse #{amount} subpackets #{i}" if @debug
    amount.times do |k|
      puts "parse subpacket no #{k + 1}" if @debug
      a, value = parse_packet(binary[i..], 0)
      values << value
      i += a
    end
  end

  operator_value = 0
  case operator
  when 0 # sum
    operator_value = values.sum
  when 1 # product
    operator_value = values.inject(:*)
  when 2 # min
    operator_value = values.min
  when 3 # max
    operator_value = values.max
  when 5 # greater than
    operator_value = values[0] > values[1] ? 1 : 0
  when 6 # less than
    operator_value = values[0] < values[1] ? 1 : 0
  when 7 # equal
    operator_value = values[0] == values[1] ? 1 : 0
  end

  [i, operator_value]
end

hex_to_bin = {
  '0' => '0000',
  '1' => '0001',
  '2' => '0010',
  '3' => '0011',
  '4' => '0100',
  '5' => '0101',
  '6' => '0110',
  '7' => '0111',
  '8' => '1000',
  '9' => '1001',
  'A' => '1010',
  'B' => '1011',
  'C' => '1100',
  'D' => '1101',
  'E' => '1110',
  'F' => '1111'
}

inputs.each do |input|
  binary = ''
  @debug = false

  if input.length == 2
    input[0].split('').each do |hex|
      binary += hex_to_bin[hex]
    end

    puts "xxxxxxxx INPUT #{input[0]} xxxxxxxxxx" if @debug
    _i, value = parse_packet(binary, 0)
    puts if @debug
    puts "INPUT VALUE: #{value} | #{value == input[1] ? 'OK' : 'BAD'}"
  else
    input.split('').each do |hex|
      binary += hex_to_bin[hex]
    end

    puts "xxxxxxxx INPUT #{input} xxxxxxxxxx" if @debug
    _i, value = parse_packet(binary, 0)
    puts if @debug
    puts value
  end
  puts if @debug
end

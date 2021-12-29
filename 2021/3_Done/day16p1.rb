# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 16 Part 1
# https://adventofcode.com/2021/day/16
# Answer is: 953

# inputs = [['D2FE28', 6],
#           ['38006F45291200', 9],
#           ['EE00D40C823060', 14],
#           ['8A004A801A8002F478', 16],
#           ['620080001611562C8802118E34', 12],
#           ['C0015000016115A2E0802F182340', 23],
#           ['A0016C880162017C3686B18A3D4780', 31]]
inputs = [File.readlines('../1_Input/day16.input')[0].strip]

def parse_packet(binary, i)
  return if binary[i..].split('').all?('0')

  puts '-----------------------' if @debug
  puts "parse packet #{i}" if @debug
  puts binary[i..] if @debug
  @version_sum += binary[i, 3].to_i(2)
  i += 3
  packet_type = binary[i, 3].to_i(2)
  i += 3

  puts '-----------------------' if @debug
  if packet_type == 4
    puts "parse literal #{i}" if @debug
    i += parse_literal(binary[i..], 0)
    puts "after parse literal #{i}" if @debug
  else
    puts "parse operator #{i}" if @debug
    i += parse_operator(binary[i..], 0)
    puts "after parse operator #{i}" if @debug
  end

  i
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
  i
end

def parse_operator(binary, i)
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
      a = parse_packet(binary[i, amount], 0)
      amount -= a
      break if a.nil?

      puts "move i by #{a}" if @debug
      i += a
    end
  else
    puts "parse #{amount} subpackets #{i}" if @debug
    amount.times do |k|
      puts "parse subpacket no #{k + 1}" if @debug
      i += parse_packet(binary[i..], 0)
    end
  end

  i
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
  @version_sum = 0
  @debug = false

  if input.length == 2
    input[0].split('').each do |hex|
      binary += hex_to_bin[hex]
    end

    puts "xxxxxxxx INPUT #{input[0]} xxxxxxxxxx" if @debug
    parse_packet(binary, 0)
    puts if @debug
    puts "VERSION SUM: #{@version_sum} | #{@version_sum == input[1] ? 'OK' : 'BAD'}"
  else
    input.split('').each do |hex|
      binary += hex_to_bin[hex]
    end

    puts "xxxxxxxx INPUT #{input} xxxxxxxxxx" if @debug
    parse_packet(binary, 0)
    puts if @debug
    puts @version_sum
  end
  puts if @debug
end

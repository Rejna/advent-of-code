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
inputs = ['6053231004C12DC26D00526BEE728D2C013AC7795ACA756F93B524D8000AAC8FF80B3A7A4016F6802D35C7C94C8AC97AD81D30024C00D1003C80AD050029C00E20240580853401E98C00D50038400D401518C00C7003880376300290023000060D800D09B9D03E7F546930052C016000422234208CC000854778CF0EA7C9C802ACE005FE4EBE1B99EA4C8A2A804D26730E25AA8B23CBDE7C855808057C9C87718DFEED9A008880391520BC280004260C44C8E460086802600087C548430A4401B8C91AE3749CF9CEFF0A8C0041498F180532A9728813A012261367931FF43E9040191F002A539D7A9CEBFCF7B3DE36CA56BC506005EE6393A0ACAA990030B3E29348734BC200D980390960BC723007614C618DC600D4268AD168C0268ED2CB72E09341040181D802B285937A739ACCEFFE9F4B6D30802DC94803D80292B5389DFEB2A440081CE0FCE951005AD800D04BF26B32FC9AFCF8D280592D65B9CE67DCEF20C530E13B7F67F8FB140D200E6673BA45C0086262FBB084F5BF381918017221E402474EF86280333100622FC37844200DC6A8950650005C8273133A300465A7AEC08B00103925392575007E63310592EA747830052801C99C9CB215397F3ACF97CFE41C802DBD004244C67B189E3BC4584E2013C1F91B0BCD60AA1690060360094F6A70B7FC7D34A52CBAE011CB6A17509F8DF61F3B4ED46A683E6BD258100667EA4B1A6211006AD367D600ACBD61FD10CBD61FD129003D9600B4608C931D54700AA6E2932D3CBB45399A49E66E641274AE4040039B8BD2C933137F95A4A76CFBAE122704026E700662200D4358530D4401F8AD0722DCEC3124E92B639CC5AF413300700010D8F30FE1B80021506A33C3F1007A314348DC0002EC4D9CF36280213938F648925BDE134803CB9BD6BF3BFD83C0149E859EA6614A8C']

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

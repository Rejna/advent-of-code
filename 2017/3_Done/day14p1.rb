# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 14 Part 1
# https://adventofcode.com/2017/day/14
# Answer is: 8304

def hex_to_int(hex)
  case hex
  when '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
    hex.to_i
  when 'a'
    10
  when 'b'
    11
  when 'c'
    12
  when 'd'
    13
  when 'e'
    14
  when 'f'
    15
  end
end

# raw_input = 'hwlqcszp'
# output_file = '../1_Input/day14.memory'
raw_input = 'flqrgnkx'
output_file = '../1_Input/day14test.memory'
hashes = []

128.times.each do |row|
  input = "#{raw_input}-#{row}".split('').map(&:ord) + [17, 31, 73, 47, 23]

  list = [*0..255]

  current_position = 0
  skip_size = 0

  64.times.each do
    input.each do |length|
      temp = {}

      i = 0
      while i < length
        temp[(current_position + i) % list.length] = list[(current_position + i) % list.length]
        i += 1
      end

      i = 0
      temp.each do |k, _v|
        list[k] = temp.values[temp.length - 1 - i]
        i += 1
      end

      current_position = (length + skip_size + current_position) % list.length
      skip_size += 1
    end
  end

  sparse_hash = list
  dense_hash = []
  i = 0
  while i < 256
    dense_hash << sparse_hash[i, 16].reduce(:^)
    i += 16
  end

  final_result = ''
  dense_hash.each do |x|
    final_result += x.to_s(16).rjust(2, '0')
  end

  hashes << final_result
end

bins = []
hashes.each do |hash|
  h = hash.split('')
  bin = ''

  h.each do |hex|
    bin += hex_to_int(hex).to_s(2).rjust(4, '0')
  end
  bins << bin
end

puts bins.flatten.join('').split('').tally['1']

File.open(output_file, 'w') do |file|
  bins.each do |bin|
    bin.split('').each do |b|
      file.write('#') if b == '1'
      file.write('.') if b == '0'
    end
    file.write("\n")
  end
end

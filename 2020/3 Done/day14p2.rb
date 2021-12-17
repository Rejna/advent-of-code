# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 14 Part 2
# https://adventofcode.com/2020/day/14#part2
# Answer is: 2737766154126

# input = ['mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X', 'mem[8] = 11', 'mem[7] = 101', 'mem[8] = 0']
input = File.readlines('../1 Input/day14.input').map(&:strip)
@mask = ''
mem = {}

def apply_mask(input)
  input_bin = input.to_s(2).rjust(36, '0').split('')
  mask = @mask.split('')
  floats = 0
  i = 0
  output = []

  while i < 36
    case mask[i]
    when '0'
      input_bin[i] = input_bin[i]
    when '1'
      input_bin[i] = '1'
    else
      input_bin[i] = 'X'
      floats += 1
    end
    i += 1
  end

  i = 0
  while i < 2**floats
    i_bin = i.to_s(2).rjust(floats, '0').split('')
    k = 0
    j = 0
    temp_bin = [*input_bin]
    while j < 36
      if temp_bin[j] == 'X'
        temp_bin[j] = i_bin[k]
        k += 1
      end
      j += 1
    end
    output << temp_bin.join('').to_i(2)
    i += 1
  end
  output
end

input.each do |line|
  line = line.split(' = ')

  if line[0] == 'mask'
    @mask = line[1]
  else
    address = line[0].gsub!('mem[', '').gsub!(']', '').to_i
    data = line[1].to_i
    addresses = apply_mask(address)
    addresses.each do |a|
      mem[a] = data
    end
  end
end

puts mem.values.sum
